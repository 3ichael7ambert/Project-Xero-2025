//SPRITE OFFSET
image_xscale=scale;
image_yscale=scale;
// Set the collision bounding box mode to "Custom"
//sprite_set_bbox_mode(sprite_index, bbox_custom);
// Set the custom collision bounding box
//sprite_set_bbox(sprite_index, bbox_left, bbox_top, bbox_right, bbox_bottom);

if (keyboard_check_pressed(vk_escape)) {
	room_goto(rm_menu);
}

if (can_switch_jetpack) {
	if (keyboard_check_pressed(ord(1)))
	{
	    // Key 1 is pressed
	    jetpack_mode = 1;
	}
	if (keyboard_check_pressed(ord(2)))
	{
	    // Key 2 is pressed
	    jetpack_mode = 2;
	}
	if (keyboard_check_pressed(ord(3)))
	{
	    // Key 3 is pressed
	    jetpack_mode = 3;
	}
	if (keyboard_check_pressed(ord(4)))
	{
	    // Key 3 is pressed
	    jetpack_mode = 4;
	}

	if (change_jetpack) { 
		//jetpack_mode++; 
		}
	if (jetpack_mode>4) {jetpack=1;}

}

//mouse_aim
if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach)  {

//mouse_aim
xm=window_mouse_get_x();
ym=window_mouse_get_y();

// Get window dimensions
ww = window_get_width();
wh = window_get_height();



cm_x=global.CameraManager.x;
cm_y=global.CameraManager.y;
mouse_x_3d=xm+cm_x;
mouse_y_3d=ym+cm_y;
//var mouse_x_world = global.CameraManager.x + (device_mouse_x(0));
//var mouse_y_world = global.CameraManager.y + (device_mouse_y(0));
//mouse_x_3d= mouse_x_world;
//mouse_y_3d= mouse_y_world;
}

else {
xm=window_mouse_get_x();
ym=window_mouse_get_y();

// Get window dimensions
ww = window_get_width();
wh = window_get_height();
cm_x=mouse_x;
cm_y=mouse_y;

mouse_x_3d=  mouse_x;//mouse_x_world;
mouse_y_3d= mouse_y;//mouse_y_world;
}


// Mouse input
/*
mouse_xdiff = xm - ww/2;
mouse_ydiff = ym - wh/2;
mouse_xdiff /= ww;
mouse_ydiff /= wh;
direction += xdiff;    // Horizontal movement of the mouse means look left or right
zdir += ydiff;         // Vertical movement of the mouse means look up or down
// Re-center the mouse
window_mouse_set(ww/2, wh/2);    // Reset the mouse so we can get a new offset from the window center next step/frame
*/


//mouse_x_3d=xm+cm_x;
//mouse_y_3d=ym+cm_y;
//var mouse_x_world = global.CameraManager.x + (device_mouse_x(0));
//var mouse_y_world = global.CameraManager.y + (device_mouse_y(0));



poi = point_direction(x,y,mouse_x_3d,mouse_y_3d);



if keyboard_check_pressed(ord("Q")) {
	if mouse_aim=false {mouse_aim=true;}
	else if mouse_aim=true {mouse_aim=false;}
	}
	
if (mouse_aim==true) && (gamepad==false) {
	draw_circle(xm,ym,20,true);
	
	if mouse_x_3d<x {
		facing_right=false;
	} else {
		facing_right =true;
	}
}

if (mouse_aim=false) && (gamepad==false) {
	if (facing_right) {
		armF_dir=0;
		armB_dir=0;
	} else {
		armF_dir=180;
		armB_dir=180;
	}
}
if (mouse_aim==true) {
	//armF_dir=point_direction(x,y,xm,ym);
	//armB_dir=point_direction(x,y,xm,ym);
	//armF_dir=point_direction(ww/2, wh/2, xm, ym);
	//armB_dir=point_direction(ww/2, wh/2, xm, ym);
	armF_dir=point_direction(x, y, mouse_x_3d, mouse_y_3d);
	armB_dir=point_direction(x, y, mouse_x_3d, mouse_y_3d);
	//armB_dir=0;
}
//if gamepad_is_connected(0) {gamepad=true;} else {gamepad=false;}
if (gamepad==true) {
	//gamepad=true;
	
     var axisrh_value = gamepad_axis_value(gamepad_num, gp_axisrh);
	 if  (axisrh_value>=.5) {facing_right=true;}
	 if  (axisrh_value<=-.5) {facing_right=false;}
	 
	if (facing_right) {
		armF_dir=point_direction(0, 0, gamepad_axis_value(gamepad_num,gp_axisrh), -gamepad_axis_value(gamepad_num,gp_axisrv));
		armB_dir=point_direction(0, 0, gamepad_axis_value(gamepad_num,gp_axisrh), -gamepad_axis_value(gamepad_num,gp_axisrv));
	} else {
		if (axislh_value<=.5) && (axislh_value>=-.5)  {
			armF_dir=point_direction(0, 0, gamepad_axis_value(gamepad_num,gp_axisrh)+180, -gamepad_axis_value(gamepad_num,gp_axisrv));
			armB_dir=point_direction(0, 0, gamepad_axis_value(gamepad_num,gp_axisrh)+180, -gamepad_axis_value(gamepad_num,gp_axisrv));
		} else {
			armF_dir=point_direction(0, 0, gamepad_axis_value(gamepad_num,gp_axisrh), -gamepad_axis_value(gamepad_num,gp_axisrv));
			armB_dir=point_direction(0, 0, gamepad_axis_value(gamepad_num,gp_axisrh), -gamepad_axis_value(gamepad_num,gp_axisrv));
		}
			
	}
} else {
	//gamepad=false;
	}
/*
if gamepad=true {
	if gamepad_axis_value(0,gp_axisrh) > .25 {
		facing_right=true;
	}
	if gamepad_axis_value(0,gp_axisrh) < .25 {
		facing_right=false;
	}
}
*/

// Check if gamepad is connecteg
scr_player_1_init_controls(gamepad_num);



if (wpn_chg_down) {
	wpn_btn_dir="down";
	weapon-=1;
	
}
if (wpn_chg_up) {
	wpn_btn_dir="up";
	weapon+=1;
	
}


if (jetpack_mode==1)
{
// Horizontal movement

	if (move_left) 
	{
		if (gamepad==false) {facing_right = false;}
		if !place_meeting(bbox_left,y-30,floor_obj) 
		{
			hsp_walk -= 1.4;
			walk=true;
			idle=false;
			wall_direction = -1;
			//walk_armF++;
		}
	} 
	else if (move_right) 
	{
		if (gamepad==false) {facing_right = true;}
		if !place_meeting(bbox_right,y-20,floor_obj) 
		{
			hsp_walk += 1.4;
			walk=true;
			idle=false;
			wall_direction = 1;
			//walk_armF++;
		}
	} 
	else 
	{
		hsp_walk = 0; // Stop horizontal movement when no key is pressed
		walk=false;
		idle=true;
		wall_direction=0;
		//walk_armF=0;
	}


//WALK
	if walk_legF>16 {walk_legF=0;}
	if walk_legB<0 {walk_legB=16;}
	if walk_armF>18 {walk_armF=0;}
	if walk_armB<0 {walk_armB=18;}
	if walk=true { walk_legB-=1; walk_legF+=1;  walk_armB+=1; walk_armF-=1;} else {walk_legB=0; walk_legF=0; walk_armB=0; walk_armF=0;}

}
if jetpack_mode=2 || jetpack_mode==3 
{
    // Regular movement using hsp directly
    if (move_left) {
        if (mouse_aim==false) {facing_right = false;}
        if !place_meeting(bbox_left,y-30,floor_obj) 
        {
            hsp -= 1.4;
            walk=true;
            idle=false;
            wall_direction = -1;
        }
    } 
    else if (move_right) 
    {
        if (mouse_aim==false) {facing_right = true;}
        if !place_meeting(bbox_right,y-20,floor_obj) 
        {
            hsp += 1.4;
            walk=true;
            idle=false;
            wall_direction = 1;
        }
    }
    else 
    {
        hsp *= 0.9; // Add friction instead of immediate stop
        walk = false;
        idle = true;
        wall_direction = 0;
    }
}

// After you snap to ground & set vsp=0:
if (jetpack_mode == 4) {
    var in_spin = (jp4_state == JP4_STATE_ROLL) || (jp4_state == JP4_STATE_SLAM) || (jp4_state == JP4_STATE_HOMING);
    // impact velocity magnitude (use previous vsp; cache before zeroing if needed)
    var impact_v = abs(vsp_previous); // store vsp_previous = vsp before resolution
    if (in_spin && impact_v > 2.5) {
        _jp4_bounce_from_impact(impact_v);
        // stay in roll after bounce
        jp4_state = JP4_STATE_ROLL;
    } else {
        // gentle landing: reset to idle unless still charging
        if (jp4_state != JP4_STATE_CHARGE) jp4_state = JP4_STATE_IDLE;
        // small settle squash
        _jp4_squash(1.1, 0.9, 6);
    }
}

// Jumping logic
if (move_up) {
    if (jetpack_mode == 3) && place_empty(x,bbox_top,floor_obj)
	{
        vsp -= 0.4;
    } 
	
	if jetpack_mode==1 || jetpack_mode==2 
	{
		// _mv METROIDVANIA
		if game_style=="mv" {
			if grav_dir=="down" {
				// Ground jump
				if (!isJumping && !place_empty(x,y,floor_obj)) {
                    isJumping = true;
                    jump_timer=10;
                    jumpSpeed = jumpHeight;
                    vsp = -jumpSpeed; // Immediate velocity change
                } 
                
                if (isJumping) {
                    //WALLJUMP
                    if (place_meeting(bbox_left-20, y-40, floor_obj)) {
                        jumpSpeed = jumpHeight;
                        wall_jumping = true;
                        wall_jump_force=20;
                        alarm[3] = 30;
                    }
                    if (place_meeting(bbox_right+20, y-40, floor_obj)) {
                        jumpSpeed = jumpHeight;
                        wall_jumping = true;
                        wall_jump_force=-20;
                        alarm[3] = 30;
                    }
                    // Only allow gravity switch at peak of jump
                    if (jump_timer<=0 && vsp >= 0) {
                        grav_dir="up";
                        jump_timer=10;
                        isJumping = false; // Reset jump state on gravity switch
                    }
                }
            } else {
                // Ceiling jump - when gravity is up
                if (!isJumping && (place_meeting(x,y-1,ceil_obj) || place_meeting(x,y-1,floor_obj))) {
                    isJumping = true;
                    jump_timer=10;
                    jumpSpeed = jumpHeight;
                    vsp = -jumpSpeed; // Negative for upward movement in ceiling state
                }
                
                if (isJumping) {
                    //WALLJUMP from ceiling
                    if (place_meeting(bbox_left-20, y+40, ceil_obj) || place_meeting(bbox_left-20, y+40, floor_obj)) {
                        jumpSpeed = jumpHeight;
                        wall_jumping = true;
                        wall_jump_force=20;
                        alarm[3] = 30;
                    }
                    if (place_meeting(bbox_right+20, y+40, ceil_obj) || place_meeting(bbox_right+20, y+40, floor_obj)) {
                        jumpSpeed = jumpHeight;
                        wall_jumping = true;
                        wall_jump_force=-20;
                        alarm[3] = 30;
                    }
                    // Allow double-jump to switch back to normal gravity
                    if (move_up && jump_timer<=0) {
                        grav_dir="down";
                        jump_timer=10;
                        isJumping = false;
                        vsp = -jumpHeight; // Give an upward boost when switching back
                    }
                }
            }
// NORMAL GAME MODE ARCADE
		} else {
			
			
			if (!isJumping && !place_empty(x,y,floor_obj)) 
			{
	        isJumping = true;
			jump_timer=10;
	        jumpSpeed = jumpHeight;
			} 
		
			else 
			{
		 //isJumping = false;
			}
			if (isJumping=true) 
			{
				//WALLJUMP
				if (place_meeting(bbox_left-20, y-40, floor_obj))
				{
							  
						//vsp = -jumpSpeed;
						jumpSpeed = jumpHeight;
						wall_jumping = true;
						wall_jump_force=20;
						alarm[3] = 30;
				
				}
				if (place_meeting(bbox_right+20, y-40, floor_obj))
				{
					//vsp = -jumpSpeed;
						jumpSpeed = jumpHeight;
						wall_jumping = true;
						wall_jump_force=-20;
						alarm[3] = 30;
				}
			}
		

		}
	}
}

    if (move_down) && place_empty(x,bbox_bottom,floor_obj) {
        if jetpack_mode=3 {
			vsp += 0.4;
		}
	}


if (isJumping) {
	if (grav_dir="up") {

    jumpSpeed += grav; // Mobile
    y += jumpSpeed; //Mobile
	y+=10; // Mobile
	} else {	
    jumpSpeed -= grav;
    y -= jumpSpeed;
	y-=10;
	}
	
}

if (jump_timer>0) {jump_timer--;}
// Handle gravity flip
if (!isJumping && (move_up || talk_button) && (jump_timer==0) && (game_style=="mv")) {
    // Can only flip gravity when touching a surface
    if (grav_dir=="down" && !place_empty(x,y,floor_obj)) {
        // Flip from ground to ceiling
        jumpSpeed = 0;
        vsp = 0; // Reset vertical speed
        grav_dir = "up";
        jump_timer = 10;
        isJumping = false; // Don't count this as a jump
    } else if (grav_dir=="up" && (place_meeting(x,y-1,ceil_obj) || place_meeting(x,y-1,floor_obj))) {
        // Flip from ceiling to ground - check both ceil_obj and floor_obj  
        jumpSpeed = 0;
        vsp = 0; // Reset vertical speed
        grav_dir = "down";
        jump_timer = 10;
        isJumping = false; // Don't count this as a jump
    }
}

///JETPACK2 offsets
if (facing_right) {
offsetX=25*scale;
} else {
offsetX=-25*scale;
}
offsetY=75*scale;


//ERROR
if keyboard_check(ord("W")) {event_perform(ev_keyboard,vk_up);}
if keyboard_check(ord("A")) {event_perform(ev_keyboard,vk_left);}
if keyboard_check(ord("S")) {event_perform(ev_keyboard,vk_down);}
if keyboard_check(ord("D")) {event_perform(ev_keyboard,vk_right);}


// Shoot button
if (shoot_button) {
    // Code to handle shooting
}

// Melee button
if (melee_button) {
    // Code to handle melee attack
}

// Change weapon button
if (change_weapon_button) {
    weapon++;
}

// Pause menu button
if (pause_button) {
    // Code to open the pause menu
}


if hsp > max_speed
    hsp = max_speed;
if hsp < -max_speed
    hsp = -max_speed;
if vsp > max_speed
    vsp = max_speed;
if vsp < -max_speed
    vsp = -max_speed;
	




angle_head = image_angle;
angle_body = image_angle;
angle_jet = image_angle;
angle_armF = image_angle;
angle_armB = image_angle;
angle_legB = image_angle;
angle_legF = image_angle;


/// --- moddified bbox
if jetpack_mode==1
{
	image_angle = 0;
	//gravity=.5;
	//grav=.5;
// Calculate the bounding box for each sprite relative to sprite_body
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprite_body), nx_head - sprite_get_bbox_left(sprite_head), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprite_body) - sprite_get_bbox_left(sprite_body), nx_head + sprite_get_bbox_right(sprite_head) - sprite_get_bbox_left(sprite_head), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprite_body), ny_head - sprite_get_bbox_top(sprite_head), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprite_body) - sprite_get_bbox_top(sprite_body), ny_head + sprite_get_bbox_bottom(sprite_head) - sprite_get_bbox_top(sprite_head), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprite_body
var bbox_body_left = x - sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprite_body) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprite_body) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprite_head) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale;

var bbox_armB_left = nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_right = nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_top = ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armB_bottom = ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_armF_left = nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_right = nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_top = ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armF_bottom = ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_legB_left = nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_right = nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_top = ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legB_bottom = ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale;

var bbox_legF_left = nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_right = nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_top = ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legF_bottom = ny_legF + sprite_get_bbox_bottom(sprLeg3)  * image_yscale;
// Calculate the bounding box for each sprite relative to sprite_body 
var bbox_body = [x - sprite_get_bbox_right(sprite_body) * image_xscale, y - sprite_get_bbox_top(sprite_body) * image_yscale, x + sprite_get_bbox_right(sprite_body) * image_xscale, y + sprite_get_bbox_bottom(sprite_body) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprite_head) * image_xscale, ny_head - sprite_get_bbox_top(sprite_head) * image_yscale, nx_head + sprite_get_bbox_right(sprite_head) * image_xscale, ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle_body = cos(degtorad(image_angle));
var sin_angle_body = sin(degtorad(image_angle));
var cos_angle_head = cos(degtorad(angle_head));
var sin_angle_head = sin(degtorad(angle_head));
var cos_angle_armB = cos(degtorad(angle_armB));
var sin_angle_armB = sin(degtorad(angle_armB));
var cos_angle_armF = cos(degtorad(angle_armF));
var sin_angle_armF = sin(degtorad(angle_armF));
var cos_angle_legB = cos(degtorad(angle_legB));
var sin_angle_legB = sin(degtorad(angle_legB));
var cos_angle_legF = cos(degtorad(angle_legF));
var sin_angle_legF = sin(degtorad(angle_legF));
var cos_angle_jet = cos(degtorad(angle_jet));
var sin_angle_jet = sin(degtorad(angle_jet));

var rotated_bbox_body = bbox_rotate(bbox_body, image_angle);
var rotated_bbox_head = bbox_rotate(bbox_head, angle_head);
var rotated_bbox_armB = bbox_rotate(bbox_armB, angle_armB);
var rotated_bbox_armF = bbox_rotate(bbox_armF, angle_armF);
var rotated_bbox_legB = bbox_rotate(bbox_legB, angle_legB);
var rotated_bbox_legF = bbox_rotate(bbox_legF, angle_legF);
var rotated_bbox_jet = bbox_rotate(bbox_jet, angle_jet);

// Calculate the modified bounding box coordinates
var modified_bbox_left = min(
    x + rotated_bbox_body[0] * cos_angle_body - rotated_bbox_body[1] * sin_angle_body,
    nx_head + rotated_bbox_head[0] * cos_angle_head - rotated_bbox_head[1] * sin_angle_head,
    nx_armB + rotated_bbox_armB[0] * cos_angle_armB - rotated_bbox_armB[1] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[0] * cos_angle_armF - rotated_bbox_armF[1] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[0] * cos_angle_legB - rotated_bbox_legB[1] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[0] * cos_angle_legF - rotated_bbox_legF[1] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[0] * cos_angle_jet - rotated_bbox_jet[1] * sin_angle_jet
);

var modified_bbox_right = max(
    x + rotated_bbox_body[2] * cos_angle_body - rotated_bbox_body[3] * sin_angle_body,
    nx_head + rotated_bbox_head[2] * cos_angle_head - rotated_bbox_head[3] * sin_angle_head,
    nx_armB + rotated_bbox_armB[2] * cos_angle_armB - rotated_bbox_armB[3] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[2] * cos_angle_armF - rotated_bbox_armF[3] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[2] * cos_angle_legB - rotated_bbox_legB[3] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[2] * cos_angle_legF - rotated_bbox_legF[3] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[2] * cos_angle_jet - rotated_bbox_jet[3] * sin_angle_jet
);

var modified_bbox_top = min(
    y + rotated_bbox_body[0] * sin_angle_body + rotated_bbox_body[1] * cos_angle_body,
    ny_head + rotated_bbox_head[0] * sin_angle_head + rotated_bbox_head[1] * cos_angle_head,
    ny_armB + rotated_bbox_armB[0] * sin_angle_armB + rotated_bbox_armB[1] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[0] * sin_angle_armF + rotated_bbox_armF[1] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[0] * sin_angle_legB + rotated_bbox_legB[1] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[0] * sin_angle_legF + rotated_bbox_legF[1] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[0] * sin_angle_jet + rotated_bbox_jet[1] * cos_angle_jet
);

var modified_bbox_bottom = min(
    y + rotated_bbox_body[2] * sin_angle_body + rotated_bbox_body[3] * cos_angle_body,
    ny_head + rotated_bbox_head[2] * sin_angle_head + rotated_bbox_head[3] * cos_angle_head,
    ny_armB + rotated_bbox_armB[2] * sin_angle_armB + rotated_bbox_armB[3] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[2] * sin_angle_armF + rotated_bbox_armF[3] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[2] * sin_angle_legB + rotated_bbox_legB[3] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[2] * sin_angle_legF + rotated_bbox_legF[3] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[2] * sin_angle_jet + rotated_bbox_jet[3] * cos_angle_jet
);

// Calculate the overall width and height
var width = modified_bbox_right - modified_bbox_left;
var height = modified_bbox_bottom - modified_bbox_top;
}



if jetpack_mode==2
{
	//grav=0.5;
image_angle = 0 - 2 * hsp;

// Calculate the bounding box for each sprite relative to sprite_body
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprite_body), nx_head - sprite_get_bbox_left(sprite_head), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprite_body) - sprite_get_bbox_left(sprite_body), nx_head + sprite_get_bbox_right(sprite_head) - sprite_get_bbox_left(sprite_head), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprite_body), ny_head - sprite_get_bbox_top(sprite_head), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprite_body) - sprite_get_bbox_top(sprite_body), ny_head + sprite_get_bbox_bottom(sprite_head) - sprite_get_bbox_top(sprite_head), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprite_body
var bbox_body_left = x - sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprite_body) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprite_body) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprite_head) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale;

var bbox_armB_left = nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_right = nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_top = ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armB_bottom = ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_armF_left = nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_right = nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_top = ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armF_bottom = ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_legB_left = nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_right = nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_top = ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legB_bottom = ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale;

var bbox_legF_left = nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_right = nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_top = ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legF_bottom = ny_legF + sprite_get_bbox_bottom(sprLeg3)  * image_yscale;
// Calculate the bounding box for each sprite relative to sprite_body 
var bbox_body = [x - sprite_get_bbox_right(sprite_body) * image_xscale, y - sprite_get_bbox_top(sprite_body) * image_yscale, x + sprite_get_bbox_right(sprite_body) * image_xscale, y + sprite_get_bbox_bottom(sprite_body) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprite_head) * image_xscale, ny_head - sprite_get_bbox_top(sprite_head) * image_yscale, nx_head + sprite_get_bbox_right(sprite_head) * image_xscale, ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle_body = cos(degtorad(image_angle));
var sin_angle_body = sin(degtorad(image_angle));
var cos_angle_head = cos(degtorad(angle_head));
var sin_angle_head = sin(degtorad(angle_head));
var cos_angle_armB = cos(degtorad(angle_armB));
var sin_angle_armB = sin(degtorad(angle_armB));
var cos_angle_armF = cos(degtorad(angle_armF));
var sin_angle_armF = sin(degtorad(angle_armF));
var cos_angle_legB = cos(degtorad(angle_legB));
var sin_angle_legB = sin(degtorad(angle_legB));
var cos_angle_legF = cos(degtorad(angle_legF));
var sin_angle_legF = sin(degtorad(angle_legF));
var cos_angle_jet = cos(degtorad(angle_jet));
var sin_angle_jet = sin(degtorad(angle_jet));

var rotated_bbox_body = bbox_rotate(bbox_body, image_angle);
var rotated_bbox_head = bbox_rotate(bbox_head, angle_head);
var rotated_bbox_armB = bbox_rotate(bbox_armB, angle_armB);
var rotated_bbox_armF = bbox_rotate(bbox_armF, angle_armF);
var rotated_bbox_legB = bbox_rotate(bbox_legB, angle_legB);
var rotated_bbox_legF = bbox_rotate(bbox_legF, angle_legF);
var rotated_bbox_jet = bbox_rotate(bbox_jet, angle_jet);

// Calculate the modified bounding box coordinates
var modified_bbox_left = min(
    x + rotated_bbox_body[0] * cos_angle_body - rotated_bbox_body[1] * sin_angle_body,
    nx_head + rotated_bbox_head[0] * cos_angle_head - rotated_bbox_head[1] * sin_angle_head,
    nx_armB + rotated_bbox_armB[0] * cos_angle_armB - rotated_bbox_armB[1] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[0] * cos_angle_armF - rotated_bbox_armF[1] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[0] * cos_angle_legB - rotated_bbox_legB[1] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[0] * cos_angle_legF - rotated_bbox_legF[1] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[0] * cos_angle_jet - rotated_bbox_jet[1] * sin_angle_jet
);

var modified_bbox_right = max(
    x + rotated_bbox_body[2] * cos_angle_body - rotated_bbox_body[3] * sin_angle_body,
    nx_head + rotated_bbox_head[2] * cos_angle_head - rotated_bbox_head[3] * sin_angle_head,
    nx_armB + rotated_bbox_armB[2] * cos_angle_armB - rotated_bbox_armB[3] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[2] * cos_angle_armF - rotated_bbox_armF[3] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[2] * cos_angle_legB - rotated_bbox_legB[3] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[2] * cos_angle_legF - rotated_bbox_legF[3] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[2] * cos_angle_jet - rotated_bbox_jet[3] * sin_angle_jet
);

var modified_bbox_top = min(
    y + rotated_bbox_body[0] * sin_angle_body + rotated_bbox_body[1] * cos_angle_body,
    ny_head + rotated_bbox_head[0] * sin_angle_head + rotated_bbox_head[1] * cos_angle_head,
    ny_armB + rotated_bbox_armB[0] * sin_angle_armB + rotated_bbox_armB[1] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[0] * sin_angle_armF + rotated_bbox_armF[1] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[0] * sin_angle_legB + rotated_bbox_legB[1] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[0] * sin_angle_legF + rotated_bbox_legF[1] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[0] * sin_angle_jet + rotated_bbox_jet[1] * cos_angle_jet
);

var modified_bbox_bottom = min(
    y + rotated_bbox_body[2] * sin_angle_body + rotated_bbox_body[3] * cos_angle_body,
    ny_head + rotated_bbox_head[2] * sin_angle_head + rotated_bbox_head[3] * cos_angle_head,
    ny_armB + rotated_bbox_armB[2] * sin_angle_armB + rotated_bbox_armB[3] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[2] * sin_angle_armF + rotated_bbox_armF[3] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[2] * sin_angle_legB + rotated_bbox_legB[3] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[2] * sin_angle_legF + rotated_bbox_legF[3] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[2] * sin_angle_jet + rotated_bbox_jet[3] * cos_angle_jet
);

// Calculate the overall width and height
var width = modified_bbox_right - modified_bbox_left;
var height = modified_bbox_bottom - modified_bbox_top;
}

if jetpack_mode==3
{
	grav=0;
image_angle = 0 - 2 * hsp;

// Calculate the bounding box for each sprite relative to sprite_body
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprite_body), nx_head - sprite_get_bbox_left(sprite_head), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprite_body) - sprite_get_bbox_left(sprite_body), nx_head + sprite_get_bbox_right(sprite_head) - sprite_get_bbox_left(sprite_head), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprite_body), ny_head - sprite_get_bbox_top(sprite_head), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprite_body) - sprite_get_bbox_top(sprite_body), ny_head + sprite_get_bbox_bottom(sprite_head) - sprite_get_bbox_top(sprite_head), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprite_body
var bbox_body_left = x - sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprite_body) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprite_body) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprite_head) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale;

var bbox_armB_left = nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_right = nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_top = ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armB_bottom = ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_armF_left = nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_right = nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_top = ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armF_bottom = ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_legB_left = nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_right = nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_top = ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legB_bottom = ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale;

var bbox_legF_left = nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_right = nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_top = ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legF_bottom = ny_legF + sprite_get_bbox_bottom(sprLeg3)  * image_yscale;
// Calculate the bounding box for each sprite relative to sprite_body 
var bbox_body = [x - sprite_get_bbox_right(sprite_body) * image_xscale, y - sprite_get_bbox_top(sprite_body) * image_yscale, x + sprite_get_bbox_right(sprite_body) * image_xscale, y + sprite_get_bbox_bottom(sprite_body) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprite_head) * image_xscale, ny_head - sprite_get_bbox_top(sprite_head) * image_yscale, nx_head + sprite_get_bbox_right(sprite_head) * image_xscale, ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle_body = cos(degtorad(image_angle));
var sin_angle_body = sin(degtorad(image_angle));
var cos_angle_head = cos(degtorad(angle_head));
var sin_angle_head = sin(degtorad(angle_head));
var cos_angle_armB = cos(degtorad(angle_armB));
var sin_angle_armB = sin(degtorad(angle_armB));
var cos_angle_armF = cos(degtorad(angle_armF));
var sin_angle_armF = sin(degtorad(angle_armF));
var cos_angle_legB = cos(degtorad(angle_legB));
var sin_angle_legB = sin(degtorad(angle_legB));
var cos_angle_legF = cos(degtorad(angle_legF));
var sin_angle_legF = sin(degtorad(angle_legF));
var cos_angle_jet = cos(degtorad(angle_jet));
var sin_angle_jet = sin(degtorad(angle_jet));

var rotated_bbox_body = bbox_rotate(bbox_body, image_angle);
var rotated_bbox_head = bbox_rotate(bbox_head, angle_head);
var rotated_bbox_armB = bbox_rotate(bbox_armB, angle_armB);
var rotated_bbox_armF = bbox_rotate(bbox_armF, angle_armF);
var rotated_bbox_legB = bbox_rotate(bbox_legB, angle_legB);
var rotated_bbox_legF = bbox_rotate(bbox_legF, angle_legF);
var rotated_bbox_jet = bbox_rotate(bbox_jet, angle_jet);

// Calculate the modified bounding box coordinates
var modified_bbox_left = min(
    x + rotated_bbox_body[0] * cos_angle_body - rotated_bbox_body[1] * sin_angle_body,
    nx_head + rotated_bbox_head[0] * cos_angle_head - rotated_bbox_head[1] * sin_angle_head,
    nx_armB + rotated_bbox_armB[0] * cos_angle_armB - rotated_bbox_armB[1] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[0] * cos_angle_armF - rotated_bbox_armF[1] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[0] * cos_angle_legB - rotated_bbox_legB[1] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[0] * cos_angle_legF - rotated_bbox_legF[1] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[0] * cos_angle_jet - rotated_bbox_jet[1] * sin_angle_jet
);

var modified_bbox_right = max(
    x + rotated_bbox_body[2] * cos_angle_body - rotated_bbox_body[3] * sin_angle_body,
    nx_head + rotated_bbox_head[2] * cos_angle_head - rotated_bbox_head[3] * sin_angle_head,
    nx_armB + rotated_bbox_armB[2] * cos_angle_armB - rotated_bbox_armB[3] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[2] * cos_angle_armF - rotated_bbox_armF[3] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[2] * cos_angle_legB - rotated_bbox_legB[3] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[2] * cos_angle_legF - rotated_bbox_legF[3] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[2] * cos_angle_jet - rotated_bbox_jet[3] * sin_angle_jet
);

var modified_bbox_top = min(
    y + rotated_bbox_body[0] * sin_angle_body + rotated_bbox_body[1] * cos_angle_body,
    ny_head + rotated_bbox_head[0] * sin_angle_head + rotated_bbox_head[1] * cos_angle_head,
    ny_armB + rotated_bbox_armB[0] * sin_angle_armB + rotated_bbox_armB[1] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[0] * sin_angle_armF + rotated_bbox_armF[1] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[0] * sin_angle_legB + rotated_bbox_legB[1] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[0] * sin_angle_legF + rotated_bbox_legF[1] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[0] * sin_angle_jet + rotated_bbox_jet[1] * cos_angle_jet
);

var modified_bbox_bottom = min(
    y + rotated_bbox_body[2] * sin_angle_body + rotated_bbox_body[3] * cos_angle_body,
    ny_head + rotated_bbox_head[2] * sin_angle_head + rotated_bbox_head[3] * cos_angle_head,
    ny_armB + rotated_bbox_armB[2] * sin_angle_armB + rotated_bbox_armB[3] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[2] * sin_angle_armF + rotated_bbox_armF[3] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[2] * sin_angle_legB + rotated_bbox_legB[3] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[2] * sin_angle_legF + rotated_bbox_legF[3] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[2] * sin_angle_jet + rotated_bbox_jet[3] * cos_angle_jet
);

// Calculate the overall width and height
var width = modified_bbox_right - modified_bbox_left;
var height = modified_bbox_bottom - modified_bbox_top;
}


if jetpack_mode==4
{
	image_angle = 0;
	//gravity=.5;
	//grav=.5;
// Calculate the bounding box for each sprite relative to sprite_body
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprite_body), nx_head - sprite_get_bbox_left(sprite_head), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprite_body) - sprite_get_bbox_left(sprite_body), nx_head + sprite_get_bbox_right(sprite_head) - sprite_get_bbox_left(sprite_head), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprite_body), ny_head - sprite_get_bbox_top(sprite_head), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprite_body) - sprite_get_bbox_top(sprite_body), ny_head + sprite_get_bbox_bottom(sprite_head) - sprite_get_bbox_top(sprite_head), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprite_body
var bbox_body_left = x - sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprite_body) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprite_body) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprite_body) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprite_head) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprite_head) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale;

var bbox_armB_left = nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_right = nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armB_top = ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armB_bottom = ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_armF_left = nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_right = nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale;
var bbox_armF_top = ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale;
var bbox_armF_bottom = ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale;

var bbox_legB_left = nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_right = nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legB_top = ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legB_bottom = ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale;

var bbox_legF_left = nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_right = nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale;
var bbox_legF_top = ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale;
var bbox_legF_bottom = ny_legF + sprite_get_bbox_bottom(sprLeg3)  * image_yscale;
// Calculate the bounding box for each sprite relative to sprite_body 
var bbox_body = [x - sprite_get_bbox_right(sprite_body) * image_xscale, y - sprite_get_bbox_top(sprite_body) * image_yscale, x + sprite_get_bbox_right(sprite_body) * image_xscale, y + sprite_get_bbox_bottom(sprite_body) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprite_head) * image_xscale, ny_head - sprite_get_bbox_top(sprite_head) * image_yscale, nx_head + sprite_get_bbox_right(sprite_head) * image_xscale, ny_head + sprite_get_bbox_bottom(sprite_head) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprite_body image_angle
var cos_angle_body = cos(degtorad(image_angle));
var sin_angle_body = sin(degtorad(image_angle));
var cos_angle_head = cos(degtorad(angle_head));
var sin_angle_head = sin(degtorad(angle_head));
var cos_angle_armB = cos(degtorad(angle_armB));
var sin_angle_armB = sin(degtorad(angle_armB));
var cos_angle_armF = cos(degtorad(angle_armF));
var sin_angle_armF = sin(degtorad(angle_armF));
var cos_angle_legB = cos(degtorad(angle_legB));
var sin_angle_legB = sin(degtorad(angle_legB));
var cos_angle_legF = cos(degtorad(angle_legF));
var sin_angle_legF = sin(degtorad(angle_legF));
var cos_angle_jet = cos(degtorad(angle_jet));
var sin_angle_jet = sin(degtorad(angle_jet));

var rotated_bbox_body = bbox_rotate(bbox_body, image_angle);
var rotated_bbox_head = bbox_rotate(bbox_head, angle_head);
var rotated_bbox_armB = bbox_rotate(bbox_armB, angle_armB);
var rotated_bbox_armF = bbox_rotate(bbox_armF, angle_armF);
var rotated_bbox_legB = bbox_rotate(bbox_legB, angle_legB);
var rotated_bbox_legF = bbox_rotate(bbox_legF, angle_legF);
var rotated_bbox_jet = bbox_rotate(bbox_jet, angle_jet);

// Calculate the modified bounding box coordinates
var modified_bbox_left = min(
    x + rotated_bbox_body[0] * cos_angle_body - rotated_bbox_body[1] * sin_angle_body,
    nx_head + rotated_bbox_head[0] * cos_angle_head - rotated_bbox_head[1] * sin_angle_head,
    nx_armB + rotated_bbox_armB[0] * cos_angle_armB - rotated_bbox_armB[1] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[0] * cos_angle_armF - rotated_bbox_armF[1] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[0] * cos_angle_legB - rotated_bbox_legB[1] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[0] * cos_angle_legF - rotated_bbox_legF[1] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[0] * cos_angle_jet - rotated_bbox_jet[1] * sin_angle_jet
);

var modified_bbox_right = max(
    x + rotated_bbox_body[2] * cos_angle_body - rotated_bbox_body[3] * sin_angle_body,
    nx_head + rotated_bbox_head[2] * cos_angle_head - rotated_bbox_head[3] * sin_angle_head,
    nx_armB + rotated_bbox_armB[2] * cos_angle_armB - rotated_bbox_armB[3] * sin_angle_armB,
    nx_armF + rotated_bbox_armF[2] * cos_angle_armF - rotated_bbox_armF[3] * sin_angle_armF,
    nx_legB + rotated_bbox_legB[2] * cos_angle_legB - rotated_bbox_legB[3] * sin_angle_legB,
    nx_legF + rotated_bbox_legF[2] * cos_angle_legF - rotated_bbox_legF[3] * sin_angle_legF,
    nx_jet + rotated_bbox_jet[2] * cos_angle_jet - rotated_bbox_jet[3] * sin_angle_jet
);

var modified_bbox_top = min(
    y + rotated_bbox_body[0] * sin_angle_body + rotated_bbox_body[1] * cos_angle_body,
    ny_head + rotated_bbox_head[0] * sin_angle_head + rotated_bbox_head[1] * cos_angle_head,
    ny_armB + rotated_bbox_armB[0] * sin_angle_armB + rotated_bbox_armB[1] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[0] * sin_angle_armF + rotated_bbox_armF[1] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[0] * sin_angle_legB + rotated_bbox_legB[1] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[0] * sin_angle_legF + rotated_bbox_legF[1] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[0] * sin_angle_jet + rotated_bbox_jet[1] * cos_angle_jet
);

var modified_bbox_bottom = min(
    y + rotated_bbox_body[2] * sin_angle_body + rotated_bbox_body[3] * cos_angle_body,
    ny_head + rotated_bbox_head[2] * sin_angle_head + rotated_bbox_head[3] * cos_angle_head,
    ny_armB + rotated_bbox_armB[2] * sin_angle_armB + rotated_bbox_armB[3] * cos_angle_armB,
    ny_armF + rotated_bbox_armF[2] * sin_angle_armF + rotated_bbox_armF[3] * cos_angle_armF,
    ny_legB + rotated_bbox_legB[2] * sin_angle_legB + rotated_bbox_legB[3] * cos_angle_legB,
    ny_legF + rotated_bbox_legF[2] * sin_angle_legF + rotated_bbox_legF[3] * cos_angle_legF,
    ny_jet + rotated_bbox_jet[2] * sin_angle_jet + rotated_bbox_jet[3] * cos_angle_jet
);

// Calculate the overall width and height
var width = modified_bbox_right - modified_bbox_left;
var height = modified_bbox_bottom - modified_bbox_top;
}




if (jetpack_mode == 4) {

    // Physics baseline for this mode
  grav = jp4_grav;
   var grav_mul = 1.0;
	if (jetpack_mode == 4 && jp4_state == JP4_STATE_SLAM) grav_mul = 0.6;
	vsp += grav * grav_mul;


    // Optional: circular mask while in roll/charge/slam for cleaner collisions
    if (jp4_state == JP4_STATE_ROLL || jp4_state == JP4_STATE_CHARGE || jp4_state == JP4_STATE_SLAM || jp4_state == JP4_STATE_HOMING) {
        if (mask_index != sprMaskBall) mask_index = sprMaskBall;
    } else if (mask_index == sprMaskBall) {
        mask_index = sprite_index; // or your normal mask
    }

    // --- INPUTS ---
    var press_rollTap  = keyboard_check_pressed(btn_rollTap);
    var hold_charge    = mouse_check_button(btn_charge) || keyboard_check(vk_control);
    var release_charge = (!mouse_check_button(btn_charge) && !keyboard_check(vk_control));
    var press_homing   = keyboard_check_pressed(btn_homing);

    // --- STATE MACHINE ---
    switch (jp4_state) {

        case JP4_STATE_IDLE:
            // quick entry points
            if (press_rollTap) _jp4_start_roll();
            if (hold_charge)   _jp4_start_charge();
        break;

        case JP4_STATE_ROLL:
		{
		    // ✅ Correct ground check: "am I touching a solid one pixel below?"
		    var on_ground = place_meeting(x, y + 1, ground_obj); // <-- use ground_obj (set once)

		    // steer
		    if (on_ground) {
		        if (move_left)  hsp -= 0.6;
		        if (move_right) hsp += 0.6;
		        hsp *= jp4_fric_ground;
		        image_angle += sign(hsp) * 18;

		        // ❌ vsp = 0;  <-- remove this; let the vertical resolver zero vsp
		    } else {
		        // air control & spin
		        if (move_left)  hsp -= jp4_air_control;
		        if (move_right) hsp += jp4_air_control;
		        hsp *= jp4_fric_air;
		        image_angle += sign(hsp) * 14;
		    }

		    if (hold_charge) _jp4_start_charge();
		    if (press_homing && !on_ground) _jp4_try_homing();
		}
		break;


        case JP4_STATE_CHARGE:
        {
            // you can slide a tiny bit, but mostly we “tighten”
            hsp *= 0.92;

            // build up charge
            jp4_charge = min(jp4_charge + jp4_charge_rate, jp4_charge_max);

            // subtle breathe squash while charging
            var wob = 0.04 * sin(current_time * 0.02);
            _jp4_squash(1.0 - 0.12 + wob, 1.0 + 0.12 - wob, 2);

            if (release_charge) _jp4_release_slam();
            if (press_homing)   _jp4_try_homing();
        }
        break;

        case JP4_STATE_SLAM:
        {
            // during slam, maintain trajectory with slight drag
            hsp *= 0.995;
            //vsp += grav * 0.6; // reduced gravity during slam so it carries

            // auto-end when we slow down a lot in air
            if (abs(hsp) + abs(vsp) < 3) jp4_state = JP4_STATE_IDLE;
        }
        break;

        case JP4_STATE_HOMING:
        {
            jp4_homing_t--;
            if (jp4_homing_t <= 0) {
                jp4_state = JP4_STATE_IDLE;
            } else {
                // keep speed pointed where we started (simple burst)
                var spd = point_distance(0,0,hsp,vsp);
                var dir = point_direction(0,0,hsp,vsp);
                spd = max(spd, jp4_homing_speed);
                hsp = lengthdir_x(spd, dir);
                vsp = lengthdir_y(spd, dir);
            }
        }
        break;
    }

    // Gravity (you already add vsp += grav later; ok to leave this as is)
    // vsp += grav;  // keep your global vertical integration below

    // --- SQUASH & STRETCH DECAY ---
    if (jp4_squash_t > 0) jp4_squash_t--;
    var sx = lerp(jp4_squash_x, 1, (jp4_squash_time - jp4_squash_t) / max(1,jp4_squash_time));
    var sy = lerp(jp4_squash_y, 1, (jp4_squash_time - jp4_squash_t) / max(1,jp4_squash_time));
    // apply on top of your existing scale
    image_xscale = scale * sx;
    image_yscale = scale * sy;

    // facing for cosmetics
    if (hsp >  0.25) facing_right = true;
    if (hsp < -0.25) facing_right = false;
}






// Horizontal movement

// Check for horizontal collisions
	if place_meeting(bbox_left-10+hsp,y-20,floor_obj) || place_meeting(bbox_right+10+hsp,y-20,floor_obj) {
		hsp = 0; // Stop horizontal movement when no key is pressed
		hsp_walk=0;
		walk=false;
		idle=true;
		wall_direction=0;
	}
	// _mv Metroidvania
	if place_meeting(bbox_left-10+hsp,y-20,ceil_obj) || place_meeting(bbox_right+10+hsp,y-20,floor_obj) {
		hsp = 0; // Stop horizontal movement when no key is pressed
		hsp_walk=0;
		walk=false;
		idle=true;
		wall_direction=0;
	}
	
	
if (place_meeting(x + hsp, y, obj_block_64)) {
    while (!place_meeting(x + sign(hsp), y, obj_block_64)) {
        x += sign(hsp);
    }
    hsp = 0; // Stop horizontal movement
}

if (hsp_walk>0) && (hsp_walk>hsp_walk_max) {hsp_walk=hsp_walk_max;}
if (hsp_walk<0) && (abs(hsp_walk)>hsp_walk_max) {hsp_walk=-hsp_walk_max;}
if wall_jump_force>0 {wall_jump_force-=1;}
if wall_jump_force<0 {wall_jump_force+=1;}

x += hsp + wall_jump_force + hsp_walk; // Apply horizontal movement

// Vertical movement
vsp += grav;
y += vsp; // Apply vertical movement

if (vsp > 10) vsp = 10; // Limit maximum fall speed

// Check for vertical collisions with ground and ceiling
if (grav_dir == "down") {
    // Ground collision
    if (place_meeting(x, y + modified_bbox_bottom, obj_block_64)) {
        while (!place_meeting(x, y + sign(vsp), obj_block_64)) {
            y += sign(vsp);
        }
        vsp = 0; // Stop vertical movement
        isJumping = false;
        jumpSpeed = 0;
    }
} else {
    // Ceiling collision when gravity is up
    if (place_meeting(x, y - modified_bbox_top, obj_block_64) || place_meeting(x, y - 1, ceil_obj) || place_meeting(x, y - 1, floor_obj)) {
        while (!place_meeting(x, y - sign(vsp), obj_block_64) && !place_meeting(x, y - sign(vsp), ceil_obj) && !place_meeting(x, y - sign(vsp), floor_obj)) {
            y -= sign(vsp);
        }
        vsp = 0; // Stop vertical movement
        isJumping = false;
        jumpSpeed = 0;
        // Allow immediate jump from ceiling
        if (move_up) {
            jump_timer = 0;
        }
    }
}





if !place_empty(x,y,floor_obj) {
	grav=0;
	vsp=0;
	isJumping=false;
	jumpSpeed=0;
	
}



// Jetpack modes 1 and 2 gravity
if (jetpack_mode == 1 || jetpack_mode == 2) {
	
	if (game_style=="mv") {
		
		if  place_empty(x,y,floor_obj) && place_empty(x,y,ceil_obj) {
			if grav_dir="up" {
				grav = -0.5; // Adjust this value as needed
			}else{
				grav = 0.5;
			}
		} 
		// end _mv
		else {
	    grav = 0;
		vsp=0;
		isJumping=false; // Reset gravity when on the sidewalk
	   // y -= 10; // Adjust the vertical position to stay on the floor
		}
	
	} else {
		
		if  place_empty(x,y,floor_obj) 	{
				grav = 0.5;
			} 
		// end _mv
		else {
	    grav = 0;
		vsp=0;
		isJumping=false; // Reset gravity when on the sidewalk
	   // y -= 10; // Adjust the vertical position to stay on the floor
		}
	
	}
	
}


// Update the bounding box coordinates
sprite_set_bbox(sprXeroBlank, modified_bbox_left, modified_bbox_top, modified_bbox_right, modified_bbox_bottom);



//Weapon Limits
if (weapon<0) {weapon=12;}
if (weapon>=13) {weapon=0;}
// Weapon Ammo Control

//Weapon Cooldown
if (wpn_cooldown>0)
{
	wpn_cooldown--;
}
if (wpn_cooldown<0)
{
	wpn_cooldown=0;
}

	if (wpn_charge>wpn_charge_max)
		{wpn_charge=wpn_charge_max;}


if (!shoot_button) {	
	wpn_charge=0;	
}


//BULLETS SYSTEM
if (punch=true) {
	punch_img_idx++;	
}
if (punch_img_idx>10) {
	punch=false;
	punch_img_idx=0;
	
	if (punch_side=="front") { punch_side="back";}
	else if (punch_side=="back") { punch_side="front";}
	
}

if (sword=true) {
	sword_img_idx++;	
}

if (sword_img_idx==13) {
	sword_num = irandom(6);
}

if (sword_img_idx>21) {
	sword=false;
	sword_img_idx=0;
	sword_num = irandom(6);
}

switch (sword_num) {
	case 1:
		spr_sword_arm = sprArmSword_1_Arm;
		spr_sword_sword = sprArmSword_1_Sword;
		spr_sword_fx = sprArmSword_1_Fx;
		break;
	case 2:
		spr_sword_arm = sprArmSword_2_Arm;
		spr_sword_sword = sprArmSword_2_Sword;
		spr_sword_fx = sprArmSword_2_Fx;
		break;
	case 3:
		spr_sword_arm = sprArmSword_3_Arm;
		spr_sword_sword = sprArmSword_3_Sword;
		spr_sword_fx = sprArmSword_3_Fx;
		break;
	case 4:
		spr_sword_arm = sprArmSword_1_Arm_rev;
		spr_sword_sword = sprArmSword_1_Sword_rev;
		spr_sword_fx = sprArmSword_1_Fx_rev;
		break;
	case 5:
		spr_sword_arm = sprArmSword_2_Arm_rev;
		spr_sword_sword = sprArmSword_2_Sword_rev;
		spr_sword_fx = sprArmSword_2_Fx_rev;
		break;
	case 6:
		spr_sword_arm = sprArmSword_3_Arm_rev;
		spr_sword_sword = sprArmSword_3_Sword_rev;
		spr_sword_fx = sprArmSword_3_Fx_rev;
		break;
}


	
if (weapon==0 && punch==false && shoot_button && wpn_cooldown==0) { //FIST
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	
		punch=true;
		wpn_cooldown=10;
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	bullet._id = id;
	
	
	with (bullet) {
		parent=other;
		owner      = other;          // who fired
		team       = other.team; 
		weapon=0;
		attack=5;
		if (parent.punch_side="front") {
		depth=parent.depth-10;
		}else
		if (parent.punch_side="back") {
		depth=parent.depth+10;
		}else{
		depth=parent.depth-10;	
		}
		
		direction=parent.armF_dir;
		//speed=10;
		scale=1*parent.scale;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		//alarm[0]=10;///destroy
		sprite_index=sprArmPunch_fx;
		following_player=true;
		punch_side=parent.punch_side;
		//life_countdown=parent.bullet_life;
		//life_limit=true;		
	}
	
		
	
	}
	
	
	
	if (weapon==1 && shoot_button && wpn_cooldown==0) { //GUN
		//draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	

	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=other;
		owner      = other;          // who fired
		team       = other.team; 
		weapon=1;
		attack=10;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		//wpn_cooldown=2;
		
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	
	if (weapon=2 && shoot_button && wpn_cooldown==0) { //GUN2
		//draw_sprite_ext(sprGun2, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=4;
	with (bullet) {
		parent=other;
		owner      = other;          // who fired
		team       = other.team; 
		weapon=2;
		attack=15;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	}



	if (weapon==3 && shoot_button_pressed && wpn_cooldown==0) { //GUN3 //CHARGE CANON
		//draw_sprite_ext(sprGun3, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=6;
			
	with (bullet) {
		parent=obj_Player1;
		weapon=3;
		depth=parent.depth-1;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
		charging=true;
	}
	
	
	}
	
	if (weapon==3 && shoot_button&& wpn_cooldown==0) {
			wpn_charge+=1;
			attack+=1;
	/*
		if !part_system_exists(global.partSysCharge)
				{
				    global.partSysCharge = part_system_create(part_charge_wpn);
				}
			if part_system_exists(global.partSysCharge) {
			
				var xxx=nx_armF+lengthdir_x(100*scale,armF_dir);
				var yyy=ny_armF+lengthdir_y(100*scale,armF_dir);
				var spwn_rdm = irandom(360);
				var xxxx = xxx + lengthdir_x(20*wpn_charge*scale,spwn_rdm);
				var yyyy = yyy + lengthdir_y(20*wpn_charge*scale,spwn_rdm);
				var dirxy = point_direction(xxxx,yyyy,xxx,yyy);
		
		
				part_type_shape(_ptypeCharge, pt_shape_sphere);
				part_type_size(_ptypeCharge, .1*wpn_charge, .1*wpn_charge, 0, 0);
				part_type_scale(_ptypeCharge, 0.1, 0.1);
				// Get the interpolated color
				var charge_color1 = get_interpolated_color(wpn_charge-2, wpn_charge_max);
				var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
				var charge_color3 = get_interpolated_color(wpn_charge+2, wpn_charge_max);
				//part_type_colour1(_ptypeBlast, charge_color); // Single color for simplicity
				part_type_colour3(_ptypeCharge, charge_color1, charge_color2, charge_color3);
		
				part_type_direction(_ptypeCharge, dirxy, dirxy, 0, 0);
				part_type_life(_ptypeCharge, 2*wpn_charge*scale, 2*wpn_charge*scale);
				//part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,1);
				part_particles_create(global.partSysCharge,xxxx,yyyy,_ptypeCharge,10);
				//part_particles_create(global._ps,nx_fistF,ny_fistF,_ptype1,10);
				//part_system_position(global.partSysCharge,xxx,yyy);
				//part_system_depth(global.partSysCharge,depth-10);
			}
			*/
		}
		
	
	
	if (weapon==4 && sword==false && shoot_button) { //SWORD
			//draw_sprite_ext(sprHandSword, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	
		var attack_force=10;
		//hsp += attack_force * cos(degtorad(armF_dir));
		//vsp -= attack_force * sin(degtorad(armF_dir));
		if place_empty(x+bbox_right,y,floor_obj)  
		{
		//hsp = attack_force * cos(degtorad(attack_angle));
		//vsp = attack_force * sin(degtorad(attack_angle));
		}
		if place_empty(x-bbox_left+hsp,y-20,floor_obj) 
		{
		
		}
	    if place_empty(x,bbox_bottom,floor_obj) 
	    {
	        vsp -= 0.4;
	    }  
	    if place_empty(x,bbox_top,floor_obj)
		{
	        vsp -= 0.4;
	    } 
	
		sword=true;
		wpn_cooldown=10;
	
		bullet = instance_create(nx_fistF,ny_fistF,objBullet);
		
	wpn_cooldown=2;
	
	
	with (bullet) {
		parent=obj_Player1;
		weapon=4;
		attack=25;
		depth=parent.depth-10;
		sprite_index=parent.spr_sword_fx;
		
		//speed=10;
		scale=1*parent.scale;
		if (parent.facing_right) {
			direction=parent.armF_dir;
			image_xscale=1*parent.scale;
			image_yscale=1*parent.scale;
		} else {
			direction=parent.armF_dir;
			image_xscale=1*parent.scale;
			image_yscale=1*parent.scale;
		}
	
		//alarm[0]=10;///destroy
		following_player=true;
		//punch_side=parent.punch_side;
		//life_countdown=parent.bullet_life;
		//life_limit=true;		
	}
	
		
	
	}
	
	if (weapon=5 && shoot_button_pressed && wpn_cooldown==0) { //SHOTGUN
		
		//draw_sprite_ext(sprShotgun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		wpn_cooldown=12;
		
		bullet = instance_create(nx_fistF,ny_fistF,objBullet);
		bullet2 = instance_create(nx_fistF,ny_fistF,objBullet);
		bullet3 = instance_create(nx_fistF,ny_fistF,objBullet);
		bullet4 = instance_create(nx_fistF,ny_fistF,objBullet);
		bullet5 = instance_create(nx_fistF,ny_fistF,objBullet);
	
		with (bullet) {
		parent=obj_Player1;
		weapon=6;
		attack=5;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=parent.bullet_speed+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet2) {
		parent=obj_Player1;
		weapon=6;
		attack=5;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=parent.bullet_speed+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet3) {
		parent=obj_Player1;
		weapon=6;
		attack=5;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=parent.bullet_speed+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet4) {
		parent=obj_Player1;
		weapon=6;
		attack=5;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=parent.bullet_speed+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet5) {
		parent=obj_Player1;
		weapon=6;
		attack=5;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=parent.bullet_speed+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	
	
}
	
	if (weapon=6 && shoot_button && wpn_cooldown==0) { //Raygun
		
		//draw_sprite_ext(sprRayGun, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprRayGun, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	parent=obj_Player1;
	target=objEnemyParent;
	dir=parent.armF_dir;
	origin_x=parent.nx_fistF;
	origin_y=parent.ny_fistF;
	check_x=lengthdir_x(2000,dir);
	check_y=lengthdir_y(2000,dir);
	collision_line(origin_x, origin_y, check_x, check_y, target, false, false);
	
	//
	//
	var x_start = x; // Starting x-coordinate (e.g., laser's current position)
    var y_start = y; // Starting y-coordinate (e.g., laser's current position)
    var laser_angle = 45; // Initial angle of the laser in degrees
    var max_bounces = 5; // Maximum number of bounces
    var wall_object = objCityParent_Skyline; // The object the laser can collide with

    // Call the bounce_raycast function
    var laser_path = bounce_raycast(x_start, y_start, laser_angle, max_bounces, wall_object);

    // Draw the laser's path for visualization
    for (var i = 0; i < array_length(laser_path) - 1; i++) {
        var start_point = laser_path[i];
        var end_point = laser_path[i + 1];

     draw_line(start_point[0], start_point[1], end_point[0], end_point[1]);
	//
	//
	}
	}
	
	if (weapon==7 && shoot_button && wpn_cooldown==0) { //Grenade
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprGrenadeLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=7;
		attack=50;
		depth=parent.depth-1;
		sprite_index=sprGrenade;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		//speed=parent.wpn_charge;
		image_xscale=2*parent.scale;
		image_yscale=2*parent.scale;
		life_countdown=100;
		life_limit=true;
		bounce = true;
		grav = 1;           // Initial vertical speed
		grav_accel = 0.5;   // Acceleration due to gravity
		grav_max = 0;      // Maximum falling speed
		bounce_factor = -0.8; // How much energy is retained after bouncing (-1 = perfect bounce, less than -1 = energy loss)
		h_speed = 4;         // Horizontal speed
		h_friction = 0.98;   // Friction applied to horizontal movement	
		floor_obj = obj_block_64;
	}
	
	}
	if (weapon==8 && shoot_button && wpn_cooldown==0) { //Rocket
		//draw_sprite_ext(sprRocketLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///

	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=8;
		attack=50;
		homing=true;
		if instance_exists(objEnemyParent) {
			target = instance_nearest(x, y, objEnemyParent);
		} else {
			
			target = instance_nearest(x, y, objHuman);
		}
		sprite_index=sprRocket;
		depth=parent.depth+1;
			sprite_index=sprRocket;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		scale=.2;
		image_xscale=scale;
		image_yscale=scale;
		//life_countdown=parent.bullet_life;
		life_countdown=100;
		decay=100;
		life_limit=true;
	}
	
	}
	
	if (weapon==9) { //sniper
		global.snipe=true;
		
		if instance_exists(objSnipe) {
			if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach) {
				global.CameraManager.target=objSnipe;
			}
		} else {
			obj_snipe = instance_create(x,y,objSnipe);
			with (obj_snipe) {
				parent=obj_Player1;
			}
		}
	}else{
		global.snipe=false;
		if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach) {
			global.CameraManager.target=self;
		}
	}
	
	
	if (weapon=9 && shoot_button && wpn_cooldown==0) { //SNIPER
		//draw_sprite_ext(sprSniper, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=9;
		attack=75;
		depth=parent.depth+1;
		sprite_index=sprBullet;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	if (weapon==10 && shoot_button && wpn_cooldown==0) { //FLAMETHROWER
		//draw_sprite_ext(sprFlamethrower, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	if (facing_right) {
		bullet = instance_create(nx_fistF+lengthdir_x(120*scale,armF_dir+15),ny_fistF+lengthdir_y(120*scale,armF_dir+15),objBullet);
	} else {
		bullet = instance_create(nx_fistF+lengthdir_x(120*scale,armF_dir-15),ny_fistF+lengthdir_y(120*scale,armF_dir-15),objBullet);
	}
	
	wpn_cooldown=0;
	with (bullet) {
		parent=obj_Player1;
		weapon=10;
		scale=.05;
		attack=10;
		depth=parent.depth+1;
		sprite_index=sprBullet;
		direction=parent.armF_dir;
		speed=parent.bullet_speed;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		hitbox=true;
		grav=-4;
		decay=40*parent.scale;
	}
	
	
	/*
	if !part_system_exists(global._psFlamethrower)
			{
			    global._psFlamethrower = part_system_create(part_smoke);
			}
		if part_system_exists(global._psFlamethrower) {
			
			part_type_direction(_ptypeFlamethrower,armF_dir +10, armF_dir - 10, 0, 0);
				if (facing_right) {
				
					part_particles_create(global._psFlamethrower,nx_fistF+lengthdir_x(120*scale,armF_dir+10),ny_fistF+lengthdir_y(120*scale,armF_dir+10),_ptypeFlamethrower,10);
				//part_system_position(global.partSysSmoke,nx_fistF,ny_fistF);
				//part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,1);
				//part_system_depth(global.partSysSmoke,depth-10);
				} else {
					part_particles_create(global._psFlamethrower,nx_fistF+lengthdir_x(120*scale,armF_dir-10),ny_fistF+lengthdir_y(120*scale,armF_dir-10),_ptypeFlamethrower,10);
				}
		}
	
		if !part_system_exists(global.partSysSmoke)
			{
			    global.partSysSmoke = part_system_create(part_smoke);
			}
		if part_system_exists(global.partSysSmoke) {
			part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,-1);
			//part_system_position(global.partSysSmoke,nx_fistF,ny_fistF);
			part_system_depth(global.partSysSmoke,depth-10);
		//part_particles_clear(_ptypeSmoke);
		//part_system_destroy(global.partSysSmoke);

		}
	*/
	}
	
	
	
	
	if (weapon==11 && shoot_button_pressed && wpn_cooldown==0) { //TASER
		//draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	taser_img++;
	
	if !instance_exists(objHitbox)
		{
		hitbox = instance_create(nx_fistF,ny_fistF,objBullet);
		wpn_cooldown=2;
		with (hitbox) {
			parent=obj_Player1;
			weapon=12;
			attack=15;
			hitbox=true;
			xx=parent.nx_fistF;
			yy=parent.nx_fistF;
			depth=parent.depth+1;
			sprite_index=sprTaser;
			direction=parent.armF_dir;
			//speed=0;
			image_xscale=parent.image_xscale;
			image_yscale=parent.image_yscale;
			image_angle=parent.armF_dir;
			
			following_player=true;
			
				}
		
		}
	
	}
	if (weapon==11 && shoot_button && wpn_cooldown==0) { //TASER
		
		var xxx=nx_armF+lengthdir_x(200*scale,armF_dir-3);
		var yyy=ny_armF+lengthdir_y(200*scale,armF_dir-3);
		/*part_system_depth(global._psElec,depth-10);
		part_particles_create(global._psElec,xxx,yyy,_ptypeElec,10);
	*/
	
	}
	
	
	if (weapon==12 && shoot_button_pressed && wpn_cooldown==0) { //CHAINSAW
		 
		if !instance_exists(objHitbox)
		{
		hitbox = instance_create(nx_fistF,ny_fistF,objBullet);
		wpn_cooldown=2;
		with (hitbox) {
			parent=obj_Player1;
			weapon=12;
			attack=15;
			hitbox=true;
			xx=parent.nx_fistF;
			yy=parent.nx_fistF;
			depth=parent.depth-1;
			sprite_index=sprChainsaw;
			direction=parent.armF_dir;
			//speed=0;
			image_xscale=parent.image_xscale;
			image_yscale=parent.image_yscale;
			
			image_angle=parent.armF_dir;
			
			following_player=true;
				}
		
		}
		
		
		
		
	}
	
	if (weapon=12 && shoot_button && wpn_cooldown==0) { //CHAINSAW
		//draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		chainsaw_blade++;
		/*
		if !part_system_exists(global.partSysSmoke)
			{
			    global.partSysSmoke = part_system_create(part_smoke);
			}
		if part_system_exists(global.partSysSmoke) {
			



			part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,1);
			//part_system_position(global.partSysSmoke,nx_fistF,ny_fistF);
			part_system_depth(global.partSysSmoke,depth-10);
			
			
			//part_particles_clear(_ptypeSmoke);
			//part_system_destroy(global.partSysSmoke);

		}
		*/
		
	}
	
	
	
	if (weapon=12 && !shoot_button) {
			
			/*
		if !part_system_exists(global.partSysSmoke)
			{
			    part_system_destroy(global.partSysSmoke);
			}
*/

	}
	








if (weapon!=12 || !(shoot_button)) {
	//part_system_destroy(partSysSmoke);
}





///--- MISSION ---///

	