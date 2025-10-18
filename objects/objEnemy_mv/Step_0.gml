/// objEnemy_mv.Step

t++;

var px = instance_exists(obj_Player1) ? obj_Player1.x : x;
var py = instance_exists(obj_Player1) ? obj_Player1.y : y;

// camera bounds for off-screen cleanup
var cam = view_get_camera(0);
var vx  = camera_get_view_x(cam);
var vy  = camera_get_view_y(cam);
var vw  = camera_get_view_width(cam);
var vh  = camera_get_view_height(cam);
var margin = 64;

// --------- MODE BEHAVIOURS ---------
switch (mode) {
    // 1) Ceiling drill: spins and accelerates downward from ceiling
    case ENEMY_MV_MODE.SKY_DRILL:
        image_angle += spin_spd;
        vsp += drop_acc;
        break;

    // 2) Lava ball: shoots up (or down) then falls off-screen
    case ENEMY_MV_MODE.LAVA_BALL:
        vsp += grav; // grav was signed in Create; this curves trajectory back
        break;

    // 3) Bouncer: hops toward player when on ground
    case ENEMY_MV_MODE.BOUNCER_CHASE: {
        var on_ground = place_meeting(x, y + 1, objGround_mv);
        // aim x toward player
        var dir = sign(px - x);
        hsp = dir * run_spd;

        if (on_ground) {
            if (hop_timer > 0) hop_timer--; else {
                vsp = jump_spd;
                hop_timer = hop_cool;
            }
        } else {
            vsp += grav; // falling
        }
    } break;

    // 4) Homer straight: steer directly toward player
    case ENEMY_MV_MODE.HOMER_STRAIGHT: {
        var ang = point_direction(x, y, px, py);
        hsp += lengthdir_x(accel, ang);
        vsp += lengthdir_y(accel, ang);
        var spd = point_distance(0,0,hsp,vsp);
        if (spd > max_spd) {
            var s = max_spd / spd;
            hsp *= s; vsp *= s;
        }
    } break;

    // 5) Homer drift: home with a loose drift
    case ENEMY_MV_MODE.HOMER_DRIFT: {
        // target = mostly player, slightly biased by current velocity to create arcs
        var tx = lerp(px, x + hsp*10, drift_bias);
        var ty = lerp(py, y + vsp*10, drift_bias);
        var ang = point_direction(x, y, tx, ty);
        hsp += lengthdir_x(accel, ang);
        vsp += lengthdir_y(accel, ang);
        var spd = point_distance(0,0,hsp,vsp);
        if (spd > max_spd) {
            var s = max_spd / spd;
            hsp *= s; vsp *= s;
        }
    } break;

    // 6) Gravity switcher: crawls floor/ceiling; occasionally flips gravity
    case ENEMY_MV_MODE.GRAV_SWITCHER: {
        // Crawl along surface in x toward player
        var dir = sign(px - x);
        hsp = dir * crawl_spd;

        // simulate pull toward the active surface
        vsp += 0.6 * grav_dir;

        // stick to floor/ceiling surfaces
        if (grav_dir == 1) {
            // sticking to floor
            if (place_meeting(x, y + vsp, objGround_mv)) {
                while (!place_meeting(x, y + sign(vsp), objGround_mv)) y += sign(vsp);
                vsp = 0;
            }
        } else {
            // sticking to ceiling
            if (place_meeting(x, y + vsp, objCeil_mv)) {
                while (!place_meeting(x, y + sign(vsp), objCeil_mv)) y += sign(vsp);
                vsp = 0;
            }
        }

        // flip condition: timer + rough distance or random spice
        if (switch_timer > 0) switch_timer--; else {
            var want_flip = (abs(py - y) > 120) || (irandom(100) < 8);
            if (want_flip) {
                grav_dir *= -1;
                switch_timer = switch_cd;
            }
        }
    } break;

    // 7) Pot turret: optional slow patrol + periodic fire or laser
    case ENEMY_MV_MODE.POT_TURRET: {
        // optional soft patrol toward/away from player for life
        hsp = sign(px - x) * patrol_spd * 0.5;

        if (fire_timer > 0) fire_timer--; else {
            fire_timer = max(min_fire_delay, fire_delay);

            if (use_laser) {
                // brief laser burst straight in facing direction (up or down)
                var ang = faces_up ? -90 : 90;
                // simple hit-scan: deal damage along line (adjust to your damage system)
                var lx = x, ly = y;
                var lx2 = x + lengthdir_x(900, ang);
                var ly2 = y + lengthdir_y(900, ang);
                // Example: create a transient laser effect object if you have one
                // instance_create_layer(lx, ly, layer_get_name(layer), objLaserFx).dir = ang;
                // Damage players/enemies along line as needed...
            } else {
                // shoot a projectile at player
                if (instance_exists(obj_Player1)) {
                    var ang = point_direction(x,y,px,py);
                    var b = instance_create_layer(x, y, layer_get_name(layer), objEnemyBullet_mv);
                    with (b) {
                        dir = ang;
                        spd = other.projectile_spd;
                        damage = other.damage; // inherit parent’s damage
                    }
                }
            }
        }
    } break;
}

// --------- APPLY MOVEMENT ---------
x += hsp;
y += vsp;

// --------- DESPAWN OFF-SCREEN (generous margin) ---------
if (x < vx - margin || x > vx + vw + margin || y < vy - margin || y > vy + vh + margin*1.5) {
    instance_destroy();
}
