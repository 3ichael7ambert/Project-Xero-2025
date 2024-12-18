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

if (keyboard_check_pressed(ord("X"))) {
	wpn_btn_dir="down";
	weapon-=1;
	
}
if (keyboard_check_pressed(ord("C"))) {
	wpn_btn_dir="up";
	weapon+=1;
	
}


//mouse_aim
xm=window_mouse_get_x();
ym=window_mouse_get_y();

// Get window dimensions
ww = window_get_width();
wh = window_get_height();
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
if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite) {
cm_x=global.CameraManager.x;
cm_y=global.CameraManager.y;
} else {
cm_x=mouse_x;
cm_y=mouse_y;
}

mouse_x_3d=xm+cm_x;
mouse_y_3d=ym+cm_y;
poi = point_direction(x,y,mouse_x_3d,mouse_y_3d);



if keyboard_check_pressed(ord("Q")) {
	if mouse_aim=false {mouse_aim=true;}
	else if mouse_aim=true {mouse_aim=false;}
	}
if mouse_aim=true {
	draw_circle(xm,ym,20,true);
	if mouse_x_3d<x {
		facing_right=false;
	} else {
		facing_right =true;
	}
}

if mouse_aim=false {
	armF_dir=0;
	armB_dir=0;
}
if mouse_aim=true {
	//armF_dir=point_direction(x,y,xm,ym);
	//armB_dir=point_direction(x,y,xm,ym);
	//armF_dir=point_direction(ww/2, wh/2, xm, ym);
	//armB_dir=point_direction(ww/2, wh/2, xm, ym);
	armF_dir=point_direction(x, y, mouse_x_3d, mouse_y_3d);
	armB_dir=point_direction(x, y, mouse_x_3d, mouse_y_3d);
	//armB_dir=0;
}
//if gamepad_is_connected(0) {gamepad=true;} else {gamepad=false;}
if gamepad_is_connected(0) && mouse_aim=false {
	gamepad=true;
	armF_dir=point_direction(0, 0, gamepad_axis_value(0,gp_axisrh), -gamepad_axis_value(0,gp_axisrv));
	armB_dir=point_direction(0, 0, gamepad_axis_value(0,gp_axisrh), -gamepad_axis_value(0,gp_axisrv));
} else {gamepad=false;}
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

// Check if gamepad is connected
if gamepad_is_connected(0) {
    // Gamepad is plugged in, set controls to gamepad
    // Use analog stick axis for movement
    var axislh_value = gamepad_axis_value(0, gp_axislh);
    var axislv_value = gamepad_axis_value(0, gp_axislv);
    var shoot_button = gamepad_button_check_pressed(0, gp_face1);
    var melee_button = gamepad_button_check_pressed(0, gp_face2);
    var change_weapon_button = gamepad_button_check_pressed(0, gp_shoulderl);
    var pause_button = gamepad_button_check_pressed(0, gp_start);

    move_left = axislh_value < -0.5;
    move_right = axislh_value > 0.5;
    move_up = axislv_value > 0.5;
    move_down = axislv_value < -0.5;

    if (axislh_value != 0 || axislv_value != 0) {
        direction = point_direction(0, 0, axislh_value, -axislv_value);
    }
}
else {
    // Gamepad is not plugged in, set controls to keyboard
    // Use arrow keys for movement
    move_left = keyboard_check(vk_left);
    move_right = keyboard_check(vk_right);
    move_up = keyboard_check(vk_up);
    move_down = keyboard_check(vk_down);
    
    var shoot_button = keyboard_check_pressed(ord("Z"));
    var melee_button = keyboard_check_pressed(ord("X"));
    var change_weapon_button = keyboard_check_pressed(ord("C"));
    var pause_button = keyboard_check_pressed(vk_escape);
}

if (jetpack_mode==1)
{
// Horizontal movement

	if (move_left) 
	{
		facing_right = false;
		if !place_meeting(bbox_left,y-30,floor_obj) 
		{
			hsp_walk -= 1.4;
			walk=true;
			idle=false;
			wall_direction = -1;
		}
	} 
	else if (move_right) 
	{
		facing_right = true;
		if !place_meeting(bbox_right,y-20,floor_obj) 
		{
			hsp_walk += 1.4;
			walk=true;
			idle=false;
			wall_direction = 1;
		}
	} 
	else 
	{
		hsp_walk = 0; // Stop horizontal movement when no key is pressed
		walk=false;
		idle=true;
		wall_direction=0;
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
    if (move_left) 
	{   if place_empty(x-bbox_left+hsp,y-20,floor_obj) {
        hsp -= 0.4;
		} else 
		if place_meeting(bbox_left-10+hsp,y-20,floor_obj) && wall_hold=false {
        wall_hold=true;
		//hsp=0;
		} else {
		hsp = 0;
		}
		if mouse_aim=false {
        facing_right = false;
		}
    }
    if (move_right) 
	{
        if place_empty(x+bbox_right,y,floor_obj)  {
        hsp += 0.4;
		} else 
		if place_meeting(bbox_right+10+hsp,y-20,floor_obj) && wall_hold=false {
        wall_hold=true;
		//hsp=0;
		}  else {
		hsp = 0;
		}
		if mouse_aim=false {
        facing_right = true;
		}
		if place_meeting(bbox_left-10+hsp,y-20,floor_obj) || place_meeting(bbox_right+10+hsp,y-20,floor_obj) {
		hsp = 0; // Stop horizontal movement when no key is pressed
		walk=false;
		idle=true;
		wall_direction=0;
	}
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
		if (!isJumping && !place_empty(x,y,floor_obj)) 
		{
        isJumping = true;
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

    if (move_down) && place_empty(x,bbox_bottom,floor_obj) {
        if jetpack_mode=3 {
			vsp += 0.4;
		}
	}


if (isJumping) {
    y -= jumpSpeed;
	y-=10;
    jumpSpeed -= grav;
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


if hsp > 20
    hsp = 20;
if hsp < -20
    hsp = -20;
if vsp > 20
    vsp = 20;
if vsp < -20
    vsp = -20;
	




angle_head = image_angle;
angle_body = image_angle;
angle_jet = image_angle;
angle_armF = image_angle;
angle_armB = image_angle;
angle_legB = image_angle;
angle_legF = image_angle;

if jetpack_mode=1
{
	image_angle = 0;
	//gravity=.5;
	//grav=.5;
// Calculate the bounding box for each sprite relative to sprBody
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprBody), nx_head - sprite_get_bbox_left(sprHeadSanta), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprBody) - sprite_get_bbox_left(sprBody), nx_head + sprite_get_bbox_right(sprHeadSanta) - sprite_get_bbox_left(sprHeadSanta), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprBody), ny_head - sprite_get_bbox_top(sprHeadSanta), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprBody) - sprite_get_bbox_top(sprBody), ny_head + sprite_get_bbox_bottom(sprHeadSanta) - sprite_get_bbox_top(sprHeadSanta), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprBody
var bbox_body_left = x - sprite_get_bbox_right(sprBody) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprBody) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprBody) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprBody) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprHeadSanta) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprHeadSanta) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprHeadSanta) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprHeadSanta) * image_yscale;

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
// Calculate the bounding box for each sprite relative to sprBody 
var bbox_body = [x - sprite_get_bbox_right(sprBody) * image_xscale, y - sprite_get_bbox_top(sprBody) * image_yscale, x + sprite_get_bbox_right(sprBody) * image_xscale, y + sprite_get_bbox_bottom(sprBody) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprHeadSanta) * image_xscale, ny_head - sprite_get_bbox_top(sprHeadSanta) * image_yscale, nx_head + sprite_get_bbox_right(sprHeadSanta) * image_xscale, ny_head + sprite_get_bbox_bottom(sprHeadSanta) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprBody image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprBody image_angle
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

if jetpack_mode=2
{
	//grav=0.5;
image_angle = 0 - 2 * hsp;

// Calculate the bounding box for each sprite relative to sprBody
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprBody), nx_head - sprite_get_bbox_left(sprHeadSanta), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprBody) - sprite_get_bbox_left(sprBody), nx_head + sprite_get_bbox_right(sprHeadSanta) - sprite_get_bbox_left(sprHeadSanta), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprBody), ny_head - sprite_get_bbox_top(sprHeadSanta), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprBody) - sprite_get_bbox_top(sprBody), ny_head + sprite_get_bbox_bottom(sprHeadSanta) - sprite_get_bbox_top(sprHeadSanta), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprBody
var bbox_body_left = x - sprite_get_bbox_right(sprBody) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprBody) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprBody) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprBody) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprHeadSanta) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprHeadSanta) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprHeadSanta) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprHeadSanta) * image_yscale;

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
// Calculate the bounding box for each sprite relative to sprBody 
var bbox_body = [x - sprite_get_bbox_right(sprBody) * image_xscale, y - sprite_get_bbox_top(sprBody) * image_yscale, x + sprite_get_bbox_right(sprBody) * image_xscale, y + sprite_get_bbox_bottom(sprBody) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprHeadSanta) * image_xscale, ny_head - sprite_get_bbox_top(sprHeadSanta) * image_yscale, nx_head + sprite_get_bbox_right(sprHeadSanta) * image_xscale, ny_head + sprite_get_bbox_bottom(sprHeadSanta) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprBody image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprBody image_angle
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

if jetpack_mode=3
{
	grav=0;
image_angle = 0 - 2 * hsp;

// Calculate the bounding box for each sprite relative to sprBody
var modified_bbox_left = min(nx_body - sprite_get_bbox_left(sprBody), nx_head - sprite_get_bbox_left(sprHeadSanta), nx_armB - sprite_get_bbox_left(sprArmArms), nx_armF - sprite_get_bbox_left(sprArmArms), nx_legB - sprite_get_bbox_left(sprLeg3), nx_legF - sprite_get_bbox_left(sprLeg3), nx_jet - sprite_get_bbox_left(sprJetBack));
var modified_bbox_right = max(nx_body + sprite_get_bbox_right(sprBody) - sprite_get_bbox_left(sprBody), nx_head + sprite_get_bbox_right(sprHeadSanta) - sprite_get_bbox_left(sprHeadSanta), nx_armB + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_armF + sprite_get_bbox_right(sprArmArms) - sprite_get_bbox_left(sprArmArms), nx_legB + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_legF + sprite_get_bbox_right(sprLeg3) - sprite_get_bbox_left(sprLeg3), nx_jet + sprite_get_bbox_right(sprJetBack) - sprite_get_bbox_left(sprJetBack));
var modified_bbox_top = min(ny_body - sprite_get_bbox_top(sprBody), ny_head - sprite_get_bbox_top(sprHeadSanta), ny_armB - sprite_get_bbox_top(sprArmArms), ny_armF - sprite_get_bbox_top(sprArmArms), ny_legB - sprite_get_bbox_top(sprLeg3), ny_legF - sprite_get_bbox_top(sprLeg3), ny_jet - sprite_get_bbox_top(sprJetBack));
var modified_bbox_bottom = max(ny_body + sprite_get_bbox_bottom(sprBody) - sprite_get_bbox_top(sprBody), ny_head + sprite_get_bbox_bottom(sprHeadSanta) - sprite_get_bbox_top(sprHeadSanta), ny_armB + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_armF + sprite_get_bbox_bottom(sprArmArms) - sprite_get_bbox_top(sprArmArms), ny_legB + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_legF + sprite_get_bbox_bottom(sprLeg3) - sprite_get_bbox_top(sprLeg3), ny_jet + sprite_get_bbox_bottom(sprJetBack) - sprite_get_bbox_top(sprJetBack));

// Calculate the bounding box for each sprite relative to sprBody
var bbox_body_left = x - sprite_get_bbox_right(sprBody) * image_xscale;
var bbox_body_right = x + sprite_get_bbox_right(sprBody) * image_xscale;
var bbox_body_top = y - sprite_get_bbox_top(sprBody) * image_yscale;
var bbox_body_bottom = y + sprite_get_bbox_bottom(sprBody) * image_yscale;

var bbox_head_left = nx_head - sprite_get_bbox_right(sprHeadSanta) * image_xscale;
var bbox_head_right = nx_head + sprite_get_bbox_right(sprHeadSanta) * image_xscale;
var bbox_head_top = ny_head - sprite_get_bbox_top(sprHeadSanta) * image_yscale;
var bbox_head_bottom = ny_head + sprite_get_bbox_bottom(sprHeadSanta) * image_yscale;

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
// Calculate the bounding box for each sprite relative to sprBody 
var bbox_body = [x - sprite_get_bbox_right(sprBody) * image_xscale, y - sprite_get_bbox_top(sprBody) * image_yscale, x + sprite_get_bbox_right(sprBody) * image_xscale, y + sprite_get_bbox_bottom(sprBody) * image_yscale];
var bbox_head = [nx_head - sprite_get_bbox_right(sprHeadSanta) * image_xscale, ny_head - sprite_get_bbox_top(sprHeadSanta) * image_yscale, nx_head + sprite_get_bbox_right(sprHeadSanta) * image_xscale, ny_head + sprite_get_bbox_bottom(sprHeadSanta) * image_yscale];
var bbox_armB = [nx_armB - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armB + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armB + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_armF = [nx_armF - sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF - sprite_get_bbox_top(sprArmArms) * image_yscale, nx_armF + sprite_get_bbox_right(sprArmArms) * image_xscale, ny_armF + sprite_get_bbox_bottom(sprArmArms) * image_yscale];
var bbox_legB = [nx_legB - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legB + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legB + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_legF = [nx_legF - sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF - sprite_get_bbox_top(sprLeg3) * image_yscale, nx_legF + sprite_get_bbox_right(sprLeg3) * image_xscale, ny_legF + sprite_get_bbox_bottom(sprLeg3) * image_yscale];
var bbox_jet = [nx_jet - sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet - sprite_get_bbox_top(sprJetBack) * image_yscale, nx_jet + sprite_get_bbox_right(sprJetBack) * image_xscale, ny_jet + sprite_get_bbox_bottom(sprJetBack) * image_yscale];

// Calculate the rotated bounding box coordinates based on sprBody image_angle
var cos_angle = lengthdir_x(image_angle, 1);
var sin_angle = lengthdir_y(image_angle, 1);

var rotated_bbox_body = [x + bbox_body[0] * cos_angle - bbox_body[1] * sin_angle, y + bbox_body[0] * sin_angle + bbox_body[1] * cos_angle, x + bbox_body[2] * cos_angle - bbox_body[3] * sin_angle, y + bbox_body[2] * sin_angle + bbox_body[3] * cos_angle];
var rotated_bbox_head = [nx_head + bbox_head[0] * cos_angle - bbox_head[1] * sin_angle, ny_head + bbox_head[0] * sin_angle + bbox_head[1] * cos_angle, nx_head + bbox_head[2] * cos_angle - bbox_head[3] * sin_angle, ny_head + bbox_head[2] * sin_angle + bbox_head[3] * cos_angle];
var rotated_bbox_armB = [nx_armB + bbox_armB[0] * cos_angle - bbox_armB[1] * sin_angle, ny_armB + bbox_armB[0] * sin_angle + bbox_armB[1] * cos_angle, nx_armB + bbox_armB[2] * cos_angle - bbox_armB[3] * sin_angle, ny_armB + bbox_armB[2] * sin_angle + bbox_armB[3] * cos_angle];
var rotated_bbox_armF = [nx_armF + bbox_armF[0] * cos_angle - bbox_armF[1] * sin_angle, ny_armF + bbox_armF[0] * sin_angle + bbox_armF[1] * cos_angle, nx_armF + bbox_armF[2] * cos_angle - bbox_armF[3] * sin_angle, ny_armF + bbox_armF[2] * sin_angle + bbox_armF[3] * cos_angle];
var rotated_bbox_legB = [nx_legB + bbox_legB[0] * cos_angle - bbox_legB[1] * sin_angle, ny_legB + bbox_legB[0] * sin_angle + bbox_legB[1] * cos_angle, nx_legB+ bbox_legB[2] * cos_angle - bbox_legB[3] * sin_angle, ny_legB + bbox_legB[2] * sin_angle + bbox_legB[3] * cos_angle];

// Calculate the rotated bounding box coordinates based on sprBody image_angle
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








// Horizontal movement

// Check for horizontal collisions
	if place_meeting(bbox_left-10+hsp,y-20,floor_obj) || place_meeting(bbox_right+10+hsp,y-20,floor_obj) {
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

// Check for vertical collisions
if (place_meeting(x, y + modified_bbox_bottom, obj_block_64)) {
    while (!place_meeting(x, y + sign(vsp), obj_block_64)) {
        y += sign(vsp);
    }
    vsp = 0; // Stop vertical movement
	isJumping = false;
}




if !place_empty(x,y,floor_obj) {
	grav=0;
	vsp=0;
	isJumping=false;
	jumpSpeed=0;
	
}



// Jetpack modes 1 and 2 gravity
if (jetpack_mode == 1 || jetpack_mode == 2) {
	if  place_empty(x,y,floor_obj) {
    grav = 0.5; // Adjust this value as needed
	} else {
    grav = 0;
	vsp=0;
	isJumping=false; // Reset gravity when on the sidewalk
   // y -= 10; // Adjust the vertical position to stay on the floor
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


//BULLETS
if (facing_right && keyboard_check(ord("A")) && wpn_cooldown==0) {
	
if weapon=0 { //FIST
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=0;
		depth=parent.depth-10;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		//alarm[0]=10;///destroy
		sprite_index=sprFist;
		life_countdown=parent.bullet_life;
		life_limit=true;

		
	}
	}
	if weapon=1 { //GUN
		//draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=1;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		//wpn_cooldown=2;
		
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	if weapon=2 { //GUN2
		//draw_sprite_ext(sprGun2, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=4;
	with (bullet) {
		parent=obj_Player1;
		weapon=2;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	}
	
	if weapon=3 { //GUN3
		//draw_sprite_ext(sprGun3, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=6;
	with (bullet) {
		parent=obj_Player1;
		weapon=3;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	
	
	if weapon=4 { //SWORD
		//draw_sprite_ext(sprHandSword, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		target=obj_Player1;
		weapon=4;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=1.5*parent.scale;
		image_yscale=1.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
		hitbox=true;
	}
	
	}
	if weapon=5 { //SHOTGUN
		
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
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet2) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet3) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet4) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet5) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	
	
	}
	if weapon=6 { //Raygun
		
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
	
	if weapon=7 { //Grenade
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprGrenadeLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=7;
		depth=parent.depth+1;
		sprite_index=sprGrenade;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
		bounce = true;
		grav = 0;           // Initial vertical speed
		grav_accel = 0.5;   // Acceleration due to gravity
		grav_max = 10;      // Maximum falling speed
		bounce_factor = -0.8; // How much energy is retained after bouncing (-1 = perfect bounce, less than -1 = energy loss)
		h_speed = 4;         // Horizontal speed
		h_friction = 0.98;   // Friction applied to horizontal movement	
		floor_obj = obj_block_64;
	}
	
	}
	if weapon=8 { //Rocket
		//draw_sprite_ext(sprRocketLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///

	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=8;
		homing=true;
			target = instance_nearest(x, y, objEnemy);
		depth=parent.depth+1;
			sprite_index=sprRocket;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	if weapon=9 { //SNIPER
		//draw_sprite_ext(sprSniper, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=9;
		depth=parent.depth+1;
		sprite_index=sprGrenade;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	if weapon=10 { //FLAMETHROWER
		//draw_sprite_ext(sprFlamethrower, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=10;
		depth=parent.depth+1;
		sprite_index=sprGrenade;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		hitbox=true;
	}
	
	}
	if weapon=11 { //TASER
		//draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	taser_img++;
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=11;
		depth=parent.depth+1;
		sprite_index=sprGrenade;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		hitbox=true;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	
	}
	if weapon=12 { //CHAINSAW
		//draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		chainsaw_blade++;
		if !instance_exists(objHitbox)
		{
		hitbox = instance_create(nx_fistF,ny_fistF,objBullet);
	wpn_cooldown=2;
	with (hitbox) {
		parent=obj_Player1;
		weapon=12;
		hitbox=true;
		xx=parent.nx_fistF;
		yy=parent.nx_fistF;
		depth=parent.depth+1;
		sprite_index=sprChainsaw;
		direction=parent.armF_dir;
		//speed=0;
		image_xscale=parent.image_xscale;
		image_yscale=parent.image_yscale;
				}
		
		}
		
	}

}









	