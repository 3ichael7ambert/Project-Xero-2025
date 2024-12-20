/// @description Insert description here
// You can write your code in this editor


//PUNCH
if (follow_player==true) {
	if (punch_side="front"){
		x=parent.nx_armF;
		y=parent.ny_armF;
	} else {
		x=parent.nx_armB;
		y=parent.ny_armB;
	}
}
if (weapon==0) {
		image_angle=parent.armF_dir;
		if (parent.punch_img_idx==10) {
			instance_destroy();
		}
}
/////



if (life_limit==true && life_countdown<=0) 
{
	instance_destroy();
}

if (life_countdown>0)
{
	life_countdown--;
}

if (homing==true) {
	

if  instance_exists(target) {
   delta = point_direction(x, y, target.x, target.y) - direction;
   //find shortest turn to target,turning 4degrees per step
   if abs(delta) > 180 { delta = -delta; }
   if abs(delta) > 4 { direction += 4*sign(delta); }
}
	image_angle=direction;
	 instance_create(x, y, objTrail);
}


if (bounce==true) {
	
	
// Apply gravity
if place_empty(x, y + grav,floor_obj) {
    grav += grav_accel; // Accelerate the ball downward
    if (grav > grav_max) grav = grav_max; // Limit falling speed
    y += grav; // Apply the gravity movement
} else {
    // Bounce logic: reverse the velocity and apply bounce factor
    grav *= bounce_factor; // Reverse direction and reduce speed due to energy loss

    // Adjust position to ensure it doesn't "sink" into the surface
    while (!place_free(x, y + sign(grav))) {
        y -= sign(grav);
    }
}

// Optional: Stop bouncing if gravity becomes very small
if abs(grav) < 0.2 {
    grav = 0;
}


	// Horizontal movement
if place_free(x + h_speed, y) {
    x += h_speed; // Move left or right
} else {
    h_speed = -h_speed * bounce_factor; // Reverse direction on collision
}

// Apply friction
h_speed *= h_friction;
if abs(h_speed) < 0.1 {
    h_speed = 0; // Stop rolling if speed is too low
}

}