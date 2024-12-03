/// @description Insert description here
// You can write your code in this editor
 randomize();
 
 // Create Event
grav = 0.5; // Gravity strength
vsp = 0; // Vertical speed
is_on_ground = false; // Is the NPC standing on the ground?


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
 img_idx_hair=0;
 
 // Create Event
state = "idle"; // Start in the idle state
speed = 0; // Start stationary

alarm[0]=10;
spr_dir=1;

 if direction == "left" {
    spr_dir=-1;
	image_xscale = -1; // Flip the sprite horizontally
} else {
	spr_dir=1;
	image_xscale = 1;  // Default orientation
}


panic_cooldown = 100; 

if instance_exists(obj_Player1) {
	target=obj_Player1;
	scale=obj_Player1.scale;}
		else  {
			target=undefined;
		}
		