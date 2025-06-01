if mouse_aim=true {
	//draw_circle(xm+cm_x,ym+cm_y,20,true);
	draw_circle(mouse_x_3d,mouse_y_3d,20,true);
	
}
//draw_arrow(x,y,xm,ym,100);

//draw_arrow(x,y,lengthdir_x(100,armF_dir),lengthdir_y(100,armF_dir),20);

draw_arrow(x,y,mouse_x_3d,mouse_y_3d,20);
//draw_sprite_ext(sprite_armF,0,x,y,1,1,armF_dir,c_white,1);

if jetpack_mode=1
{
	
scr_Enemy_Robot_draw_jetpack_1();

}



if jetpack_mode=2
{
	
scr_Enemy_Robot_draw_jetpack_2();
}

if jetpack_mode=3
{
	

scr_Enemy_Robot_draw_jetpack_3();


}







//WEAPONS
if (facing_right && keyboard_check(ord("A")) && wpn_cooldown==0) {
	
if weapon=0 { //FIST


		
	
	}
	if weapon=1 { //GUN

	}
	
	
	if weapon=2 { //GUN2

	}
	
	if weapon=3 { //GUN3
	
	
	}
	
	
	if weapon=4 { //SWORD

	
	}
	if weapon=5 { //SHOTGUN
		

	
	}
	if weapon=6 { //Raygun
		
		//draw_sprite_ext(sprRayGun, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprRayGun, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	parent=obj_Player1;
	target=objEnemyParent;
	dir=parent.armF_dir;
	origin_x=parent.nx_fistF;
	origin_y=parent.ny_fistF;
	check_x=lengthdir_x(2000,dir);
	check_y=lengthdir_y(2000,dir);
	collision_line(origin_x, origin_y, check_x, check_y, target, false, false);
	
	

// Player-related variables
    var x_start = nx_fistF + lengthdir_x(110 * scale, 19 + armF_dir); // Start position of the laser
    var y_start = ny_fistF + lengthdir_y(110 * scale, 19 + armF_dir);
    var laser_angle = armF_dir; // Laser angle
    var laser_length = 10000;   // Maximum laser length
    var max_bounces = 5;        // Maximum number of bounces
    var wall_object = objCityParent_Skyline;

    // Calculate end position for the initial ray
    var x_end = x_start + lengthdir_x(laser_length, laser_angle);
    var y_end = y_start + lengthdir_y(laser_length, laser_angle);

    // Perform raycast with bounces
    var laser_path = raycast_bounce3(x_start, y_start, x_end, y_end, max_bounces, wall_object);

    // Draw each segment of the laser path
    for (var i = 0; i < array_length(laser_path) - 1; i++) {
        var start_point = laser_path[i];
        var end_point = laser_path[i + 1];

        // Debug: Show each segment in the console
        show_debug_message("Segment " + string(i) + ": Start (" + string(start_point[0]) + ", " + string(start_point[1]) +
                           ") -> End (" + string(end_point[0]) + ", " + string(end_point[1]) + ")");

        // Draw the laser segment
        draw_line_color(start_point[0], start_point[1], end_point[0], end_point[1], c_green, c_green);
    }





	
	//draw_line_color(nx_fistF+lengthdir_x(110*scale,19+armF_dir),ny_fistF+lengthdir_y(110*scale,19+armF_dir),x+1000,y+1000,c_white,c_white);
	
	
	
	
	
	
	
	// Perform raycast
    var collision = raycast(nx_fistF,ny_fistF,lengthdir_x(1000,armF_dir),lengthdir_y(1000,armF_dir),objCityParent_Skyline);
    // Draw the line
    if (collision != -1) {
        // Draw up to the collision point
      //  draw_line_color(nx_fistF+lengthdir_x(110*scale,19+armF_dir), ny_fistF+lengthdir_y(110*scale,19+armF_dir), collision[0], collision[1], c_red, c_white);
    } else {
        // No collision; draw the full length
       // draw_line_color(nx_fistF+lengthdir_x(110*scale,19+armF_dir), ny_fistF+lengthdir_y(110*scale,19+armF_dir), lengthdir_x(1000,armF_dir), lengthdir_y(1000,armF_dir), c_red, c_white);
    }
	
	
	
	
	
	
	
	}
	
	if weapon=7 { //Grenade
	
	}
	

	if weapon=8 { //Rocket
	
	}
	

	if weapon=9 { //SNIPER
	
	}
	

	if weapon=10 { //FLAMETHROWER

	}
	

	if weapon=11 { //TASER
		//draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///

	
	
	}
	if weapon=12 { //CHAINSAW
		//draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///

	}
		
	

}


/*
var part_smoke_count = part_particles_count(global.partSysCharge);
draw_text_color(x +100,y-100,part_smoke_count,c_red,c_red,c_red,c_red,1);
*/






	