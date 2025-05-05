image_angle=0;
facing_right = true;
depth=-10;


hp=100;
attack_power=1;

target_player=obj_Player1;
weapon_locked = true;

shooting = false;
//errors beach
cdir_fistF=0;
armB_dir=0;

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
wpn_charge_max=10;
bullet_life=2000;
//global.snipe=false;
weapon=irandom_range(0,12);
punch=false;
punch_side="front";
punch_img_idx=0;
sword=false;
sword_num=1;
sword_img_idx=0;
chainsaw_blade=0;
taser_img=0;
wpn_cooldown=0;

attack_cooldown=0;
aggression=0;

my_weapon = weapon;//irandom_range(1, 12); // or passed from controller
class_data = scr_weapon_class_data(my_weapon);

// example: set up combat preferences
preferred_range_min = class_data.preferred_range_min;
preferred_range_max = class_data.preferred_range_max;
aggression_level = class_data.aggression;
attack_cooldown_max = class_data.cooldown;
movement_type = class_data.move_style;



//sprites
sprite_body=sprBody;
sprite_body_offsetX=45;
sprite_body_offsetY=79;
if (current_month==12) {
	sprite_head=sprHeadSanta;
} else {
	sprite_head=sprHead;
}
sprite_armF=sprArmArms;
sprite_legF=sprLeg3;
spr_sword_arm = sprArmSword_1_Arm;
spr_sword_sword = sprArmSword_1_Sword;
spr_sword_fx = sprArmSword_1_Fx; 
/*
offsetX=23;
offsetY=56;
*/

ai_state = "patrol"; // Can be: "patrol", "follow", "attack"
patrol_direction = choose(-1, 1); // Start facing left or right
patrol_timer = irandom_range(60, 180); // Frames before switching direction
player_detect_range = 600; // Distance to start following the player
attack_range = 150; // Distance to start attacking
target = noone;

armF_dir=0;

//BUTTONS


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
if room=rm_Infinite_beach{floor_obj=obj_block3D_infinite;}
if room=rm360{floor_obj=noone;}
if room=rm360 {player_init();} //360
if room=r_level_infinite {floor_obj=noone;}
if room=r_levelSide_infinite {floor_obj=noone;}

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

jetpack_mode = choose(1, 2, 3);

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

// Get the interpolated color
var charge_color1 = get_interpolated_color(wpn_charge-2, wpn_charge_max);
var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
var charge_color3 = get_interpolated_color(wpn_charge+2, wpn_charge_max);
//part_type_colour1(_ptypeBlast, charge_color); // Single color for simplicity
part_type_colour3(_ptypeCharge, charge_color1, charge_color2, charge_color3);

//part_type_colour3(_ptypeCharge, $FFFFFF, $FFE500, $FF7B00);
part_type_alpha3(_ptypeCharge, 0, 1, 0);
part_type_blend(_ptypeCharge, false);
part_type_life(_ptypeCharge, 10*scale, 20*scale);
////






//FLAMETHROWER
//part_flamethrower
global._psFlamethrower = part_system_create();
//part_system_draw_order(global._psFlamethrower, true);

//GM_FlameIntensity
_ptypeFlamethrower = part_type_create();
part_type_shape(_ptypeFlamethrower, pt_shape_explosion);
part_type_size(_ptypeFlamethrower, 1*scale, 1.2*scale, 0.1, 0);
part_type_scale(_ptypeFlamethrower, 0.5, 0.5);
part_system_depth(global._psFlamethrower,depth-10);
part_type_speed(_ptypeFlamethrower, 7, 9, -0.2, 0);
part_type_direction(_ptypeFlamethrower, 356, 28, 0, 0);
part_type_gravity(_ptypeFlamethrower, -0.4, 270);
part_type_orientation(_ptypeFlamethrower, 73, 321, 0, 0, false);
part_type_colour3(_ptypeFlamethrower, $C1FDFF, $26AFFF, $0090FF);
part_type_alpha3(_ptypeFlamethrower, 1, 0.271, 0);
part_type_blend(_ptypeFlamethrower, true);
part_type_life(_ptypeFlamethrower, 58*scale, 66*scale);
//_pemitFlamethrower = part_emitter_create(global._psFlamethrower);
//part_emitter_region(_psFlamethrower, _pemitFlamethrower, 0.5, 1.5, -0.5, 0.5, ps_shape_line, ps_distr_gaussian);
//part_emitter_stream(_psFlamethrower, _pemitFlamethrower, _ptypeFlamethrower, 7);
//part_system_position(global._psFlamethrower, room_width/2, room_height/2);



//part_electric
global._psElec = part_system_create();
part_system_draw_order(global._psElec, true);

//GM_Electricity
_ptypeElec = part_type_create();
part_type_sprite(_ptypeElec, GM_Electricity_spr_Electricity1, false, true, false)
part_type_size(_ptypeElec, 0.5*scale, 1*scale, 0, 0);
part_type_scale(_ptypeElec, 1, 1);
part_type_speed(_ptypeElec, 0, 0, 0, 0);
part_type_direction(_ptypeElec, 0, 360, 0.1, 0);
part_type_gravity(_ptypeElec, 0, 270);
part_type_orientation(_ptypeElec, 0, 360, 0, 0, false);
part_type_colour3(_ptypeElec, $FFC119, $FF6100, $FF0800);
part_type_alpha3(_ptypeElec, 1, 0.439, 0);
part_type_blend(_ptypeElec, true);
part_type_life(_ptypeElec, 15*scale, 18*scale);




///DEBUG
part_smoke_count = part_particles_count(global.partSysCharge);