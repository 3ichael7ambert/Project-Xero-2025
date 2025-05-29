function scr_Enemy_Robot_step_weapons(){

//Weapon Limits
if (weapon<0) {weapon=12;}
if (weapon>=13) {weapon=0;}
// Weapon Ammo Control

//Weapon Cooldown
if (wpn_cooldown>0)
{
	wpn_cooldown--;
}
if (wpn_cooldown<0)
{
	wpn_cooldown=0;
}

	if (wpn_charge>wpn_charge_max)
		{wpn_charge=wpn_charge_max;}


if (shooting==false) {	
	wpn_charge=0;	
}


//BULLETS SYSTEM
if (punch=true) {
	punch_img_idx++;	
}
if (punch_img_idx>10) {
	punch=false;
	punch_img_idx=0;
	
	if (punch_side=="front") { punch_side="back";}
	else if (punch_side=="back") { punch_side="front";}
	
}

if (sword=true) {
	sword_img_idx++;	
}

if (sword_img_idx==13) {
	sword_num = irandom(6);
}

if (sword_img_idx>21) {
	sword=false;
	sword_img_idx=0;
	sword_num = irandom(6);
}

switch (sword_num) {
	case 1:
		spr_sword_arm = sprArmSword_1_Arm;
		spr_sword_sword = sprArmSword_1_Sword;
		spr_sword_fx = sprArmSword_1_Fx;
		break;
	case 2:
		spr_sword_arm = sprArmSword_2_Arm;
		spr_sword_sword = sprArmSword_2_Sword;
		spr_sword_fx = sprArmSword_2_Fx;
		break;
	case 3:
		spr_sword_arm = sprArmSword_3_Arm;
		spr_sword_sword = sprArmSword_3_Sword;
		spr_sword_fx = sprArmSword_3_Fx;
		break;
	case 4:
		spr_sword_arm = sprArmSword_1_Arm_rev;
		spr_sword_sword = sprArmSword_1_Sword_rev;
		spr_sword_fx = sprArmSword_1_Fx_rev;
		break;
	case 5:
		spr_sword_arm = sprArmSword_2_Arm_rev;
		spr_sword_sword = sprArmSword_2_Sword_rev;
		spr_sword_fx = sprArmSword_2_Fx_rev;
		break;
	case 6:
		spr_sword_arm = sprArmSword_3_Arm_rev;
		spr_sword_sword = sprArmSword_3_Sword_rev;
		spr_sword_fx = sprArmSword_3_Fx_rev;
		break;
}


	
if (weapon==0 && punch==false && shooting && wpn_cooldown==0) { //FIST
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	
		punch=true;
		wpn_cooldown=10;
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=2;
	
	
	with (bullet) {
		parent=obj_Player1;
		weapon=0;
		if (parent.punch_side="front") {
		depth=parent.depth-10;
		}else
		if (parent.punch_side="back") {
		depth=parent.depth+10;
		}else{
		depth=parent.depth-10;	
		}
		
		direction=parent.armF_dir;
		//speed=10;
		scale=1*parent.scale;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		//alarm[0]=10;///destroy
		sprite_index=sprArmPunch_fx;
		following_player=true;
		punch_side=parent.punch_side;
		//life_countdown=parent.bullet_life;
		//life_limit=true;		
	}
	
		
	
	}
	
	
	
	if (weapon==1 && shooting && wpn_cooldown==0) { //GUN
		//draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	

	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=2;
	bullet.parent=self;
	with (bullet) {
	
		weapon=1;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		//wpn_cooldown=2;
		
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	
	if (weapon=2 && shooting && wpn_cooldown==0) { //GUN2
		//draw_sprite_ext(sprGun2, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=4;
	with (bullet) {
		parent=obj_Player1;
		weapon=2;
		depth=parent.depth+1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	}



	if (weapon==3 && shooting && wpn_cooldown==0) { //GUN3 //CHARGE CANON
		//draw_sprite_ext(sprGun3, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=6;
			
	with (bullet) {
		parent=obj_Player1;
		weapon=3;
		depth=parent.depth-1;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=1*parent.scale;
		image_yscale=1*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
		charging=true;
	}
	
	
	}
	
	if (weapon==3 && shooting && wpn_cooldown==0) {
			wpn_charge+=1;
	if !part_system_exists(global.partSysCharge)
			{
			    global.partSysCharge = part_system_create(part_charge_wpn);
			}
		if part_system_exists(global.partSysCharge) {
			
			var xxx=nx_armF+lengthdir_x(100*scale,armF_dir);
			var yyy=ny_armF+lengthdir_y(100*scale,armF_dir);
			var spwn_rdm = irandom(360);
			var xxxx = xxx + lengthdir_x(20*wpn_charge*scale,spwn_rdm);
			var yyyy = yyy + lengthdir_y(20*wpn_charge*scale,spwn_rdm);
			var dirxy = point_direction(xxxx,yyyy,xxx,yyy);
		
		
part_type_shape(_ptypeCharge, pt_shape_sphere);
part_type_size(_ptypeCharge, .1*wpn_charge, .1*wpn_charge, 0, 0);
part_type_scale(_ptypeCharge, 0.1, 0.1);
// Get the interpolated color
var charge_color1 = get_interpolated_color(wpn_charge-2, wpn_charge_max);
var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
var charge_color3 = get_interpolated_color(wpn_charge+2, wpn_charge_max);
//part_type_colour1(_ptypeBlast, charge_color); // Single color for simplicity
part_type_colour3(_ptypeCharge, charge_color1, charge_color2, charge_color3);
		
			part_type_direction(_ptypeCharge, dirxy, dirxy, 0, 0);
			part_type_life(_ptypeCharge, 2*wpn_charge*scale, 2*wpn_charge*scale);
			part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,1);
			part_particles_create(global.partSysCharge,xxxx,yyyy,_ptypeCharge,10);
			//part_particles_create(global._ps,nx_fistF,ny_fistF,_ptype1,10);
			//part_system_position(global.partSysCharge,xxx,yyy);
			//part_system_depth(global.partSysCharge,depth-10);
		}}
		
	
	
	if (weapon==4 && sword==false && shooting) { //SWORD
			//draw_sprite_ext(sprHandSword, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	
	
		var attack_force=10;
		//hsp += attack_force * cos(degtorad(armF_dir));
		//vsp -= attack_force * sin(degtorad(armF_dir));
		if place_empty(x+bbox_right,y,floor_obj)  
		{
		//hsp = attack_force * cos(degtorad(attack_angle));
		//vsp = attack_force * sin(degtorad(attack_angle));
		}
		if place_empty(x-bbox_left+hsp,y-20,floor_obj) 
		{
		
		}
	    if place_empty(x,bbox_bottom,floor_obj) 
	    {
	        vsp -= 0.4;
	    }  
	    if place_empty(x,bbox_top,floor_obj)
		{
	        vsp -= 0.4;
	    } 
	
		sword=true;
		wpn_cooldown=10;
	
		bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		
	wpn_cooldown=2;
	
	
	with (bullet) {
		parent=obj_Player1;
		weapon=4;
		depth=parent.depth-10;
		sprite_index=parent.spr_sword_fx;
		
		//speed=10;
		scale=1*parent.scale;
		if (parent.facing_right) {
			direction=parent.armF_dir;
			image_xscale=1*parent.scale;
			image_yscale=1*parent.scale;
		} else {
			direction=parent.armF_dir;
			image_xscale=1*parent.scale;
			image_yscale=1*parent.scale;
		}
	
		//alarm[0]=10;///destroy
		following_player=true;
		//punch_side=parent.punch_side;
		//life_countdown=parent.bullet_life;
		//life_limit=true;		
	}
	
		
	
	}
	
	if (weapon=5 && shooting && wpn_cooldown==0) { //SHOTGUN
		
		//draw_sprite_ext(sprShotgun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		wpn_cooldown=12;
		
		bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		bullet2 = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		bullet3 = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		bullet4 = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		bullet5 = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	
		with (bullet) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet2) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet3) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet4) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}	
		with (bullet5) {
		parent=obj_Player1;
		weapon=6;
		depth=parent.depth+1;
		direction=parent.armF_dir-5+random(10);
		speed=10+random(2);
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	
	
}
	
	if (weapon=6 && shooting && wpn_cooldown==0) { //Raygun
		
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
	
	//
	//
	var x_start = x; // Starting x-coordinate (e.g., laser's current position)
    var y_start = y; // Starting y-coordinate (e.g., laser's current position)
    var laser_angle = 45; // Initial angle of the laser in degrees
    var max_bounces = 5; // Maximum number of bounces
    var wall_object = objCityParent_Skyline; // The object the laser can collide with

    // Call the bounce_raycast function
    var laser_path = bounce_raycast(x_start, y_start, laser_angle, max_bounces, wall_object);

    // Draw the laser's path for visualization
    for (var i = 0; i < array_length(laser_path) - 1; i++) {
        var start_point = laser_path[i];
        var end_point = laser_path[i + 1];

     draw_line(start_point[0], start_point[1], end_point[0], end_point[1]);
	//
	//
	}
	}
	
	if (weapon==7 && shooting && wpn_cooldown==0) { //Grenade
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprGrenadeLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=7;
		depth=parent.depth-1;
		sprite_index=sprGrenade;
		direction=parent.armF_dir;
		speed=10;
		//speed=parent.wpn_charge;
		image_xscale=2*parent.scale;
		image_yscale=2*parent.scale;
		life_countdown=100;
		life_limit=true;
		bounce = true;
		grav = 1;           // Initial vertical speed
		grav_accel = 0.5;   // Acceleration due to gravity
		grav_max = 0;      // Maximum falling speed
		bounce_factor = -0.8; // How much energy is retained after bouncing (-1 = perfect bounce, less than -1 = energy loss)
		h_speed = 4;         // Horizontal speed
		h_friction = 0.98;   // Friction applied to horizontal movement	
		floor_obj = obj_block_64;
	}
	
	}
	if (weapon==8 && shooting && wpn_cooldown==0) { //Rocket
		//draw_sprite_ext(sprRocketLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///

	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=8;
		homing=true;
		if instance_exists(objEnemyParent) {
			target = instance_nearest(x, y, objEnemyParent);
		} else {
			
			target = instance_nearest(x, y, objHuman);
		}
		sprite_index=sprRocket;
		depth=parent.depth+1;
			sprite_index=sprRocket;
		direction=parent.armF_dir;
		speed=10;
		scale=.2;
		image_xscale=scale;
		image_yscale=scale;
		//life_countdown=parent.bullet_life;
		life_countdown=100;
		decay=100;
		life_limit=true;
	}
	
	}
	
	if (weapon==9) { //sniper
		global.snipe=true;
		
		if instance_exists(objSnipe) {
			if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach) {
				global.CameraManager.target=objSnipe;
			}
		} else {
			obj_snipe = instance_create(x,y,objSnipe);
			with (obj_snipe) {
				parent=obj_Player1;
			}
		}
	}else{
		global.snipe=false;
		if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach) {
			global.CameraManager.target=self;
		}
	}
	
	
	if (weapon=9 && shooting && wpn_cooldown==0) { //SNIPER
		//draw_sprite_ext(sprSniper, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	bullet = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
	wpn_cooldown=2;
	with (bullet) {
		parent=obj_Player1;
		weapon=9;
		depth=parent.depth+1;
		sprite_index=sprBullet;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		life_countdown=parent.bullet_life;
		life_limit=true;
	}
	
	}
	if (weapon==10 && shooting && wpn_cooldown==0) { //FLAMETHROWER
		//draw_sprite_ext(sprFlamethrower, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	if (facing_right) {
		bullet = instance_create(nx_fistF+lengthdir_x(120*scale,armF_dir+15),ny_fistF+lengthdir_y(120*scale,armF_dir+15),objBullet_Enemy);
	} else {
		bullet = instance_create(nx_fistF+lengthdir_x(120*scale,armF_dir-15),ny_fistF+lengthdir_y(120*scale,armF_dir-15),objBullet_Enemy);
	}
	
	wpn_cooldown=0;
	with (bullet) {
		parent=obj_Player1;
		weapon=10;
		scale=.05;
		depth=parent.depth+1;
		sprite_index=sprBullet;
		direction=parent.armF_dir;
		speed=10;
		image_xscale=.5*parent.scale;
		image_yscale=.5*parent.scale;
		hitbox=true;
		grav=-4;
		decay=40*parent.scale;
	}
	
	
	
	if !part_system_exists(global._psFlamethrower)
			{
			    global._psFlamethrower = part_system_create(part_smoke);
			}
		if part_system_exists(global._psFlamethrower) {
			
		part_type_direction(_ptypeFlamethrower,armF_dir +10, armF_dir - 10, 0, 0);
			if (facing_right) {
				
				part_particles_create(global._psFlamethrower,nx_fistF+lengthdir_x(120*scale,armF_dir+10),ny_fistF+lengthdir_y(120*scale,armF_dir+10),_ptypeFlamethrower,10);
			//part_system_position(global.partSysSmoke,nx_fistF,ny_fistF);
			//part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,1);
			//part_system_depth(global.partSysSmoke,depth-10);
			} else {
				part_particles_create(global._psFlamethrower,nx_fistF+lengthdir_x(120*scale,armF_dir-10),ny_fistF+lengthdir_y(120*scale,armF_dir-10),_ptypeFlamethrower,10);
			}
		}
	
		if !part_system_exists(global.partSysSmoke)
			{
			    global.partSysSmoke = part_system_create(part_smoke);
			}
		if part_system_exists(global.partSysSmoke) {
			part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,-1);
			//part_system_position(global.partSysSmoke,nx_fistF,ny_fistF);
			part_system_depth(global.partSysSmoke,depth-10);
//part_particles_clear(_ptypeSmoke);
//part_system_destroy(global.partSysSmoke);

		}
	
	}
	
	
	
	
	if (weapon==11 && shooting && wpn_cooldown==0) { //TASER
		//draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
	taser_img++;
	
	if !instance_exists(objHitbox)
		{
		hitbox = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		wpn_cooldown=2;
		with (hitbox) {
			parent=obj_Player1;
			weapon=12;
			hitbox=true;
			xx=parent.nx_fistF;
			yy=parent.nx_fistF;
			depth=parent.depth+1;
			sprite_index=sprTaser;
			direction=parent.armF_dir;
			//speed=0;
			image_xscale=parent.image_xscale;
			image_yscale=parent.image_yscale;
			image_angle=parent.armF_dir;
			
			following_player=true;
			
				}
		
		}
	
	}
	if (weapon==11 && shooting && wpn_cooldown==0) { //TASER
		
		var xxx=nx_armF+lengthdir_x(200*scale,armF_dir-3);
		var yyy=ny_armF+lengthdir_y(200*scale,armF_dir-3);
		part_system_depth(global._psElec,depth-10);
		part_particles_create(global._psElec,xxx,yyy,_ptypeElec,10);
	
	
	}
	
	
	if (weapon==12 && shooting && wpn_cooldown==0) { //CHAINSAW
		 
		if !instance_exists(objHitbox)
		{
		hitbox = instance_create(nx_fistF,ny_fistF,objBullet_Enemy);
		wpn_cooldown=2;
		with (hitbox) {
			parent=obj_Player1;
			weapon=12;
			hitbox=true;
			xx=parent.nx_fistF;
			yy=parent.nx_fistF;
			depth=parent.depth-1;
			sprite_index=sprChainsaw;
			direction=parent.armF_dir;
			//speed=0;
			image_xscale=parent.image_xscale;
			image_yscale=parent.image_yscale;
			
			image_angle=parent.armF_dir;
			
			following_player=true;
				}
		
		}
		
		
		
		
	}
	
	if (weapon=12 && shooting && wpn_cooldown==0) { //CHAINSAW
		//draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		//draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, -1, 1); ///
		chainsaw_blade++;
		if !part_system_exists(global.partSysSmoke)
			{
			    global.partSysSmoke = part_system_create(part_smoke);
			}
		if part_system_exists(global.partSysSmoke) {
			



			part_particles_create(global.partSysSmoke,nx_fistF,ny_fistF,_ptypeSmoke,1);
			//part_system_position(global.partSysSmoke,nx_fistF,ny_fistF);
			part_system_depth(global.partSysSmoke,depth-10);
			
			
//part_particles_clear(_ptypeSmoke);
//part_system_destroy(global.partSysSmoke);

		}
		
		
		
		
		
	}
	
	if (weapon=12 && !shooting) {
			
		if !part_system_exists(global.partSysSmoke)
			{
			    part_system_destroy(global.partSysSmoke);
			}


	}
	








if (weapon!=12 || !(shooting)) {
	//part_system_destroy(partSysSmoke);
}




}