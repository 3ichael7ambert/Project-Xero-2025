target=undefined;
parent=undefined;
homing=false;
life_limit=false;
life_countdown=0;
decay=room_speed*2;
grav = 0;           // Initial vertical speed
grav_accel = 0;   // Acceleration due to gravity
grav_max = 0;      // Maximum falling speed
bounce_factor = 0; // How much energy is retained after bouncing (-1 = perfect bounce, less than -1 = energy loss)
bounce=false;
h_speed = 0;         // Horizontal speed
h_friction = 0;   // Friction applied to horizontal movement
scale=1;
punch_side="front";
follow_player = false;
xx=x;
yy=y;

wpn_charge=0;
wpn_charge_max=10;
charging=false;

floor_obj=undefined;

weapon=0;

hitbox=false;


/*
if target.weapon=0 { //FIST
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet);
	with (bullet) {
		target=obj_Player1;
		direction=target.armF_dir;
		speed=10;
		image_xscale=.5*target.scale;
		image_yscale=.5*target.scale;
		
		
		sprite_index=sprFist;
	}
	}
	if weapon=1 { //GUN
		//draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	}
	if weapon=2 { //GUN2
		//draw_sprite_ext(sprGun2, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=3 { //GUN3
		//draw_sprite_ext(sprGun3, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=4 { //SWORD
		//draw_sprite_ext(sprHandSword, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=5 { //SHOTGUN
		
		//draw_sprite_ext(sprShotgun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=6 { //Raygun
		
		//draw_sprite_ext(sprRayGun, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprRayGun, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=7 { //Grenade
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprGrenadeLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=8 { //Rocket
		//draw_sprite_ext(sprRocketLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=9 { //SNIPER
		//draw_sprite_ext(sprSniper, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=10 { //FLAMETHROWER
		//draw_sprite_ext(sprFlamethrower, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	}
	if weapon=11 { //TASER
		//draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		
	}
	if weapon=12 { //CHAINSAW
		draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		
	}

}*/

if (homing==true) {
	
}





//part_blast_wpn
global.partSysBlast = part_system_create(part_blast_wpn);
//part_system_draw_order(global.partSysBlast, true);

//Emitter
_ptypeBlast = part_type_create();
part_type_shape(_ptypeBlast, pt_shape_explosion);
part_type_size(_ptypeBlast, wpn_charge*scale, wpn_charge*scale, 0, 0);
part_type_scale(_ptypeBlast, 1, 1);
part_type_speed(_ptypeBlast, 5, 5, 0, 0);
part_type_direction(_ptypeBlast, 0, 360, 0, 0);
part_type_gravity(_ptypeBlast, 0, 270);
part_type_orientation(_ptypeBlast, 0, 0, 0, 0, false);

// Get the interpolated color
var charge_color1 = get_interpolated_color(wpn_charge-1, wpn_charge_max);
var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
var charge_color3 = get_interpolated_color(wpn_charge+1, wpn_charge_max);
//part_type_colour1(_ptypeBlast, charge_color); // Single color for simplicity
part_type_colour3(_ptypeBlast, charge_color1, charge_color2, charge_color3);
//part_type_colour3(_ptypeBlast, $F0FFE2, $77CBFF, $1E56FF);

part_type_alpha3(_ptypeBlast, 1, 1, 0);
part_type_blend(_ptypeBlast, false);
part_type_life(_ptypeBlast, 50, 50);

//_pemit1 = part_emitter_create(global.partSysBlast);
//part_emitter_region(global.partSysBlast, _pemit1, -32, 32, -32, 32, ps_shape_ellipse, ps_distr_invgaussian);
//part_emitter_stream(global.partSysBlast, _pemit1, _ptypeBlast, 20);

//part_system_position(global.partSysBlast, room_width/2, room_height/2);
