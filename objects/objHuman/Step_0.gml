/// @description Insert description here
// You can write your code in this editor
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
 
/// Ensure the map exists before any use
if (!variable_instance_exists(self,"threat_map") || is_undefined(threat_map) || !ds_exists(threat_map, ds_type_map)) {
    threat_map = ds_map_create();
}

/// Consume POI once
if (poi != noone) { target = poi; poi = noone; }


/// If target gone, pick the best by threat (no ds_map_keys!)

// Type guards (must be first)
// --- type guards (must be first) ---
if (!is_real(target)) target = noone;
if (!is_real(poi))    poi    = noone;

// Ensure threat map exists
if (!variable_instance_exists(self,"threat_map") || is_undefined(threat_map) || !ds_exists(threat_map, ds_type_map)) {
    threat_map = ds_map_create();
}

// Consume POI once
if (poi != noone) { target = poi; poi = noone; }

// Keep/decay provoked
if (ds_map_size(threat_map) > 0) provoked = true;
if (alert_timer > 0) { alert_timer--; } else { alert_timer = 0; }
// (Optional) auto-calm if nothing to fight
if (alert_timer == 0 && ds_map_size(threat_map) == 0) provoked = false;


if (!instance_exists(target)) {
    target = noone;

    if (ds_exists(threat_map, ds_type_map) && ds_map_size(threat_map) > 0) {
        var best_id  = noone;
		var best_val = -1000000000; // big negative sentinel


        var k = ds_map_find_first(threat_map);
        while (k != undefined) {
            var inst_id = real(k);
            if (instance_exists(inst_id)) {
                var val = threat_map[? k];
                if (val > best_val) { best_val = val; best_id = inst_id; }
                k = ds_map_find_next(threat_map, k);
            } else {
                // delete and advance safely
                var nxt = ds_map_find_next(threat_map, k);
                ds_map_delete(threat_map, k);
                k = nxt;
            }
        }
        target = best_id;
    }
}

/// Decay threat over time (again, no ds_map_keys)
if (ds_exists(threat_map, ds_type_map) && ds_map_size(threat_map) > 0) {
    var k2 = ds_map_find_first(threat_map);
    while (k2 != undefined) {
        var nxt = ds_map_find_next(threat_map, k2);
        var v = max(0, threat_map[? k2] - 0.1);
        if (v <= 0) ds_map_delete(threat_map, k2); else threat_map[? k2] = v;
        k2 = nxt;
    }
}



 
 //misions
 spin_angle += 4; // You can adjust speed
if (spin_angle >= 360) spin_angle -= 360;

 
 if (dir=="left") {
	 angle=hsp;
 } 
 if (dir=="right") {
	 angle=-hsp;
 }
 
 //nearest
// Only pick a nearest if we don't already have a valid target
// Only pick a nearest if we DON'T already have a valid target AND we are provoked
if (provoked && !instance_exists(target)) {
    var d_player = 100000000, d_robot = 100000000;

    if (instance_exists(obj_Player1)) {
        player_nearest = instance_nearest(x,y,obj_Player1);
        if (instance_exists(player_nearest)) d_player = point_distance(x,y, player_nearest.x, player_nearest.y);
    } else player_nearest = noone;

    if (instance_exists(obj_Enemy_Robot)) {
        robot_nearest = instance_nearest(x,y,obj_Enemy_Robot);
        if (instance_exists(robot_nearest)) d_robot = point_distance(x,y, robot_nearest.x,  robot_nearest.y);
    } else robot_nearest = noone;

    if (d_player <= d_robot && instance_exists(player_nearest))      target = player_nearest;
    else if (instance_exists(robot_nearest))                         target = robot_nearest;
}



 
 // Apply gravity
if !is_on_ground {
    vsp += grav; // Increase vertical speed due to gravity
}
// Move vertically
y += vsp;

// Check for ground collision
if place_meeting(x, y, objSidewalk) {
    // If colliding with the ground, stop falling
    is_on_ground = true;
    vsp = 0; // Reset vertical speed
    y = yprevious; // Adjust position to stop on the ground
} else {
    is_on_ground = false; // Not on the ground
}

 if dir == "left" {
    image_xscale = -1*scale; // Flip the sprite horizontally
} else {
    image_xscale = 1*scale;  // Default orientation
}

image_yscale=scale;
// Step Event



// Example: Basic AI state transitions
if state == "idle" {
    // Randomly decide to start walking
    if irandom_range(0, 100) < 5 && (distance_to_object(player_nearest)>100*scale){
        state = "walk";
        dir = choose("left", "right");
    }
} else if state == "walk" {
    // Move in the chosen direction
    hsp = 2; // Slow speed
    if dir == "left" {
        x -= hsp;
    } else if dir == "right" {
        x += hsp;
    }

    // Randomly decide to stop walking
    if irandom_range(0, 100) < 2 {
        state = "idle";
        hsp = 0;
    }
} else if state == "panic" {
    // Panic behavior: Fast, erratic movement
    hsp = 4;
    if dir == "left" {
        x -= hsp;
    } else {
        x += hsp;
    }

    // Add logic to exit the panic state
    if panic_cooldown <= 0 {
        state = "idle";
        hsp = 0;
    } else {
        panic_cooldown -= 1;
    }
}




// If the player is close, panic
// If the player is close, panic (but not when provoked/combat-focused)
if (!provoked && instance_exists(target)) {
    if (state != "combat" && point_distance(x,y,target.x,target.y) < 100) {
        state = "panic";
        panic_cooldown = 100;
        dir = (x < target.x) ? "right" : "left";
    }
}




if (dir=="left") {
	
	arm_img_angle=90;
	armB_dir=270;
	if (attacking==false) {
	arm_dir=270;
	wpn_dir=90;
	}
	if  (attacking==true) && instance_exists(target) {
		arm_dir = point_direction(arm_front_x,arm_front_y,target.x,target.y);
		} else { 
			arm_dir=270;
			wpn_dir=90;
	}
	
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
	
	
	

	leg_back_x = x + lengthdir_x(50 * scale, 255+angle);
	leg_back_y = y + lengthdir_y(50 * scale, 255+angle);
	leg_front_x = x + lengthdir_x(60 * scale, 305+angle);
	leg_front_y = y + lengthdir_y(60 * scale, 305+angle);
	foot_back_x = leg_back_x + lengthdir_x(8 * scale,270);
	foot_back_y = leg_back_y + lengthdir_y(8 * scale,270);
	foot_front_x = leg_front_x + lengthdir_x(8 * scale,270);
	foot_front_y = leg_front_y + lengthdir_y(8 * scale,270);

	//shoes_x = x + lengthdir_x(40 * scale, 270);
	//shoes_y = y + lengthdir_y(40 * scale, 270);


			
}

if (dir=="right") {
	
	arm_img_angle=270;
	armB_dir=270;
	if (attacking==false) {arm_dir=270;}
	if  (attacking==true) && instance_exists(target) {
		arm_dir = point_direction(arm_front_x,arm_front_y,target.x,target.y);
	} else { 
			arm_dir=270;
			}
		
	head_x = x + lengthdir_x(75 * scale, 90);
	head_y = y + lengthdir_y(75 * scale, 90);

	eyes_x = head_x + lengthdir_x(60 * scale, 58);
	eyes_y = head_y + lengthdir_y(60 * scale, 58);

	eyes_pupils_x = eyes_x + lengthdir_x(15 * scale, -20);
	eyes_pupils_y = eyes_y + lengthdir_y(15 * scale, -20);

	eyelids_x = eyes_x + lengthdir_x(0 * scale, 75);
	eyelids_y = eyes_y + lengthdir_y(0 * scale, 75);
	mouth_x = head_x + lengthdir_x(30 * scale, 15);
	mouth_y = head_y + lengthdir_y(30 * scale, 15);
	nose_x = head_x + lengthdir_x(50 * scale, 75);
	nose_y = head_y + lengthdir_y(50 * scale, 75);

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

	leg_back_x = x + lengthdir_x(50 * scale, 285);
	leg_back_y = y + lengthdir_y(50 * scale, 285);
	leg_front_x = x + lengthdir_x(60 * scale, 235);
	leg_front_y = y + lengthdir_y(60 * scale, 235);
	foot_back_x = leg_back_x + lengthdir_x(8 * scale,270);
	foot_back_y = leg_back_y + lengthdir_y(8 * scale,270);
	foot_front_x = leg_front_x + lengthdir_x(8 * scale,270);
	foot_front_y = leg_front_y + lengthdir_y(8 * scale,270);

	//shoes_x = x + lengthdir_x(40 * scale, 270);
	//shoes_y = y + lengthdir_y(40 * scale, 270);


			
}





//mision

if (instance_exists(player_target)) {
    var dist = point_distance(x, y, target.x, target.y);
    
    show_msg = (dist < interaction_range);
    
	/*
    if (show_message && !global.mission_active) {
        var key_pressed = keyboard_check_pressed(vk_enter);
        var gamepad_pressed = gamepad_button_check_pressed(0, gp_face1); // A button

        if (key_pressed || gamepad_pressed) {
            global.mission_active = true;
            global.current_mission = id;
            mission_active = true;

            // Trigger mission controller or content
          //  instance_create_layer(x, y, "Controllers", objMissionController);
        }
    }
	*/
}


// --- COMBAT AI: move toward/away, strafe, jump, shoot ---
if (provoked && instance_exists(target)) {
    var dist = point_distance(x, y, target.x, target.y);

    // Face the target
    dir = (x < target.x) ? "right" : "left";

    // Keep a ring around the target
    var keep_min = max(32, attack_range * 0.60);
    var keep_max = attack_range * 0.90;

    // Horizontal move intent
    var _move = 0;
    if (dist > keep_max)       _move = sign(target.x - x);     // close
    else if (dist < keep_min)  _move = -sign(target.x - x);    // back off
    else                       _move = choose(-1, 1);          // strafe

    var move_spd = 2.5;
    hsp = move_spd * _move;
    x  += hsp;

    // Jump sometimes / over tiny obstacles
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

    // Aim at the target NOW
    arm_dir = point_direction(arm_front_x, arm_front_y, target.x, target.y);

    // --- IMPORTANT: keep the fist in sync with the *new* arm_dir ---
    if (dir == "right") {
        fist_front_x = arm_front_x + lengthdir_x(65 * scale, arm_dir - 12);
        fist_front_y = arm_front_y + lengthdir_y(65 * scale, arm_dir - 12);
    } else {
        fist_front_x = arm_front_x + lengthdir_x(65 * scale, arm_dir + 12);
        fist_front_y = arm_front_y + lengthdir_y(65 * scale, arm_dir + 12);
    }

    // Shoot when in range + cooldown ready
	    // Shoot when in range + cooldown ready
	if (dist <= attack_range && fire_cd <= 0) {
	    // spawn on the same visible instance layer as this NPC
	    var bullet_layer = layer; // (this instance's layer id)
	    var bx = fist_front_x;
	    var by = fist_front_y;
	    var bdir = arm_dir;       // world-space aim

	    // DEBUG: show exactly when/where we spawn
	    show_debug_message("[BULLET] spawn @ ("+string(bx)+","+string(by)+") dir="+string(bdir));
    
	    var hb = instance_create(bx, by, objBullet_Human);
	    hb.owner      = id;
	    hb.team       = team;
	    hb.damage     = 5;
	    hb.direction  = bdir;
	    hb.speed      = 12;//bullet_speed;
	    hb.image_angle= bdir;

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
