/// @description Insert description here
// You can write your code in this editor
 randomize();
 
 
 hp=100;
 weapon="none";
 
 // Create Event
grav = 0.5; // Gravity strength
vsp = 0; // Vertical speed
is_on_ground = false; // Is the NPC standing on the ground?

scale=.8;
image_xscale=scale;
image_yscale=scale;

 dir=choose("left","right");
 
 hair_color=(make_color_rgb(random(255),random(255),random(255)));
 hair_color_2=(make_color_rgb(random(255),random(255),random(255)));
 shirt_color=(make_color_rgb(random(255),random(255),random(255)));
 shirt_color_2=(make_color_rgb(random(255),random(255),random(255)));
 pants_color=(make_color_rgb(random(255),random(255),random(255)));
 shoes_color=(make_color_rgb(random(255),random(255),random(255)));
 eye_color=(make_color_rgb(random(255),random(255),random(255)));
	skin_color=c_white;
gender=choose("male","female");
shirt_style=choose("long","short","none");
hat_style=choose("none","backwards","beanie","forwards","bandana");
shoes_style=choose("none","sneakers");

if (gender=="male") {
	pants_style=choose("long","short","none");
	hair_style=choose("long","shorts","bald","braids","long2","short");
}
if (gender=="female") {
	pants_style=choose("long","short","skirt","none");
	hair_style=choose("long","shorts","braids","long2","short");
}

 img_idx_body=image_index;
 img_idx_pants=image_index;
 
 switch (gender) {
	 case "male":
		img_idx_shirt=0;
	 case "female":
		img_idx_shirt=1;
	 default:
		img_idx_shirt=0;
 }
 
img_idx_shirt_sleeves=image_index;
 img_idx_shoes=image_index;
 img_idx_head=0;
 img_idx_nose=0;
 img_idx_eyes=0;
 img_idx_eyelids=0;
 img_idx_eyebrows=0;
 img_idx_nose=0;
 img_idx_hair=0;
 img_idx_mouth=0;
 
  arm_dir=270;
  armB_dir=270;
 
 head_x=x+lengthdir_x(100,85)*scale;
 head_y=y+lengthdir_y(100,85)*scale;
 eyes_x=head_x+lengthdir_x(100,75)*scale;
 eyes_y=head_y+lengthdir_y(100,75)*scale;
 eyelids_x=eyes_x+lengthdir_x(50,75)*scale;
 eyelids_y=eyes_y+lengthdir_y(50,75)*scale;
 mouth_x=head_x+lengthdir_x(50,75)*scale;
 mouth_y=head_y+lengthdir_y(50,75)*scale;
 nose_x=head_x+lengthdir_x(50,75)*scale;
 nose_y=head_y+lengthdir_y(50,75)*scale;
 eyebrows_x=eyes_x+lengthdir_x(50,75)*scale;
 eyebrows_y=eyes_y+lengthdir_y(50,75)*scale;
 shirt_x=x+lengthdir_x(50,85)*scale;
 shirt_y=y+lengthdir_y(50,85)*scale;
 pants_x=x+lengthdir_x(40,85)*scale;
 pants_y=y+lengthdir_y(40,85)*scale;
 shoes_x=x+lengthdir_x(50,75)*scale;
 shoes_y=y+lengthdir_y(50,75)*scale;
 hair_x=head_x+lengthdir_x(50,75)*scale;
 hair_y=head_y+lengthdir_y(50,75)*scale;
 
 
 
arm_back_x = x + lengthdir_x(20 * scale, 75);
arm_back_y = y + lengthdir_y(20 * scale, 75);
arm_front_x = x + lengthdir_x(20 * scale, 105);
arm_front_y = y + lengthdir_y(20 * scale, 105);
fist_back_x = arm_back_x + lengthdir_x(70,arm_dir);
fist_back_y = arm_back_y + lengthdir_y(70,arm_dir);
fist_front_x = arm_front_x + lengthdir_x(70,arm_dir);
fist_front_y = arm_front_y + lengthdir_y(70,arm_dir);


leg_back_x = x + lengthdir_x(50 * scale, 280);
leg_back_y = y + lengthdir_y(50 * scale, 280);
leg_front_x = x + lengthdir_x(50 * scale, 220);
leg_front_y = y + lengthdir_y(50 * scale, 220);
foot_back_x = leg_back_x + lengthdir_x(65,270);
foot_back_y = leg_back_y + lengthdir_y(65,270);
foot_front_x = leg_front_x + lengthdir_x(65,270);
foot_front_y = leg_front_y + lengthdir_y(65,270);
 
 // Create Event
state = "idle"; // Start in the idle state
speed = 0; // Start stationary

alarm[0]=10;
spr_dir=1;

 if direction == "left" {
    spr_dir=-1;
	image_xscale = -1*scale; // Flip the sprite horizontally
} else {
	spr_dir=1;
	image_xscale = 1*scale;  // Default orientation
}


panic_cooldown = 100; 

if instance_exists(obj_Player1) {
	target=obj_Player1;
	scale=obj_Player1.scale;}
		else  {
			target=undefined;
		}
		