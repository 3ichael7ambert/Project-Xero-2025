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