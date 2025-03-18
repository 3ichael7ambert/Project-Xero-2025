//---------------------------[ JUMPING ]--------------------------//

player_jump();

//---------------------------[ MOVEMENT ]-------------------------//

player_movement();

//---------------------------[ SPRITES ]--------------------------//

player_animation();

//---------------------------[ VIEW ]-----------------------------//

//uncomment the following if you want a view that rotates with you
//you'll go craaaazzzyyy
//view_angle += angle_difference(-img_angle,view_angle)/25



if jetpack_mode==1 { _speed_max = 3; }
if jetpack_mode==2 { _speed_max = 4; }
if jetpack_mode==3 { _speed_max = 5; }

if (facing_right) {
offsetX=25*scale;
} else {
offsetX=-25*scale;
}
offsetY=75*scale;

image_xscale=1;
image_yscale=1;
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
	weapon-=1;
}
if (keyboard_check_pressed(ord("C"))) {
	weapon+=1;
}


//mouse_aim
xm=window_mouse_get_x();
ym=window_mouse_get_y();

// Get window dimensions
ww = window_get_width();
wh = window_get_height();

if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach) {
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
	
	armF_dir=point_direction(x, y, mouse_x_3d, mouse_y_3d);
	armB_dir=point_direction(x, y, mouse_x_3d, mouse_y_3d);	
}
if gamepad_is_connected(0) && mouse_aim=false {
	gamepad=true;
	armF_dir=point_direction(0, 0, gamepad_axis_value(0,gp_axisrh), -gamepad_axis_value(0,gp_axisrv));
	armB_dir=point_direction(0, 0, gamepad_axis_value(0,gp_axisrh), -gamepad_axis_value(0,gp_axisrv));
} else {gamepad=false;}


// Check if gamepad is connected
if gamepad_is_connected(0) {
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

/*
if (jetpack_mode==1)
{
// Horizontal movement
	if (move_left) 
	{
		facing_right = false;
		if place_empty(bbox_left,y,floor_obj) 
		{
			hsp = -3.4;
			walk=true;
			idle=false;
			wall_direction = -1;
		}
	} 
	else if (move_right) 
	{
		facing_right = true;
		if place_empty(x,y,floor_obj) 
		{
			hsp = 3.4;
			walk=true;
			idle=false;
			wall_direction = 1;
		}
	} 
	else 
	{
		hsp = 0; // Stop horizontal movement when no key is pressed
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
	{
        hsp -= 0.4;
		if mouse_aim=false {
        facing_right = false;
		}
    }
    if (move_right) 
	{
        hsp += 0.4;
		if mouse_aim=false {
        facing_right = true;
		}
    }
}

// Jumping logic
if (move_up) {
    if (jetpack_mode == 3) 
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
			if (!place_meeting(x, y, floor_obj))
			{
				if (wall_direction != 0) {
					vsp = -jumpSpeed;
					hsp = wall_jump_force * wall_direction * -1;	
					wall_jumping = true;
					alarm[3] = 30;
					exit;
				}
			}
		}

	}
}

    if (move_down) && place_empty(x,y,floor_obj) {
        if jetpack_mode=3 {
			vsp += 0.4;
		}
	}


if (isJumping) {
    y -= jumpSpeed;
	y-=10;
    jumpSpeed -= grav;
}



*/


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
    // Code to handle changing weapons
}

// Pause menu button
if (pause_button) {
    // Code to open the pause menu
}

/*
if hsp > 20
    hsp = 20;
if hsp < -20
    hsp = -20;
if vsp > 20
    vsp = 20;
if vsp < -20
    vsp = -20;
	
*/



angle_head = image_angle;
angle_body = image_angle;
angle_jet = image_angle;
angle_armF = image_angle;
angle_armB = image_angle;
angle_legB = image_angle;
angle_legF = image_angle;

if jetpack_mode=1
{
	image_angle = img_angle;
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
image_angle = img_angle - 2 * hsp;

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
image_angle = img_angle - 2 * hsp;

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
if (place_meeting(x + hsp, y, obj_block_64)) {
    while (!place_meeting(x + sign(hsp), y, obj_block_64)) {
        x += sign(hsp);
    }
    hsp = 0; // Stop horizontal movement
}

x += hsp; // Apply horizontal movement

// Vertical movement
//vsp += grav;
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
//sprite_set_bbox(sprXeroBlank, modified_bbox_left, modified_bbox_top, modified_bbox_right, modified_bbox_bottom);

sprite_set_bbox(sprXeroBlank, -50, 50, -100, 100);







