function scr_Enemy_Robot_step_ai(){

if instance_exists(target_player) {
	var dir = point_direction(x, y, target_player.x, target_player.y);
} else {
	if (facing_right) {
		
	var dir = point_direction(x, y, x+10,y);
	} else { 
		
	var dir = point_direction(x, y, x-10, y);
		}
}

var on_ground = !place_empty(x, y + 1, floor_obj);

if (on_ground) {
    vsp = 0;
	grav=0;
    isJumping = false;
    jumpSpeed = 0;
} else {
    // Restore gravity if not on ground
	vsp += grav;

    switch (jetpack_mode) {
        case 1: grav = 0.4; break;
        case 2: grav = 0.15; break;
        case 3: grav = 0.05; break;
    }
}


// Movement logic
if instance_exists(target_player) {
	var dist_to_player = point_distance(x, y, target_player.x, target_player.y);
} else {
	var dist_to_player = 1000;
}

if (ai_state == "follow" || ai_state == "attack") {
    if (instance_exists(target_player)) {
        if (x < target_player.x) {
            facing_right = true;
			armF_dir=dir;
			image_angle=dir;
            image_xscale = abs(image_xscale); // make sure sprite faces right
        } else {
            facing_right = false;
			armF_dir=dir;
			image_angle=dir;
            image_xscale = -abs(image_xscale); // flip sprite to face left
        }
    }
}

if (ai_state == "patrol") {
    hsp = patrol_direction * hsp_walk_max;

    if (--patrol_timer <= 0) {
        patrol_direction *= -1;
        patrol_timer = irandom_range(60, 180);
    }

    // Face patrol direction
    if (patrol_direction > 0) {
        facing_right = true;
		armF_dir=0;
		image_angle=dir;
        image_xscale = abs(image_xscale);
    } else {
        facing_right = false;
		armF_dir=180;
		image_angle=dir;
        image_xscale = -abs(image_xscale);
    }

    // Transition to follow if player is near
    if (instance_exists(target_player)) {
        if (point_distance(x, y, target_player.x, target_player.y) < player_detect_range) {
            ai_state = "follow";
        }
    }
}


switch (movement_type) {
    case "retreat":
		if instance_exists(target_player) {
			hsp = (x < target_player.x) ? -move_speed : move_speed;
		}
        break;

    case "normal":
		if instance_exists(target_player) {
	        if (dist_to_player > preferred_range_max) {
	            hsp = (x < target_player.x) ? move_speed : -move_speed;
	        } else if (dist_to_player < preferred_range_min) {
	            hsp = (x < target_player.x) ? -move_speed : move_speed;
	        } else {
	            hsp = 0;
	        }
		}
        break;

    case "rush":
		if instance_exists(target_player){
	        hsp = (x < target_player.x) ? move_speed : -move_speed;
		}
        break;

    case "strafe":
        hsp = lengthdir_x(move_speed, image_angle + irandom_range(-15,15));
        break;
}


/*
if (dist_to_player< preferred_range_min) {
    // Too close — retreat
    if (movement_type == "retreat" || movement_type == "normal") {
        hsp = -lengthdir_x(hsp_walk_max, dir); // move away
        vsp = -lengthdir_y(hsp_walk_max, dir);
    } else if (movement_type == "dash") {
        // quick dodge or dash away (can be randomized or triggered on cooldown)
    }
}
else if (dist_to_player> preferred_range_max) {
    // Too far — approach
    if (movement_type != "static") {
        hsp = lengthdir_x(hsp_walk_max, dir); // move toward
        vsp = lengthdir_y(hsp_walk_max, dir);
    }
}
else {
    // In ideal range — position tactically or stop
    hsp = 0;
    vsp = 0;

    // Line of sight check (optional)
    if (can_see_target(obj_block_64)) {
        attack_cooldown--;
        if (attack_cooldown <= 0) {
            shooting=true;
            attack_cooldown = attack_cooldown_max;
        } else {
			shooting=false;
		}
    }
}
*/

if (dist_to_player< preferred_range_min) {
    // Too close — retreat
    if (movement_type == "retreat" || movement_type == "normal") {
        hsp = (x < target_player.x) ? -move_speed : move_speed;
        if (jetpack_mode == 3) vsp = -abs(move_speed); // allow floating back only for mode 3
    }
}
else if (dist_to_player> preferred_range_max) && instance_exists(target_player) {
    // Too far — approach
    if (movement_type != "static") {
        hsp = (x < target_player.x) ? move_speed : -move_speed;
        if (jetpack_mode == 3) vsp = abs(move_speed); // float forward for mode 3
    }
}
else {
    // In ideal range — tactically stop horizontal motion only
    if (movement_type != "rush" && movement_type != "strafe") {
        hsp = 0;
    }

    // Optional attack logic
    if (can_see_target(obj_block_64)) {
        attack_cooldown--;
        shooting = (attack_cooldown <= 0);
        if (shooting) attack_cooldown = attack_cooldown_max;
    } else {
        shooting = false;
    }
}


///////////////

if (dist_to_player>= preferred_range_min && dist_to_player<= preferred_range_max) {
    if (movement_type == "rush") {
        var strafe_dir = choose(-90, 90);
        var move_angle = dir + strafe_dir;
        hsp = lengthdir_x(hsp_walk_max, move_angle);
        vsp = lengthdir_y(hsp_walk_max, move_angle);
    }
}



if (instance_exists(target_player)) {
    var dist_to_player= point_distance(x, y, target_player.x, target_player.y);
    target = target_player;

    switch (ai_state) {
        case "patrol":
            hsp = patrol_direction * hsp_walk_max;
            if (--patrol_timer <= 0) {
                patrol_direction *= -1;
                patrol_timer = irandom_range(60, 180);
            }
            if (dist_to_player< player_detect_range) {
                ai_state = "follow";
            }
            break;

        case "follow":
            hsp = (x < target.x) ? hsp_walk_max : -hsp_walk_max;
            if (dist_to_player< attack_range) {
                ai_state = "attack";
            } else if (dist_to_player> player_detect_range * 1.5) {
                ai_state = "patrol";
            }
            break;

        case "attack":
            hsp = 0;
            // perform attack logic (sword slash, bullet, etc.)
            if (dist_to_player> attack_range) {
                ai_state = "follow";
            }
            break;
    }
}

if (!weapon_locked) {
    // Allow weapon change
}

////////////////


if (ai_state="patrol"){
	poi = point_direction(x,y,direction,direction);
}
if (ai_state="follow"){
	poi = point_direction(x,y,target_player.x,target_player.y);
}
if (ai_state="attack"){
	poi = point_direction(x,y,target_player.x,target_player.y);
}

}