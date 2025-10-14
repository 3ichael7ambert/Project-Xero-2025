function scr_player_1_init(){
	
#macro STATE_NORMAL 0
#macro STATE_GRIND  1



image_angle=0;
facing_right = true;
depth=-10;


// Set initial variables
hsp = 0; // Horizontal speed
hsp_walk=0;
hsp_walk_max=5.4;
vsp = 0; // Vertical speed
grav = 0; // Gravity value
jumpSpeed = 23; // Jump speed
jumpHeight = 2;
isJumping=false;
scale=.2;
//scale=1;
wpn_btn_dir="up";

can_switch_weapons=true;
can_switch_jetpack=true;

wpn_charge=0;
wpn_charge_max=10;

bullet_life=2000;

global.snipe=false;
weapon=0;

punch=false;
punch_side="front";
punch_img_idx=0;

hp=100;
hp_max=100;

sword=false;
sword_num=1;
sword_img_idx=0;



chainsaw_blade=0;
taser_img=0;

wpn_cooldown=0;


offsetX=23;
offsetY=56;

can_move=true;

}