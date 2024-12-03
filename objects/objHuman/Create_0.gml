/// @description Insert description here
// You can write your code in this editor
 randomize();
 
 // Create Event
grav = 0.5; // Gravity strength
vsp = 0; // Vertical speed
is_on_ground = false; // Is the NPC standing on the ground?


 dir=choose("left","right");
 
 
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
		