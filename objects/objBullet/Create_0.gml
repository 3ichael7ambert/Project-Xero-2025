owner=noone;
target=noone;
parent=noone;
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
following_player = false;
xx=x;
yy=y;


//_id=id;

attack=1;
bullet_speed=1;

weapon=0;

if (weapon==3) {
wpn_charge=2;
} else {
wpn_charge=0;
}

wpn_charge_max=10;
charging=false;

floor_obj=undefined;



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
part_type_size(_ptypeBlast, wpn_charge/20*scale, wpn_charge/20*scale, 0, 0);
part_type_scale(_ptypeBlast, 1, 1);
part_type_speed(_ptypeBlast, wpn_charge/10, wpn_charge/10, 0, 0);
part_type_direction(_ptypeBlast, 0, 360, 3, 0);
part_type_gravity(_ptypeBlast, wpn_charge/100, direction);
part_type_orientation(_ptypeBlast, 0, 0, 10, 0, true);
part_type_life(_ptypeBlast, wpn_charge, wpn_charge);

// Get the interpolated color
var charge_color1 = get_interpolated_color(wpn_charge-2, wpn_charge_max);
var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
var charge_color3 = get_interpolated_color(wpn_charge+2, wpn_charge_max);
//part_type_colour1(_ptypeBlast, charge_color); // Single color for simplicity
part_type_colour3(_ptypeBlast, charge_color1, charge_color2, charge_color3);
//part_type_colour3(_ptypeBlast, $F0FFE2, $77CBFF, $1E56FF);

part_type_alpha3(_ptypeBlast, 1, 1, 0);
part_type_blend(_ptypeBlast, false);


//_pemit1 = part_emitter_create(global.partSysBlast);
//part_emitter_region(global.partSysBlast, _pemit1, -32, 32, -32, 32, ps_shape_ellipse, ps_distr_invgaussian);
//part_emitter_stream(global.partSysBlast, _pemit1, _ptypeBlast, 20);

//part_system_position(global.partSysBlast, room_width/2, room_height/2);


//part_exhuast
_psExhaust = part_system_create();

//Emitter
_ptypeExhaust = part_type_create();
part_type_shape(_ptypeExhaust, pt_shape_cloud);
part_type_size(_ptypeExhaust, 0, 0, .01, 0);
part_type_scale(_ptypeExhaust, 1*scale, 1*scale);
part_type_speed(_ptypeExhaust, 0, 0, 0, 0);
part_type_direction(_ptypeExhaust, 0, 360, 0, 0);
part_type_gravity(_ptypeExhaust, 0, 270);
part_type_orientation(_ptypeExhaust, 0, 360, 0, 0, true);
part_type_colour3(_ptypeExhaust, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptypeExhaust, 1, 1, 1);
part_type_blend(_ptypeExhaust, false);
part_type_life(_ptypeExhaust, 80, 80);


