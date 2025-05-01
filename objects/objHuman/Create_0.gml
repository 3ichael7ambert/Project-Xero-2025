/// @description Insert description here
// You can write your code in this editor
 randomize();
 
 
 hp=100;
 weapon="none";
 
 // Create Event
grav = 0.5; // Gravity strength
vsp = 0; // Vertical speed
is_on_ground = false; // Is the NPC standing on the ground?

scale=1;

 dir=choose("left","right");
 
 hair_color=(make_color_rgb(random(255),random(255),random(255)));
 shirt_color=(make_color_rgb(random(255),random(255),random(255)));
 pants_color=(make_color_rgb(random(255),random(255),random(255)));
 shoes_color=(make_color_rgb(random(255),random(255),random(255)));
 eye_color=(make_color_rgb(random(255),random(255),random(255)));

 img_idx_body=image_index;
 img_idx_pants=image_index;
 img_idx_shirt=image_index;
 img_idx_shoes=image_index;
 img_idx_head=0;
 img_idx_nose=0;
 img_idx_eyes=0;
 img_idx_eyelids=0;
 img_idx_eyebrows=0;
 img_idx_nose=0;
 img_idx_hair=0;
 img_idx_mouth=0;
 
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
		