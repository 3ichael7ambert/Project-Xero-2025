/// ===== objKaiju : Step =====

if (dead) exit;

/// --- Tiny IK helper (local to this event) ---
/// returns [shoulder_angle_deg, elbow_bend_deg]
function solve_arm_ik_deg(sx, sy, tx, ty, L1, L2) {
    var dx   = tx - sx, dy = ty - sy;
    var dist = point_distance(0, 0, dx, dy);
    dist = clamp(dist, 1, max(1, L1 + L2 - 1));

    var A = arccos(clamp((sqr(L1) + sqr(dist) - sqr(L2)) / (2 * L1 * dist), -1, 1));
    var B = arccos(clamp((sqr(L1) + sqr(L2) - sqr(dist)) / (2 * L1 * L2),   -1, 1));

    var base = point_direction(sx, sy, tx, ty); // degrees
    var shoulder = base - radtodeg(A);
    var elbow    = 180 - radtodeg(B);
    return [shoulder, elbow];
}


// ---------- ROOT: targeting, movement, win condition ----------
if (is_root) {
    var pl = instance_nearest(x, y, target_obj);
    if (instance_exists(pl)) {
        // move toward player WITHOUT rotating the body
        var desired = point_direction(x, y, pl.x, pl.y);
        x += lengthdir_x(root_move_speed, desired);
        y += lengthdir_y(root_move_speed, desired);

        target_x = pl.x; target_y = pl.y;
    }

    // win check
    var all_down = true;
    for (var i = 0; i < ds_list_size(required_parts); i++) {
        var prt = required_parts[| i];
        if (instance_exists(prt) && !prt.dead) { all_down = false; break; }
    }
    if (all_down) { dead = true; event_user(0); }
    exit;
}


// ---------- CHILD LOGIC ----------
switch (role) {

    // --------- GENERIC MECH FOLLOW (EXCLUDES LOWER ARMS, HANDS, HEAD) ---------
    case KaijuRole.CORE:
    case KaijuRole.TORSO_U:
    case KaijuRole.TORSO_L:
    case KaijuRole.ARM_U_L:
    case KaijuRole.ARM_U_R:
    case KaijuRole.THIGH_L:
    case KaijuRole.CALF_L:
    case KaijuRole.FOOT_L:
    case KaijuRole.THIGH_R:
    case KaijuRole.CALF_R:
    case KaijuRole.FOOT_R:
    case KaijuRole.WING_L:
    case KaijuRole.WING_R:
    {
        if (!instance_exists(parent_ref)) { instance_destroy(); break; }

        var bx = parent_ref.x, by = parent_ref.y, ba = parent_ref.image_angle;
        var r   = point_distance(0,0, local_x, local_y);
        var ang = point_direction(0,0, local_x, local_y);

        x = bx + lengthdir_x(r, ba + ang);
        y = by + lengthdir_y(r, ba + ang);

        // NOTE: root doesn't rotate, so 'ba' will typically be 0; keep logic generic anyway
        image_angle = (follow_parent_ang ? ba : 0) + local_ang;
    }
    break;


    // -------------------- LOWER ARMS (IK bend) --------------------
    case KaijuRole.ARM_L_L: // left lower arm
    case KaijuRole.ARM_L_R: // right lower arm
    {
        // parent_ref = upper arm; upper.parent_ref = torso (shoulder anchor)
        if (!instance_exists(parent_ref)) { instance_destroy(); break; }
        var upper = parent_ref;

        // Shoulder world position (upper arm origin)
        var sx = upper.x, sy = upper.y;

        // Target to reach
        var tx = core_root.target_x;
        var ty = core_root.target_y;

        // Link lengths:
        //  L1 = shoulder->elbow (this lower arm's local offset from upper)
        //  L2 = elbow->wrist (hand offset from lower), default if not stored
        var L1 = max(1, point_distance(0, 0, local_x, local_y)); // lower's local offset is from upper
        var L2 = 48;
        if (variable_instance_exists(self, "L2")) L2 = max(1, L2);
        // If you stored LL.L2 in Create, it will be used. Otherwise 48px default.

        // Solve IK
        var A = solve_arm_ik_deg(sx, sy, tx, ty, L1, L2);
        var shoulder_ang = A[0];
        var elbow_bend   = A[1];

        // Apply angles (sprites 0° = RIGHT; if UP-facing, subtract 90 where noted)
        upper.image_angle = shoulder_ang;              // shoulder rotation
        image_angle       = shoulder_ang + elbow_bend; // lower bends from upper

        // Place LOWER at the elbow joint (end of upper link)
        x = sx + lengthdir_x(L1, upper.image_angle);
        y = sy + lengthdir_y(L1, upper.image_angle);
    }
    break;


    // -------------------- HANDS: place at wrist + aim + shoot --------------------
    case KaijuRole.HAND_L:
    case KaijuRole.HAND_R:
    {
        if (!instance_exists(parent_ref)) { instance_destroy(); break; } // parent_ref = lower arm
        var lower = parent_ref;

        // elbow->wrist length (same L2 as used above)
        var L2 = 48;
        if (variable_instance_exists(lower, "L2")) L2 = max(1, lower.L2);

        // Wrist world position = end of lower arm
        var wx = lower.x + lengthdir_x(L2, lower.image_angle);
        var wy = lower.y + lengthdir_y(L2, lower.image_angle);

        // Place hand
        x = wx; y = wy;

        // Aim independently at target
        var pl = instance_nearest(x, y, core_root.target_obj);
        if (instance_exists(pl)) {
            var dir = point_direction(x, y, pl.x, pl.y);
            image_angle = dir;            // RIGHT-facing art
            // image_angle = dir - 90;    // <-- if your sprites face UP at 0°
        } else {
            // fallback: align with lower
            image_angle = lower.image_angle;
        }

        // Shoot
        if (fire_cd > 0) fire_cd--;
        if (fire_cd <= 0 && instance_exists(pl)) {
            var b = instance_create_layer(x, y, core_root.bullet_layer, objBullet_Kaiju);
            with (b) {
                direction   = other.image_angle;
                speed       = 8;
                damage      = 10;
                image_angle = direction;
            }
            fire_cd = max(6, fire_cd_max);
        }
    }
    break;


    // --------------------- HEAD: follow + aim + shoot --------------------
    case KaijuRole.HEAD:
    {
        if (!instance_exists(parent_ref)) { instance_destroy(); break; }

        // Position head by bone follow (no parent rotation on root, but keep generic)
        var bx = parent_ref.x, by = parent_ref.y, ba = parent_ref.image_angle;
        var r   = point_distance(0,0, local_x, local_y);
        var ang = point_direction(0,0, local_x, local_y);
        x = bx + lengthdir_x(r, ba + ang);
        y = by + lengthdir_y(r, ba + ang);

        // Aim independently
        var pl = instance_nearest(x, y, core_root.target_obj);
        if (instance_exists(pl)) {
            var dir = point_direction(x, y, pl.x, pl.y);
            image_angle = dir;            // RIGHT-facing art
            // image_angle = dir - 90;    // <-- if your sprites face UP at 0°
        } else {
            image_angle = local_ang;
        }

        // Shoot
        if (fire_cd > 0) fire_cd--;
        if (fire_cd <= 0 && instance_exists(pl)) {
            var b = instance_create_layer(x, y, core_root.bullet_layer, objBullet_Kaiju);
            with (b) {
                direction   = other.image_angle;
                speed       = 7;
                damage      = 18;
                image_angle = direction;
            }
            fire_cd = max(12, fire_cd_max);
        }
    }
    break;


    // ---------------- DRAGON (if you enable it later) ---------------
    case KaijuRole.DRAGON_HEAD:
    {
        var pl = instance_nearest(x, y, core_root.target_obj);
        if (instance_exists(pl)) {
            var desired = point_direction(x, y, pl.x, pl.y);
            image_angle = _ang_move_to(image_angle, desired, turn_rate);
        }
        var wave = sin(current_time * 0.004) * wiggle_k;
        var ang  = image_angle + wave;
        x += lengthdir_x(move_speed, ang);
        y += lengthdir_y(move_speed, ang);
    }
    break;

    case KaijuRole.DRAGON_SEG:
    {
        if (!instance_exists(parent_ref)) { instance_destroy(); break; }
        var tx = parent_ref.x, ty = parent_ref.y;
        var dir  = point_direction(x, y, tx, ty);
        var dist = point_distance(x, y, tx, ty);
        var step = max(0, dist - target_dist);
        x += lengthdir_x(step, dir);
        y += lengthdir_y(step, dir);
        image_angle = dir;
    }
    break;
}
