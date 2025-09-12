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
 
 if (poi!="none")
 
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
if instance_exists(obj_Player1)  {
	player_nearest = instance_nearest(x,y,obj_Player1);
} else {
	player_nearest = noone; 
}
if instance_exists(obj_Enemy_Robot)  {
	robot_nearest = instance_nearest(x,y,obj_Enemy_Robot);
} else {
	robot_nearest = noone;
}

if !instance_exists(human_nearest)  {
	human_nearest = noone;
}
if (distance_to_object(player_nearest) <= distance_to_object(robot_nearest)) && (!target==human_nearest) {
	target = player_nearest;
}
if (distance_to_object(player_nearest) > distance_to_object(robot_nearest)) && (!target==human_nearest)  {
	target = robot_nearest;
}

// POI AND TARGET
 if (poi!="none") {
	 target=poi;
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
if (instance_exists(target))
{
	if distance_to_object(target) < 100 {
	    state = "panic";
	    panic_cooldown = 100; // Number of steps to stay in panic state
	    dir = (x < target.x) ? "left" : "right";
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