if ( global.players>1){
	scr_draw_player_indicator(player);
}


if (mouse_aim=true) {
	//draw_circle(xm+cm_x,ym+cm_y,20,true);
	draw_circle(mouse_x_3d,mouse_y_3d,20,true);
	
	draw_sprite_ext(sprCrosshair_Mouse,0, mouse_x_3d,mouse_y_3d,.5,.5,0,color1,1);
	//draw_arrow(x,y,mouse_x_3d,mouse_y_3d,20);
	
}

if gamepad=true {
	mouse_aim=false;} else {
		mouse_aim=true;}
//draw_arrow(x,y,xm,ym,100);

//draw_arrow(x,y,lengthdir_x(100,armF_dir),lengthdir_y(100,armF_dir),20);


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






///CONTROL DEBUG
/**
draw_text(x+10,y-10, "Player: " + string(self_id));

draw_text(x+10,y-20, "Gamepad: " +string(gamepad));

draw_text(x+10,y-30, "Controller: " +string(input_mapper.controller.device_index));

draw_text(x+10,y-40, "Controller: " +string(gamepad_num));
*/

	
	
	if (jetpack_mode == 4) {
    // draw a single “ball” sprite or your head sprite rotated while rolling
    var spr = sprHead; // temp: use a ball sprite if you have one
    var ang = image_angle;
    if (jp4_state == JP4_STATE_ROLL || jp4_state == JP4_STATE_SLAM || jp4_state == JP4_STATE_HOMING) {
        ang += hsp * -6;
    }
    draw_sprite_ext(spr, 0, x, y, image_xscale, image_yscale, ang, c_white, 1);
    // (Skip the limb assembly while in ball state, unless you want to keep it.)


// --- SPIN UPDATE (put once after the jp4_state switch) ---

var on_ground = place_meeting(x, y + 1, floor_obj);
var speed_h   = hsp;
var speed_tot = point_distance(0,0,hsp,vsp);

// 1) Pick a target spin rate for this frame (deg/step)
var target_degps = 0;

switch (jp4_state) {
    case JP4_STATE_ROLL:
        if (on_ground) {
            // wheel on ground: spin = -velocity/Radius
            target_degps = -pxps_to_degps(speed_h);
        } else {
            // air: keep spinning but influenced by horizontal speed
            target_degps = -pxps_to_degps(speed_h) * 0.6;
        }
    break;

    case JP4_STATE_CHARGE:
        // almost locked, tiny “vibration”
        target_degps = 0;
        ang_vel *= 0.9;
        ang_vel += sin(current_time*0.4) * 2;
    break;

    case JP4_STATE_SLAM:
        // spin matches *total* velocity vector for juicy feel
        // bias by horizontal so it doesn’t look weird on straight down slams
        target_degps = -pxps_to_degps(speed_tot) * (0.6 + 0.4*abs(lengthdir_x(1, point_direction(0,0,hsp,vsp))));
    break;

    case JP4_STATE_HOMING:
        // fast spin burst
        target_degps = -pxps_to_degps(speed_tot) * 1.1;
    break;

    default:
        // idle
        target_degps = 0;
    break;
}

// 2) Ease ang_vel toward target, with different damping on ground vs air
var accel = spin_accel;
var diff  = clamp(target_degps - ang_vel, -accel, accel);
ang_vel  += diff;

// extra damping
if (on_ground) {
    // bleed mismatch so it quickly syncs with ground speed
    ang_vel = lerp(ang_vel, target_degps, 1 - ground_stick);
} else {
    // let it persist in air
    ang_vel *= air_decay;
}

// 3) Clamp and integrate
ang_vel   = clamp(ang_vel, -spin_max, spin_max);
ang      += ang_vel;

// 4) Apply to sprite
image_angle = ang;
	}
	
	
	draw_text_outlined(x,y,string(grav_dir),c_black,c_white);
	draw_text_outlined(x,y+20,string(isJumping),c_black,c_white);
	
	draw_self();