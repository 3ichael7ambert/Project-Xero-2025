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


if (weapon==3) {
	part_type_size(_ptypeBlast, (wpn_charge/20)*scale, (wpn_charge/20)*scale, 0, 0);
	// Get the interpolated color
	var charge_color1 = get_interpolated_color(wpn_charge-2, wpn_charge_max);
	var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
	var charge_color3 = get_interpolated_color(wpn_charge+2, wpn_charge_max);
	
	
	
	part_type_size(_ptypeBlast, .2+wpn_charge/10*scale, .2+wpn_charge/10*scale, -.1, 0);
	part_type_gravity(_ptypeBlast, wpn_charge/100, parent.armF_dir);
	part_type_colour3(_ptypeBlast, charge_color1, charge_color2, charge_color3);
	part_type_speed(_ptypeBlast, wpn_charge/10, wpn_charge/10, 0, 0);
	part_type_life(_ptypeBlast, wpn_charge, wpn_charge);
	
	
	part_particles_create(global.partSysBlast,x,y,_ptypeBlast,20);
			
}







if (weapon==3) {
	if (charging) {
		wpn_charge+=.3;
		xx=parent.nx_armF+lengthdir_x(100*parent.scale,parent.armF_dir);
		yy=parent.ny_armF+lengthdir_y(100*parent.scale,parent.armF_dir);
		
		x=xx;
		y=yy;
		//CHARGING PARTICLES

			

				
		
	}
	
	if (charging) && !(parent.shoot_button) {
		charging=false;
		direction=parent.armF_dir;
		speed=wpn_charge;
		xx=parent.nx_armF+lengthdir_x(100*parent.scale,parent.armF_dir);
		yy=parent.ny_armF+lengthdir_y(100*parent.scale,parent.armF_dir);
//PARTICLES

if !part_system_exists(global.partSysBlast)
			{
			    global.partSysBlast = part_system_create(part_blast_wpn);
			}
		if part_system_exists(global.partSysBlast) {
		xx=parent.nx_armF+lengthdir_x(100*parent.scale,parent.armF_dir);
		yy=parent.ny_armF+lengthdir_y(100*parent.scale,parent.armF_dir);
		//	part_system_position(partSysBlast,xx,yy);
			//part_system_depth(partSysBlast,depth-10);
		}
		
	
	
			

	
	
	}
	
	scale=(wpn_charge/20);
	image_xscale=scale;
	image_yscale=scale;
	

}







if (weapon==4) {
		image_angle=parent.armF_dir;
		if (parent.punch_img_idx==21) {
			instance_destroy();
		}
}


//FLAMETHROWER
if (weapon==10) {
scale+=.05;
depth=20;
y+=grav;
image_xscale=scale;
image_yscale=scale;
}
/////



if (life_limit==true && life_countdown<=0) 
{
	instance_destroy();
}

if (life_countdown>0) && (charging==false)
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


if (wpn_charge>wpn_charge_max) {
	wpn_charge=wpn_charge_max;
}

