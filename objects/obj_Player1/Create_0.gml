image_angle=0;
facing_right = true;

// Set initial variables
hsp = 0; // Horizontal speed
hsp_walk=0;
hsp_walk_max=5.4;
vsp = 0; // Vertical speed
grav = 0; // Gravity value
jumpSpeed = 23; // Jump speed
jumpHeight = 10;
isJumping=false;
scale=.2;
//scale=1;
wpn_btn_dir="up";
wpn_charge=0;
bullet_life=2000;


weapon=0;

punch=false;
punch_side="front";
punch_img_idx=0;

sword=false;
sword_num=1;
sword_img_idx=0;

spr_sword_arm = sprArmSword_1_Arm;
spr_sword_sword = sprArmSword_1_Sword;
spr_sword_fx = sprArmSword_1_Fx; 

chainsaw_blade=0;
taser_img=0;

wpn_cooldown=0;

//sprites
sprite_body=sprBody;
sprite_body_offsetX=45;
sprite_body_offsetY=79;
sprite_head=sprHeadSanta;
sprite_armF=sprArmArms;
sprite_legF=sprLeg3;

/*
offsetX=23;
offsetY=56;
*/



//BUTTONS
if gamepad_is_connected(0) {
    // Gamepad is plugged in, set controls to gamepad
    // Use analog stick axis for movement
     axislh_value = gamepad_axis_value(0, gp_axislh);
     axislv_value = gamepad_axis_value(0, gp_axislv);
     shoot_button = gamepad_button_check_pressed(0, gp_face1);
     melee_button = gamepad_button_check_pressed(0, gp_face2);
     change_weapon_button = gamepad_button_check_pressed(0, gp_shoulderl);
     pause_button = gamepad_button_check_pressed(0, gp_start);

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
    
     shoot_button = keyboard_check(ord("A"));
	 shoot_button_pressed = keyboard_check_pressed(ord("A"));
	 shoot_button_released = keyboard_check_released(ord("A"));
     melee_button = keyboard_check_pressed(ord("S"));
	 wpn_chg_up = keyboard_check_pressed(ord("C"));
	 wpn_chg_down = keyboard_check_pressed(ord("X"));
     change_weapon_button = keyboard_check_pressed(ord("V"));
     pause_button = keyboard_check_pressed(vk_escape);
}



if (facing_right) {
offsetX=25*scale;
} else {
offsetX=-25*scale;
}
offsetY=75*scale;



//FLOOR and WALL
if room=rmCity {floor_obj=objSidewalk;}
if room=rm_boss{floor_obj=obj_block3D;}
if room=rm_lava{floor_obj=obj_block_lava;}
if room=rm_Infinite{floor_obj=obj_block3D_infinite;}
if room=rm360{floor_obj=noone;}

if room=rm360 {player_init();} //360

wall_direction = 0;
wall_jump_force = 0;
wall_jumping = false;
/// create a motion vector
move_vector = {
	x: 0, y: 0, grav: 0.5, max_spd: 10,
	// get the length
	length: function(){
		return point_distance(0,0,self.x,self.y);
	},
	update_gravity: function(){
		self.y += self.grav;
		if(abs(self.y) > max_spd){
			self.y = sign(self.y) * max_spd;
		}
	}
};



var cx, cy, crad, clen, cdir, cnext, nx, ny;

head_offset = 80; // Offset value for the head sprite
arm_offset = 40; // Offset value for the front arm
body_width = sprite_get_width(sprite_index);

transition_speed=5;

jetpack_mode=3;
wall_hold=false;

//gamepad
// Initialize movement variables
move_left = 0;
move_right = 0;
move_up = 0;
move_down = 0;
//direction = 0;

mouse_aim=true;
zdir = 0;    // Add an angle for up-down movement of the camera
zm = 1200;
gamepad=false;

//WALK
walk=false;
walk_legF=0;
walk_legB=0;
walk_armF=0;
walk_armB=0;
idle=true;


if jetpack_mode=1 
{
angle_head = image_angle;
cx=x;
cy=y;
nx_armB=x;
ny_armB=y;
nx_legB=x;
ny_legB=y;
nx_head=x;
ny_head=y;
nx_body=x;
ny_body=y;

crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 40; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistF = 40; // Adjust the radius value as per your requirements
crad_fistB = 35; // Adjust the radius value as per your requirements
crad_legF = 60; // Adjust the radius value as per your requirements
crad_legB = 60; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle+180;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+130;
cdir_armB = image_angle+65;
cdir_fistF = image_angle+130;
cdir_fistB = image_angle+65;
cdir_legF = image_angle-120;
cdir_legB = image_angle-90;

crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 37; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistF = 37; // Adjust the radius value as per your requirements
crad_fistB = 35; // Adjust the radius value as per your requirements
crad_legF = 63; // Adjust the radius value as per your requirements
crad_legB = 62; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+45;
cdir_armB = image_angle+110;
cdir_fistF = image_angle+45;
cdir_fistB = image_angle+110;
cdir_legF = image_angle-70;
cdir_legB = image_angle-90;


// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_armB = crad_armB * pi * 2;
clen_fistF = crad_armF * pi * 2;
clen_fistB = crad_armB * pi * 2;
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_fistF = cdir_fistF + (3 * 360) / clen_fistF;
cnext_fistB = cdir_fistB + (3 * 360) / clen_fistB;
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head, cnext_head);
ny_head = cy + lengthdir_y(crad_head, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF, cnext_armF);
nx_armB = cx + lengthdir_x(crad_armB, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB, cnext_armB); 
nx_fistF = cx + lengthdir_x(crad_fistF, cnext_fistF); ///
ny_fistF = cy + lengthdir_y(crad_fistF, cnext_fistF); ///
nx_fistB = cx + lengthdir_x(crad_fistB, cnext_fistB); ///
ny_fistB = cy + lengthdir_y(crad_fistB, cnext_fistB); ///
nx_legF = cx + lengthdir_x(crad_legF, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB, cnext_legB);
}
if jetpack_mode=2 
{
angle_head = image_angle;
cx=x;
cy=y;
nx_armB=x;
ny_armB=y;
nx_legB=x;
ny_legB=y;
nx_head=x;
ny_head=y;
nx_body=x;
ny_body=y;

crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 40; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistF = 40; // Adjust the radius value as per your requirements ///
crad_fistB = 35; // Adjust the radius value as per your requirements ///
crad_legF = 60; // Adjust the radius value as per your requirements
crad_legB = 60; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle+180;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+130;
cdir_armB = image_angle+65;
cdir_fistF = image_angle+130;
cdir_fistB = image_angle+65;
cdir_legF = image_angle-120;
cdir_legB = image_angle-90;

crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 37; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistF = 37; // Adjust the radius value as per your requirements ///
crad_fistB = 35; // Adjust the radius value as per your requirements ///
crad_legF = 63; // Adjust the radius value as per your requirements
crad_legB = 62; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+45;
cdir_armB = image_angle+110;
cdir_fistF = image_angle+45; ///
cdir_fistB = image_angle+110; ///
cdir_legF = image_angle-70;
cdir_legB = image_angle-90;


// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_armB = crad_armB * pi * 2;
clen_fistF = crad_fistF * pi * 2; ///
clen_fistB = crad_fistB * pi * 2; ///
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_fistF = cdir_fistF + (3 * 360) / clen_fistF; ///
cnext_fistB = cdir_fistB + (3 * 360) / clen_fistB; ///
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head, cnext_head);
ny_head = cy + lengthdir_y(crad_head, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF, cnext_armF);
nx_armB = cx + lengthdir_x(crad_armB, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB, cnext_armB);
nx_fistF = cx + lengthdir_x(crad_fistF, cnext_fistF); ///
ny_fistF = cy + lengthdir_y(crad_fistF, cnext_fistF); ///
nx_fistB = cx + lengthdir_x(crad_fistB, cnext_fistB); ///
ny_fistB = cy + lengthdir_y(crad_fistB, cnext_fistB); ///
nx_legF = cx + lengthdir_x(crad_legF, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB, cnext_legB);
}

if jetpack_mode=3 
{
angle_head = image_angle;
cx=x;
cy=y;
nx_armB=x;
ny_armB=y;
nx_legB=x;
ny_legB=y;
nx_head=x;
ny_head=y;
nx_body=x;
ny_body=y;

crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 40; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistF = 40; // Adjust the radius value as per your requirements ///
crad_fistB = 35; // Adjust the radius value as per your requirements ///
crad_legF = 60; // Adjust the radius value as per your requirements
crad_legB = 60; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle+180;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+130;
cdir_armB = image_angle+65;
cdir_fistF = image_angle+130; ///
cdir_fistB = image_angle+65; ///
cdir_legF = image_angle-120;
cdir_legB = image_angle-90;

crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 37; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistF = 37; // Adjust the radius value as per your requirements ///
crad_fistB = 35; // Adjust the radius value as per your requirements ///
crad_legF = 63; // Adjust the radius value as per your requirements
crad_legB = 62; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+45;
cdir_armB = image_angle+110;
cdir_fistF = image_angle+45; ///
cdir_fistB = image_angle+110; ///
cdir_legF = image_angle-70;
cdir_legB = image_angle-90;


// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_armB = crad_armB * pi * 2;
clen_fistF = crad_fistF * pi * 2; ///
clen_fistB = crad_fistB * pi * 2; ///
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_fistF = cdir_fistF + (3 * 360) / clen_fistF; ///
cnext_fistB = cdir_fistB + (3 * 360) / clen_fistB; ///
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head, cnext_head);
ny_head = cy + lengthdir_y(crad_head, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF, cnext_armF);
nx_armB = cx + lengthdir_x(crad_armB, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB, cnext_armB);
nx_fistF = cx + lengthdir_x(crad_fistF, cnext_fistF); ///
ny_fistF = cy + lengthdir_y(crad_fistF, cnext_fistF); ///
nx_fistB = cx + lengthdir_x(crad_fistB, cnext_fistB); ///
ny_fistB = cy + lengthdir_y(crad_fistB, cnext_fistB); ///
nx_legF = cx + lengthdir_x(crad_legF, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB, cnext_legB);
}





//PARTICLES
global.partSysSmoke=part_system_create(part_smoke);
			//GM_Smoke
 _ptypeSmoke = part_type_create();
part_type_shape(_ptypeSmoke, pt_shape_smoke);
part_type_size(_ptypeSmoke, 0.2, 0.2, 0.01, 0);
part_type_scale(_ptypeSmoke, 1, 1);
part_type_speed(_ptypeSmoke, 1, 1, 0, 0);
part_type_direction(_ptypeSmoke, 80, 100, 0, 0);
part_type_gravity(_ptypeSmoke, 0, 270);
part_type_orientation(_ptypeSmoke, 0, 0, 0, 0, false);
part_type_colour3(_ptypeSmoke, $4B4B5E, $000000, $000000);
part_type_alpha3(_ptypeSmoke, 0.188, 0.161, 0);
part_type_blend(_ptypeSmoke, false);
part_type_life(_ptypeSmoke, 80, 180);


global.partSysCharge=part_system_create(part_charge_wpn);
//GM_Warp_Lines
_ptypeCharge = part_type_create();
part_type_shape(_ptypeCharge, pt_shape_line);
part_type_size(_ptypeCharge, 2, 1, 0, 0);
part_type_scale(_ptypeCharge, 0.5, 0.1);
part_type_speed(_ptypeCharge, 3, 5, 0, 0);
part_type_direction(_ptypeCharge, 0, 360, 0, 0);
part_type_gravity(_ptypeCharge, 0, 270);
part_type_orientation(_ptypeCharge, 0, 0, 0, 0, true);
part_type_colour3(_ptypeCharge, $FFFFFF, $FFE500, $FF7B00);
part_type_alpha3(_ptypeCharge, 1, 1, 0);
part_type_blend(_ptypeCharge, false);
part_type_life(_ptypeCharge, 20, 80);



//FLAMETHROWER
//part_flamethrower
global._psFlamethrower = part_system_create();
//part_system_draw_order(global._psFlamethrower, true);

//GM_FlameIntensity
_ptypeFlamethrower = part_type_create();
part_type_shape(_ptypeFlamethrower, pt_shape_explosion);
part_type_size(_ptypeFlamethrower, 0.2, 0.4, 0.1, 0);
part_type_scale(_ptypeFlamethrower, 0.5, 0.5);
part_type_speed(_ptypeFlamethrower, 7, 9, -0.2, 0);
part_type_direction(_ptypeFlamethrower, 356, 28, 0, 0);
part_type_gravity(_ptypeFlamethrower, -0.4, 270);
part_type_orientation(_ptypeFlamethrower, 73, 321, 0, 0, false);
part_type_colour3(_ptypeFlamethrower, $C1FDFF, $26AFFF, $0090FF);
part_type_alpha3(_ptypeFlamethrower, 1, 0.271, 0);
part_type_blend(_ptypeFlamethrower, true);
part_type_life(_ptypeFlamethrower, 8, 16);
//_pemitFlamethrower = part_emitter_create(global._psFlamethrower);
//part_emitter_region(_psFlamethrower, _pemitFlamethrower, 0.5, 1.5, -0.5, 0.5, ps_shape_line, ps_distr_gaussian);
//part_emitter_stream(_psFlamethrower, _pemitFlamethrower, _ptypeFlamethrower, 7);
//part_system_position(global._psFlamethrower, room_width/2, room_height/2);



///DEBUG
part_smoke_count = part_particles_count(global.partSysCharge);