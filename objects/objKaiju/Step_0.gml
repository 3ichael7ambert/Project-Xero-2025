/// ===== objKaiju : Step =====

if (dead) exit;

function _wrap_deg(a) {
    a = a mod 360;
    if (a < 0) a += 360;
    return a;
}



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

    // --- pick a steering direction and desired speed based on range ---
    var desired_dir = image_angle; // we don't rotate the sprite, but use dir for movement
    var desired_spd = 0;

    if (instance_exists(pl)) {
        var dir_to = point_direction(x, y, pl.x, pl.y);
        var dst    = point_distance(x, y, pl.x, pl.y);

        // switch strafe bias sometimes when very close to avoid sticking
        if (dst < repel_radius + 40) {
            if (orbit_switch_cd <= 0) { orbit_dir = -orbit_dir; orbit_switch_cd = orbit_switch_max; }
        }
        if (orbit_switch_cd > 0) orbit_switch_cd--;

        // 1) Too close: push BACK (away) + strafe
        if (dst <= repel_radius) {
            // Base push back
            desired_dir = dir_to + 180;
            desired_spd = repel_speed;

            // Add strafe component ±60°
            desired_dir = _wrap_deg(desired_dir + orbit_dir * 60);


            // Occasionally dash THROUGH or AWAY to break patterns
            if (dash_time <= 0 && irandom(120) == 0) {
                dash_time = dash_time_max;
                // 50/50 toward or away
                if (choose(true, false)) {
                    desired_dir = dir_to;         // toward for aggression burst
                    desired_spd = dash_speed;
                } else {
                    desired_dir = dir_to + 180;   // away burst
                    desired_spd = dash_speed;
                }
            }
        }
        // 2) Engaged but not too close: approach + mild strafe
        else if (dst <= chase_radius) {
            desired_dir = dir_to + orbit_dir * 20; // slight orbit as we approach
            desired_spd = chase_speed;
        }
        // 3) Idle roam toward player
        else {
            desired_dir = dir_to;
            desired_spd = root_move_speed;
        }
    }

    // decay dash timer
    if (dash_time > 0) {
        dash_time--;
        desired_spd = max(desired_spd, dash_speed); // keep dash speed while active
    }

    // --------- state machine: ground vs air ----------
    // Decide to takeoff or land
    if (can_fly) {
        if (state == "ground") {
            // try taking off occasionally or if stuck
            fly_cd--;
            var on_ground = place_meeting(x, y + 1, objSidewalk);
            if (fly_cd <= 0 || (!on_ground && vsp > 3)) {
                state = "air";
                target_altitude = irandom_range(140, 220);
                fly_cd = irandom_range(300, 480);
                land_cd = irandom_range(240, 360);
            }
        } else if (state == "air") {
            land_cd--;
            // if far from player or timer elapsed, prepare to land
            if (!instance_exists(pl) || land_cd <= 0 || point_distance(x, y, pl.x, pl.y) > chase_radius + 200) {
                target_altitude = 0; // descend
            }
            // when we are low & above ground, land
            if (target_altitude <= 0) {
                // check for ground below; if close, snap
                if (place_meeting(x, y + 4, objSidewalk)) {
                    state = "ground";
                    vsp = 0;
                }
            }
        }
    }

    // ---------- apply movement per state ----------
    if (state == "air") {
        // steer gently in air
        var cur_dir = point_direction(0, 0, lengthdir_x(1, 0), lengthdir_y(1, 0)); // dummy to keep compiler happy
        // we don't track an air-facing; just move on desired_dir
        x += lengthdir_x(air_speed + (dash_time > 0 ? 1.2 : 0), desired_dir);
        y += lengthdir_y(air_speed + (dash_time > 0 ? 1.2 : 0), desired_dir);

        // altitude as simple y-offset controller: move y opposite to "altitude"
        // (We just nudge y up/down to simulate altitude; real z would need layering.)
        if (target_altitude > 0) {
            y -= ascend_rate;
            if (y <= target_altitude) target_altitude = target_altitude; // keep
        } else {
            y += descend_rate;
        }
    }
    else { // ---- GROUND ----
        // ground steering -> turn desired_dir into hsp/vsp components with simple collision
        var spd = ground_speed;
        // If we're repelling or dashing, honor desired_spd
        spd = max(spd, desired_spd);

        // Friction
        hsp = hsp * fric + lengthdir_x(spd, desired_dir) * (1 - fric);
        vsp += grav;

        // Horizontal move with simple step-up
        if (place_meeting(x + sign(hsp), y, objSidewalk)) {
            // try stepping up small ledges
            var stepped = false;
            for (var s = 1; s <= ground_step_up; s++) {
                if (!place_meeting(x + sign(hsp), y - s, objSidewalk)) {
                    y -= s;
                    x += sign(hsp);
                    stepped = true;
                    break;
                }
            }
            if (!stepped) hsp = 0;
        } else {
            x += hsp;
        }

        // Vertical move / ground snap
        if (place_meeting(x, y + vsp, objSidewalk)) {
            while (!place_meeting(x, y + sign(vsp), objSidewalk)) {
                y += sign(vsp);
            }
            vsp = 0;
        } else {
            y += vsp;
        }
    }

    // share target for children
    if (instance_exists(pl)) { target_x = pl.x; target_y = pl.y; }

    // win check (unchanged)
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
    // -------------------- HANDS: place at wrist + aim with wrist clamp + shoot --------------------
case KaijuRole.HAND_L:
case KaijuRole.HAND_R:
{
    if (!instance_exists(parent_ref)) { instance_destroy(); break; } // parent_ref = LOWER ARM
    var lower = parent_ref;

    // --- Place the hand using its actual local offset relative to LOWER ---
    // (This preserves any sideways offset you set in the blueprint.)
    var r_hand  = point_distance(0, 0, local_x, local_y);
    var a_hand  = point_direction(0, 0, local_x, local_y);
    x = lower.x + lengthdir_x(r_hand, lower.image_angle + a_hand);
    y = lower.y + lengthdir_y(r_hand, lower.image_angle + a_hand);

    // --- Aim with a wrist constraint (prevents "breaking") ---
    var pl = instance_nearest(x, y, core_root.target_obj);
    var aim_dir;
    if (instance_exists(pl)) aim_dir = point_direction(x, y, pl.x, pl.y); else aim_dir = lower.image_angle;

    // how far the wrist *wants* to twist away from the forearm
    var rel = angle_difference(lower.image_angle, aim_dir);

    // clamp wrist twist to a sensible cone around the forearm
    // tweak these per taste (e.g., 40..70)
    var max_wrist_twist = 55;

    // optionally smooth the twist so it doesn't snap
    var target_rel = clamp(rel, -max_wrist_twist, max_wrist_twist);
    var cur_rel    = angle_difference(lower.image_angle, image_angle);
    var step_rel   = clamp(target_rel - cur_rel, -6, 6); // max 6°/step change
    var new_rel    = cur_rel + step_rel;

    // RIGHT-facing art (0° = east). If your hand sprite faces UP at 0°, subtract 90.
    image_angle = lower.image_angle + new_rel;
    // image_angle = lower.image_angle + new_rel - 90; // <-- use this if your sprites are UP-facing

    // --- Fire straight along the hand's final aim ---
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
