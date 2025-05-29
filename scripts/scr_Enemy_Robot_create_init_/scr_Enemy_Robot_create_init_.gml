function scr_Enemy_Robot_create_init_(){

image_angle=0;
facing_right = true;
depth=-10;
color1=make_colour_hsv(random(255),255,255);
color2=c_white;
color3=c_white;

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
armF_dir=0;

target = noone;
}