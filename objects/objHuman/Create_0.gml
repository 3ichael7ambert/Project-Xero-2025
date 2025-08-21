/// @description Insert description here
// You can write your code in this editor
 randomize();
 
 
 hp=100;
 weapon="none";
 
 // Create Event
grav = 0.5; // Gravity strength
vsp = 0; // Vertical speed
is_on_ground = false; // Is the NPC standing on the ground?

target=obj_Player1;
mission_indicator_color=c_aqua;

if room==rmCity {
	scale=.2;
} else {
	scale=1;
}

mood="calm";
eyes_mood="calm";
mouth_mood="calm";
angle=0;

poi="none";

hsp=0;

player_target=noone;
player_nearest=noone;
robot_nearest=noone;
human_nearest=noone;


//mission
has_mission=choose(true,false);
spin_angle = 0;

interaction_range = 48;
mission_active = false;
// old mission
/*
mission_num=0;

mission_id = "collect_10_parts";
mission_text = "Collect 10 parts scattered around the map.";
mission_active = false;
mission_completed = false;

interaction_range = 48;
show_msg = false;
*/
// Support multiple control types


//end mission

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
 hat_color=(make_color_rgb(random(255),random(255),random(255)));
 

 sunglasses=choose(true,false);
 race=choose("human","alien");
 
  if (race=="human") {
	// Hue around orange (15–35), low saturation for lighter skin, higher for darker
	var h = irandom_range(15, 35);          // hue ~orange/brown range
	var s = irandom_range(20, 80);          // saturation (pale to deep tones)
	var v = irandom_range(70, 255);         // brightness (light to dark)

		skin_color = make_color_hsv(h, s, v);

 } else if (race=="alien") {
		 skin_color=make_color_hsv(irandom(255),255,255);
 }
	 else {
	 
		 skin_color= c_white;
	 }
	 


 
	//skin_color=c_white;
	
	has_weapon=false;
	weapon = choose("gun","raygun","shotgun");
	attacking=false;
	wpn_dir=270;
	arm_img_angle=270;
	
	switch (weapon) {
		case "gun":
			sprite_gun=sprGrenadeLauncher;
			gun_idx=0;
			break;
		case "raygun":
			sprite_gun=sprRayGun;
			gun_idx=2;
			break;
		case "shotgun":
			sprite_gun=sprShotgun;
			gun_idx=0;
			break;
		case default:
			sprite_gun=sprGrenadeLauncher;
			gun_idx=0;
			break;
	}
	
	shirtless = random(100);
	pantsless = random(100);
	hat_chance = random(100);
	
gender=choose("male","female");

if (shirtless>15) {
	shirt_style=choose("long","short");
} else {	
	shirt_style=choose("long","short","none");
}


	

shoes_style=choose("none","sneakers");

if (gender=="male") {
	if (shirt_style="none" && pantsless<15) {
		pants_style=choose("long","shorts","none");
	} else {
		pants_style=choose("long","shorts");
	}
	hair_style=choose("long","short","bald","braids","long2","short2");
}
if (gender=="female") {
	if (shirt_style="none" && pantsless<15) {
		pants_style=choose("long","shorts","skirt","none");
	} else {
		pants_style=choose("long","shorts","skirt","none");
		}	
	hair_style=choose("long","short","braids","long2","short2");
}

if ((hair_style=="short") || (hair_style=="long")) && (hat_chance<15) {
	hat_style=choose("none","backwards","beanie","forwards","bandana");
} else {
	hat_style="none";
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
		