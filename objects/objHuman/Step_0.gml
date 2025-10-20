//// @description Step (jetpack-enabled)

// ---------------------
// 0) Display/frame indices (yours)
img_idx_body=image_index;
img_idx_pants=image_index;
img_idx_shirt_sleeves=image_index;
img_idx_shoes=image_index;
img_idx_head=0;
img_idx_nose=0;
img_idx_eyes=0;
img_idx_eyelids=0;
img_idx_nose=0;
img_idx_hair=0;
img_idx_hair=0;

// ---------------------
// 1) Jetpack tuning + scratch (ensure once)
/*
if (!variable_instance_exists(self,"jp_speed")) {
    jp_speed      = 4.5;   // cruise speed
    jp_boost      = 7.5;   // fast close-in speed
    jp_accel      = 0.28;  // steering strength (0..1)
    jp_drag       = 0.03;  // air drag per step (0..0.2)
    jp_orbit_v    = 24;    // vertical bias while orbiting
    jp_idle_drift = 1.0;   // wander speed out of combat
}
*/

if (!variable_instance_exists(self,"fly_goal_x")) {
    fly_goal_x = x; fly_goal_y = y; fly_goal_timer = 0;
}

// Jetpack runtime flag
var using_jetpack = jetpack || ufo; // UFOs always fly


// ---------------------
// 2) Threat / target system (yours)
if (!variable_instance_exists(self,"threat_map") || is_undefined(threat_map) || !ds_exists(threat_map, ds_type_map)) {
    threat_map = ds_map_create();
}
if (poi != noone) { target = poi; poi = noone; }

if (!is_real(target)) target = noone;
if (!is_real(poi))    poi    = noone;

if (!variable_instance_exists(self,"threat_map") || is_undefined(threat_map) || !ds_exists(threat_map, ds_type_map)) {
    threat_map = ds_map_create();
}
if (poi != noone) { target = poi; poi = noone; }

if (ds_map_size(threat_map) > 0) provoked = true;
if (alert_timer > 0) alert_timer--; else alert_timer = 0;
if (alert_timer == 0 && ds_map_size(threat_map) == 0) provoked = false;

if (!instance_exists(target)) {
    target = noone;
    if (ds_exists(threat_map, ds_type_map) && ds_map_size(threat_map) > 0) {
        var best_id  = noone;
        var best_val = -1000000000;
        var k = ds_map_find_first(threat_map);
        while (k != undefined) {
            var inst_id = real(k);
            if (instance_exists(inst_id)) {
                var val = threat_map[? k];
                if (val > best_val) { best_val = val; best_id = inst_id; }
                k = ds_map_find_next(threat_map, k);
            } else {
                var nxt = ds_map_find_next(threat_map, k);
                ds_map_delete(threat_map, k);
                k = nxt;
            }
        }
        target = best_id;
    }
}

if (ds_exists(threat_map, ds_type_map) && ds_map_size(threat_map) > 0) {
    var k2 = ds_map_find_first(threat_map);
    while (k2 != undefined) {
        var nxt = ds_map_find_next(threat_map, k2);
        var v = max(0, threat_map[? k2] - 0.1);
        if (v <= 0) ds_map_delete(threat_map, k2); else threat_map[? k2] = v;
        k2 = nxt;
    }
}


/// --- UFO-specific behavior: hover over targets + shoot down ---
if (ufo) {
    // --- Movement ---
   // var want_vx = 0;
   // var want_vy = 0;
   
	   // --- Altitude bounds (room-aware & ground-aware) ---
	var ceiling_y = ufo_ceiling_margin;

	// Probe straight down to find the ground directly beneath the UFO.
	// If your ground uses a different object, swap objSidewalk.
	var ginst = collision_line(x, y, x, ufo_floor_probe_max, objSidewalk, false, true);
	var floor_y = (ginst != noone) ? ginst.bbox_top : room_height;

	// The lowest y the UFO is allowed to be:
	var lower_y = floor_y - ufo_ground_clearance;

	// Safety: if level has no sidewalk under us (rare), still keep some room margin
	if (ginst == noone) lower_y = room_height - ufo_ground_clearance;


    if (instance_exists(target)) {
    var tx = target.x;
    var ty = target.y - ufo_hover_h;

    // Keep the desired hover point inside allowed altitude
    ty = clamp(ty, ceiling_y, lower_y);

    var dist_to_perch = point_distance(x, y, tx, ty);
    var a             = point_direction(x, y, tx, ty);
    var approach_spd  = min(ufo_max_spd, max(1, dist_to_perch * 0.08));

    want_vx = lengthdir_x(approach_spd, a);
    want_vy = lengthdir_y(approach_spd, a);
}  else {
        // No target → gentle wander/idle drift
        if (fly_goal_timer <= 0) {
            var r   = irandom_range(64, ufo_patrol_r);
            var ang = irandom(359);
            fly_goal_x = x + lengthdir_x(r, ang);
            fly_goal_y = y + lengthdir_y(r, ang);
            fly_goal_timer = irandom_range(room_speed, room_speed * 2);
        } else {
            fly_goal_timer--;
        }
        var a2 = point_direction(x, y, fly_goal_x, fly_goal_y);
        want_vx = lengthdir_x(ufo_idle_drift, a2);
        want_vy = lengthdir_y(ufo_idle_drift, a2);
    }

    // Steer and apply extra drag so it feels floaty
    hsp = lerp(hsp, want_vx, ufo_accel);
    vsp = lerp(vsp, want_vy, ufo_accel);
	// Soft push back into band
if (y < ceiling_y) vsp = max(vsp, 0) + 0.6;   // push down
if (y > lower_y)   vsp = min(vsp, 0) - 0.6;   // push up


    hsp *= (1.0 - ufo_drag_flight);
    vsp *= (1.0 - ufo_drag_flight);
	
if (ufo) {
    var ginst2 = collision_line(x, y, x, ufo_floor_probe_max, objSidewalk, false, true);
    var floor2 = (ginst2 != noone) ? ginst2.bbox_top : room_height;
    var lower2 = floor2 - ufo_ground_clearance;
    y = clamp(y, ufo_ceiling_margin, lower2);
}


    // --- Downward fire (beam/bullets) ---
    if (instance_exists(target)) {
        var under     = (target.y > y + 6);                  // must be below UFO
        var aligned   = (abs(target.x - x) <= ufo_fire_width); // roughly centered
        if (under && aligned) {
            if (ufo_fire_cd <= 0) {
                // Emit from bottom of UFO (use your UFO scale if desired)
                var bx = x;
                var by = y + ufo_muzzle_ofs * max(1, scale);

                // Use your existing bullet object; straight down
                var b = instance_create(bx, by, objBullet_Human);
				b.depth = depth;
                b.owner       = id;
                b.team        = team;
                b.damage      = 8;
                b.direction   = 270;     // straight down
                b.speed       = bullet_speed; // you already set this
                b.image_angle = 270;
                b.scale       = max(0.5, scale * 0.6);
                b.species     = species;

                ufo_fire_cd = ufo_fire_interval;
            }
        }
    }

    if (ufo_fire_cd > 0) ufo_fire_cd--;
}



// ---------------------
// 3) Misc (yours)
spin_angle += 4; if (spin_angle >= 360) spin_angle -= 360;
if (dir=="left")  angle =  hsp;
if (dir=="right") angle = -hsp;

// Nearest fallback while provoked (yours)
if (provoked && !instance_exists(target)) {
    var d_player = 100000000, d_robot = 100000000;

    if (instance_exists(obj_Player1)) {
        player_nearest = instance_nearest(x,y,obj_Player1);
        if (instance_exists(player_nearest)) d_player = point_distance(x,y, player_nearest.x, player_nearest.y);
    } else player_nearest = noone;

    if (instance_exists(obj_Enemy_Robot)) {
        robot_nearest = instance_nearest(x,y,obj_Enemy_Robot);
        if (instance_exists(robot_nearest)) d_robot = point_distance(x,y,  robot_nearest.x,  robot_nearest.y);
    } else robot_nearest = noone;

    if (d_player <= d_robot && instance_exists(player_nearest)) target = player_nearest;
    else if (instance_exists(robot_nearest))                   target = robot_nearest;
}

// ---------------------
// 4) Jetpack idle/wander when NOT in combat
if (using_jetpack && (!provoked || !instance_exists(target))) {
    if (fly_goal_timer <= 0) {
        var r   = irandom_range(64, 160);
        var ang = irandom(359);
        fly_goal_x = x + lengthdir_x(r, ang);
        fly_goal_y = y + lengthdir_y(r, ang);
        fly_goal_timer = irandom_range(room_speed, room_speed * 2);
    } else {
        fly_goal_timer--;
    }

    var a  = point_direction(x, y, fly_goal_x, fly_goal_y);
    var sp = jp_idle_drift;
    var want_vx = lengthdir_x(sp, a);
    var want_vy = lengthdir_y(sp, a);

    hsp = lerp(hsp, want_vx, jp_accel);
    vsp = lerp(vsp, want_vy, jp_accel);
}

// ---------------------
// 5) Combat movement intent ONLY (no x/y integration here)
if (!ufo && provoked && instance_exists(target)) {

    var dist = point_distance(x, y, target.x, target.y);
    dir = (x < target.x) ? "right" : "left";

    var keep_min = max(32, attack_range * 0.60);
    var keep_max = attack_range * 0.90;

    if (using_jetpack) {
        // Air steering around target
        var dx = target.x - x;
        var dy = target.y - y;
        var ang_to = point_direction(0,0, dx, dy);
        var d_to   = point_distance(0,0, dx, dy);

        var fly_speed = (d_to > keep_max) ? jp_boost : jp_speed;
        var aim_ang = ang_to;

        if      (d_to > keep_max)      aim_ang = ang_to;          // close in
        else if (d_to < keep_min)      aim_ang = ang_to + 180;    // back off
        else {
            var orbit_sign = choose(-1, 1);
            aim_ang = ang_to + orbit_sign * 90;                   // orbit
            var want_v = target.y - (y + jp_orbit_v);             // vertical bias
            aim_ang = lerp(aim_ang, point_direction(0,0, dx, want_v), 0.15);
        }

        var want_vx = lengthdir_x(fly_speed, aim_ang);
        var want_vy = lengthdir_y(fly_speed, aim_ang);
        hsp = lerp(hsp, want_vx, jp_accel);
        vsp = lerp(vsp, want_vy, jp_accel);

    } else {
        // Ground strafing/approach
        var _move = 0;
        if (dist > keep_max)       _move = sign(target.x - x);
        else if (dist < keep_min)  _move = -sign(target.x - x);
        else                       _move = choose(-1, 1);

        var move_spd = 2.5;
        hsp = move_spd * _move;

        // Jumps / small obstacle hop
        if (is_on_ground) {
            if (irandom(59) == 0) {
                var js = variable_instance_exists(self,"jump_speed") ? jump_speed : 8;
                vsp = -js; is_on_ground = false;
            }
            var ahead = (dir == "right") ? 8 : -8;
            if (place_meeting(x + ahead, y, objSidewalk) && irandom(4) == 0) {
                var js2 = variable_instance_exists(self,"jump_speed") ? jump_speed : 8;
                vsp = -js2; is_on_ground = false;
            }
        }
    }

    // Aim & shoot (yours)
    arm_dir = point_direction(arm_front_x, arm_front_y, target.x, target.y);

    if (dir == "right") {
        fist_front_x = arm_front_x + lengthdir_x(65 * scale, arm_dir - 12);
        fist_front_y = arm_front_y + lengthdir_y(65 * scale, arm_dir - 12);
    } else {
        fist_front_x = arm_front_x + lengthdir_x(65 * scale, arm_dir + 12);
        fist_front_y = arm_front_y + lengthdir_y(65 * scale, arm_dir + 12);
    }

    if (dist <= attack_range && fire_cd <= 0) {
        var bx = fist_front_x;
        var by = fist_front_y;
        var bdir = arm_dir;

        show_debug_message("[BULLET] spawn @ ("+string(bx)+","+string(by)+") dir="+string(bdir));
        var hb = instance_create(bx, by, objBullet_Human);
        hb.owner       = id;
        hb.team        = team;
        hb.damage      = 5;
        hb.direction   = bdir;
        hb.speed       = 12;
        hb.image_angle = bdir;
        hb.scale       = scale * .5;
        hb.species     = species;

        fire_cd  = fire_cd_max;
        attacking = true;
    } else {
        attacking = false;
    }

    state = "combat";
} else {
    attacking = false;
}
if (fire_cd > 0) fire_cd--;

// ---------------------
// 6) Physics / integration (single spot)
if (using_jetpack) {
    is_on_ground = false;               // no gravity while flying
    hsp *= (1 - jp_drag);
    vsp *= (1 - jp_drag);
    x += hsp;
    y += vsp;
} else {
    if (!is_on_ground) vsp += grav;     // gravity
    x += hsp;                            // horizontal ground motion
    y += vsp;
    if (place_meeting(x, y, objSidewalk)) {
        is_on_ground = true;
        vsp = 0;
        y = yprevious;
    } else {
        is_on_ground = false;
    }
}

// ---------------------
// 7) Sprite facing / scale (yours)
if (hsp>0 && provoked==false) {
	dir = "right";
	}
if (hsp<0 && provoked==false) {
	dir = "right";
	}
if (dir == "left") image_xscale = -1 * scale; else image_xscale = 1 * scale;
image_yscale = scale;

// ---------------------
// 8) Simple ground-only states (idle/walk/panic) so they don't fight jetpack
if (!using_jetpack) {
    if (state == "idle") {
        if (irandom_range(0, 100) < 5 && (distance_to_object(player_nearest) > 100 * scale)) {
            state = "walk";
            dir = choose("left", "right");
        }
    } else if (state == "walk") {
        hsp = 2; // x integration happens in physics
        if (irandom_range(0, 100) < 2) { state = "idle"; hsp = 0; }
    } else if (state == "panic") {
        hsp = 4;
        if (panic_cooldown <= 0) {
            state = "idle"; hsp = 0;
        } else {
            panic_cooldown -= 1;
        }
    }
}

// ---------------------
// 9) Panic trigger (yours)
if (!provoked && instance_exists(target)) {
    if (state != "combat" && point_distance(x,y,target.x,target.y) < 100) {
        state = "panic";
        panic_cooldown = 100;
        dir = (x < target.x) ? "right" : "left";
    }
}

// ---------------------
// 10) BODY/ARM/LEG POSITIONING (your existing math)
// Only change here: while in combat OR shooting, we keep arm_dir aimed at target.
var _keep_arm = ( (state == "combat") || attacking ) && instance_exists(target);

if (dir=="left") {
    arm_img_angle=90;
    if (state != "combat") {
        armB_dir=270;
    }

    if (_keep_arm) {
        arm_dir = point_direction(arm_front_x,arm_front_y,target.x,target.y);
        // no reset to 270 while in combat/shooting
    } else {
        if (attacking==false) { arm_dir=270; wpn_dir=90; }
        if (attacking==true && instance_exists(target)) {
            arm_dir = point_direction(arm_front_x,arm_front_y,target.x,target.y);
        } else { arm_dir=270; wpn_dir=90; }
    }

    if (race!="spraycan" && race!="banana") {
        head_x = x + lengthdir_x(75 * scale, 90+angle);
        head_y = y + lengthdir_y(75 * scale, 90+angle);
        eyes_x = head_x + lengthdir_x(60 * scale, 122);
        eyes_y = head_y + lengthdir_y(60 * scale, 122);
        eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, 200);
        eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, 200);
        eyelids_x = eyes_x + lengthdir_x(0 * scale, 105);
        eyelids_y = eyes_y + lengthdir_y(0 * scale, 105);
        mouth_x = head_x + lengthdir_x(30 * scale, 165);
        mouth_y = head_y + lengthdir_y(30 * scale, 165);
        nose_x = head_x + lengthdir_x(50 * scale, 105);
        nose_y = head_y + lengthdir_y(50 * scale, 105);
    } else if race=="spraycan" {
        head_x = x; head_y = y;
        eyes_x=x+lengthdir_x(85 * scale,115)*scale;
        eyes_y=y+lengthdir_y(85 * scale,115)*scale;
        eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, 200);
        eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, 200);
        eyelids_x=eyes_x+lengthdir_x(0,75)*scale;
        eyelids_y=eyes_y+lengthdir_y(0,75)*scale;
        mouth_x=head_x+lengthdir_x(10,75)*scale;
        mouth_y=head_y+lengthdir_y(10,75)*scale;
        skin_color_eyelids=c_red;
    } else { //banana
		head_x = x; head_y = y;
        eyes_x=x+lengthdir_x(105 * scale,115)*scale;
        eyes_y=y+lengthdir_y(105 * scale,115)*scale;
        eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, 200);
        eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, 200);
        eyelids_x=eyes_x+lengthdir_x(0,75)*scale;
        eyelids_y=eyes_y+lengthdir_y(0,75)*scale;
        mouth_x=head_x+lengthdir_x(10,75)*scale;
        mouth_y=head_y+lengthdir_y(10,75)*scale;
        skin_color_eyelids=c_white;
    }

    eyebrows_x = eyes_x + lengthdir_x(20 * scale, 80);
    eyebrows_y = eyes_y + lengthdir_y(20 * scale, 80);
    hair_x = head_x + lengthdir_x(53 * scale, 100);
    hair_y = head_y + lengthdir_y(53 * scale, 100);
    shirt_x = x + lengthdir_x(10 * scale, 120);
    shirt_y = y + lengthdir_y(10 * scale, 120);
    pants_x = x + lengthdir_x(0 * scale, 235);
    pants_y = y + lengthdir_y(0 * scale, 235);
    skirt_x = x + lengthdir_x(50 * scale, 270);
    skirt_y = y + lengthdir_y(50 * scale, 270);
    arm_back_x = x + lengthdir_x(50 * scale, 120+angle);
    arm_back_y = y + lengthdir_y(50 * scale, 120+angle);
    arm_front_x = x + lengthdir_x(50 * scale, 37+angle);
    arm_front_y = y + lengthdir_y(50 * scale, 37+angle);
    fist_back_x = arm_back_x + lengthdir_x(65 * scale,armB_dir+12);
    fist_back_y = arm_back_y + lengthdir_y(65 * scale,armB_dir+12);
    fist_front_x = arm_front_x + lengthdir_x(65 * scale,arm_dir+12);
    fist_front_y = arm_front_y + lengthdir_y(65 * scale,arm_dir+12);

    if (race!="odonis") {
        leg_back_x = x + lengthdir_x(50 * scale, 255+angle);
        leg_back_y = y + lengthdir_y(50 * scale, 255+angle);
        leg_front_x = x + lengthdir_x(60 * scale, 305+angle);
        leg_front_y = y + lengthdir_y(60 * scale, 305+angle);
        foot_back_x = leg_back_x + lengthdir_x(8 * scale,270);
        foot_back_y = leg_back_y + lengthdir_y(8 * scale,270);
        foot_front_x = leg_front_x + lengthdir_x(8 * scale,270);
        foot_front_y = leg_front_y + lengthdir_y(8 * scale,270);
    } else {
        leg_back_x = x + lengthdir_x(50 * scale, 273+angle);
        leg_back_y = y + lengthdir_y(50 * scale, 273+angle);
        leg_front_x = x + lengthdir_x(60 * scale, 305+angle);
        leg_front_y = y + lengthdir_y(60 * scale, 305+angle);
        foot_back_x = leg_back_x + lengthdir_x(8 * scale,270);
        foot_back_y = leg_back_y + lengthdir_y(8 * scale,270);
        foot_front_x = leg_front_x + lengthdir_x(8 * scale,270);
        foot_front_y = leg_front_y + lengthdir_y(8 * scale,270);
    }
}

if (dir=="right") {
    if (state != "combat") {
        arm_img_angle=270;
        armB_dir=270;
    }

    if (_keep_arm) {
        arm_dir = point_direction(arm_front_x,arm_front_y,target.x,target.y);
        // no reset to 270 while in combat/shooting
    } else {
        if (attacking==false) {arm_dir=270;}
        if (attacking==true && instance_exists(target)) {
            arm_dir = point_direction(arm_front_x,arm_front_y,target.x,target.y);
        } else { arm_dir=270; }
    }

    head_x = x + lengthdir_x(75 * scale, 90);
    head_y = y + lengthdir_y(75 * scale, 90);
    eyes_x = head_x + lengthdir_x(60 * scale, 58);
    eyes_y = head_y + lengthdir_y(60 * scale, 58);

    if (race!="spraycan" && race!="banana") {
        eyelids_x = eyes_x + lengthdir_x(0 * scale, 75);
        eyelids_y = eyes_y + lengthdir_y(0 * scale, 75);
        eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, -20);
        eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, -20);
        mouth_x = head_x + lengthdir_x(30 * scale, 15);
        mouth_y = head_y + lengthdir_y(30 * scale, 15);
        nose_x = head_x + lengthdir_x(50 * scale, 75);
        nose_y = head_y + lengthdir_y(50 * scale, 75);
    } else if race=="spraycan" {
        head_x = x; head_y = y;
        eyes_x=x+lengthdir_x(85 * scale,65)*scale;
        eyes_y=y+lengthdir_y(85 * scale,65)*scale;
        eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, -20);
        eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, -20);
        eyelids_x=eyes_x+lengthdir_x(0,75)*scale;
        eyelids_y=eyes_y+lengthdir_y(0,75)*scale;
        mouth_x=head_x+lengthdir_x(10,75)*scale;
        mouth_y=head_y+lengthdir_y(10,75)*scale;
        skin_color_eyelids=c_red;
    } else  {//banana
        head_x = x; head_y = y;
        eyes_x=x+lengthdir_x(85 * scale,65)*scale;
        eyes_y=y+lengthdir_y(85 * scale,65)*scale;
        eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, -20);
        eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, -20);
        eyelids_x=eyes_x+lengthdir_x(0,75)*scale;
        eyelids_y=eyes_y+lengthdir_y(0,75)*scale;
        mouth_x=head_x+lengthdir_x(10,75)*scale;
        mouth_y=head_y+lengthdir_y(10,75)*scale;
        skin_color_eyelids=c_white;
    } 

    eyebrows_x = eyes_x + lengthdir_x(20 * scale, 100);
    eyebrows_y = eyes_y + lengthdir_y(20 * scale, 100);
    hair_x = head_x + lengthdir_x(53 * scale, 80);
    hair_y = head_y + lengthdir_y(53 * scale, 80);
    shirt_x = x + lengthdir_x(10 * scale, 40);
    shirt_y = y + lengthdir_y(10 * scale, 40);
    pants_x = x + lengthdir_x(0 * scale, -55);
    pants_y = y + lengthdir_y(0 * scale, -55);
    skirt_x = x + lengthdir_x(50 * scale, 270+angle);
    skirt_y = y + lengthdir_y(50 * scale, 270+angle);
    arm_back_x = x + lengthdir_x(50 * scale, 60);
    arm_back_y = y + lengthdir_y(50 * scale, 60);
    arm_front_x = x + lengthdir_x(50 * scale, 143);
    arm_front_y = y + lengthdir_y(50 * scale, 143);
    fist_back_x = arm_back_x + lengthdir_x(65 * scale,armB_dir-12);
    fist_back_y = arm_back_y + lengthdir_y(65 * scale,armB_dir-12);
    fist_front_x = arm_front_x + lengthdir_x(65 * scale,arm_dir-12);
    fist_front_y = arm_front_y + lengthdir_y(65 * scale,arm_dir-12);

    if (race!="odonis") {
        leg_back_x = x + lengthdir_x(50 * scale, 285);
        leg_back_y = y + lengthdir_y(50 * scale, 285);
        leg_front_x = x + lengthdir_x(60 * scale, 235);
        leg_front_y = y + lengthdir_y(60 * scale, 235);
        foot_back_x = leg_back_x + lengthdir_x(8 * scale,270);
        foot_back_y = leg_back_y + lengthdir_y(8 * scale,270);
        foot_front_x = leg_front_x + lengthdir_x(8 * scale,270);
        foot_front_y = leg_front_y + lengthdir_y(8 * scale,270);
    } else {
        leg_back_x = x + lengthdir_x(50 * scale, 267);
        leg_back_y = y + lengthdir_y(50 * scale, 267);
        leg_front_x = x + lengthdir_x(60 * scale, 235);
        leg_front_y = y + lengthdir_y(60 * scale, 235);
        foot_back_x = leg_back_x + lengthdir_x(8 * scale,270);
        foot_back_y = leg_back_y + lengthdir_y(8 * scale,270);
        foot_front_x = leg_front_x + lengthdir_x(8 * scale,270);
        foot_front_y = leg_front_y + lengthdir_y(8 * scale,270);
    }
}

// ---------------------
// end Step
