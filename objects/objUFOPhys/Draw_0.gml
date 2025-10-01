/// objUFOPhys.Draw — your exact layered look + speed indices

/// @description Insert description here
// You can write your code in this editor
// Draw Event

// --- COMBAT HOOK (top of Draw) ---
var in_combat = (state == "combat") || attacking || provoked; // your own flags
var sx = image_xscale, sy = image_yscale;

// Convert arm_dir to a draw angle that mirrors when facing left
var aim_angle = arm_dir;
//if (sx < 0) aim_angle = 180 - aim_angle;  // mirror the aim

var gun_angle = aim_angle; // keep gun aligned with arm


switch (state) {
    case "idle":
        sprite_index = sprHuman_Body;
		
        break;
    case "walk":
        sprite_index = sprHuman_Body;
        break;
    case "run":
        sprite_index = sprHuman_Body;
        break;
    case "panic":
        sprite_index = sprHuman_Body;
        break;
}











// Draw the sprite with flipping
		//back arm
		if (state=="walk" || state=="combat") {
		//back arm
			draw_sprite_ext(spr_walk_arms_skin,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_arms_shirt,img_idx_shirt_sleeves+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0, shirt_color,1);
			draw_sprite_ext(spr_walk_arms_hand,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			//backleg
			draw_sprite_ext(spr_walk_legs_feet,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_skin,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_pants,img_idx_pants,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(spr_walk_legs_shoes,img_idx_shoes,leg_back_x,leg_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
		}
		if (state=="idle") {
			//back arm
			draw_sprite_ext(spr_idle_arms_skin,0,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			draw_sprite_ext(spr_idle_arms_shirt,0,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			draw_sprite_ext(spr_idle_arms_hand,0,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			//backleg
			draw_sprite_ext(spr_walk_legs_feet,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_skin,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_pants,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(spr_idle_legs_shoes,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
		}
		
		if (jetpack==true) {
				draw_sprite_ext(spr_jetpack,0,x-20*scale,y,image_xscale,image_yscale,angle,skin_color,1);
		}
		//body
		draw_sprite_ext(spr_body,0,x,y,image_xscale,image_yscale,angle,skin_color,1);
		//UNDERWEAR//
		if (gender="female"){
			draw_sprite_ext(spr_body,2,pants_x,pants_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		draw_sprite_ext(spr_body,1,x,y,image_xscale,image_yscale,angle,skin_color,1);
		//pants
		if (pants_style!="none"){
			draw_sprite_ext(spr_body,3,pants_x,pants_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		//pantsbttm
		if (shirt_style!="none"){
			draw_sprite_ext(spr_shirt,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		//front limbs
		if (state=="walk" || state=="combat") {
			
			//front leg
			draw_sprite_ext(spr_walk_legs_feet,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_skin,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_pants,img_idx_pants+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,pants_color,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(spr_walk_legs_shoes,img_idx_shoes+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,shoes_color,1);
			}
			//skirt
			if (pants_style=="skirt") {
				draw_sprite_ext(spr_skirt,img_idx_shoes+4,skirt_x,skirt_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		//front arm
			// front arm
		if (!in_combat && !has_weapon) {
		    // (your original walk front-arm sprites)
		    draw_sprite_ext(spr_walk_arms_skin, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
		    draw_sprite_ext(spr_walk_arms_shirt, img_idx_shirt_sleeves, arm_front_x, arm_front_y, sx, sy, 0, shirt_color, 1);
			//draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,wpn_dir,c_white,1);
			draw_sprite_ext(spr_walk_arms_hand, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
			

		
		/// START HERE ///
		} 
		
		else if (!in_combat && has_weapon) {
			
			//draw_sprite_ext(sprHuman_Arm_Walk_Hand, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
			//front arm
			draw_sprite_ext(spr_idle_arms_skin,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			draw_sprite_ext(spr_idle_arms_shirt,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
			draw_sprite_ext(spr_idle_arms_hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
				
		}
		
		
		}
		
		
		if (state=="idle") {
		//front leg
			draw_sprite_ext(spr_idle_legs_feet,0,foot_front_x,foot_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_idle_legs_skin,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_idle_legs_pants,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,pants_color,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(spr_idle_legs_shoes,0,foot_front_x,foot_front_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		//skirt
			if (pants_style=="skirt") {
				draw_sprite_ext(spr_skirt_idle,img_idx_shoes,skirt_x,skirt_y,image_xscale,image_yscale,0,shoes_color,1);
			}
			
		//front arm
			draw_sprite_ext(spr_idle_arms_skin,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			draw_sprite_ext(spr_idle_arms_shirt,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			if (has_weapon==true) {
				draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
			}
				draw_sprite_ext(spr_idle_arms_hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
		}
	
		if (dir="right") {
			var cx=x;
			var cy=y;
			//head_x=cx+lengthdir_x(10*scale,90);
			//head_y=cy+lengthdir_y(10*scale,90);
		}
		if (dir="left") {
			var cx=x;
			var cy=y;
		//	head_x=cx+lengthdir_x()
		}
		
		draw_sprite_ext(spr_head,img_idx_head,head_x,head_y,image_xscale,image_yscale,0,skin_color,1);
        draw_sprite_ext(spr_eyes,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,eye_color_bg,1);
		
        draw_sprite_ext(spr_eyes_pupils,1+img_idx_eyes,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,eye_color,1);
		draw_sprite_ext(spr_eyes_pupils,0+img_idx_eyes,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,c_white,1);
        
	//	if (race=="zombie") {
			switch (eyes_mood) {
				case "calm": 
					draw_sprite_ext(spr_eye_eyelids,0+img_idx_eyes,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color_eyelids,1);
					break;
				case "panic": 
					//draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
					break;
				case "blink":
					draw_sprite_ext(spr_eye_eyelids,1+img_idx_eyes,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color_eyelids,1);
					break;
			}
		/*
		} else {
			switch (eyes_mood) {
				case "calm": 
					draw_sprite_ext(spr_eye_eyelids,0,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color_eyelids,1);
					break;
				case "panic": 
					//draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
					break;
				case "blink":
					draw_sprite_ext(spr_eye_eyelids,1,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color_eyelids,1);
					break;
		}
		*/
		
		if (facial_hair) {
			draw_sprite_ext(spr_facial_hair,img_idx_facial,head_x,head_y,image_xscale,image_yscale,0,hair_color_2,1);
       
		}
		
		switch (mouth_mood) {
			case "calm": 
				draw_sprite_ext(spr_mouth,0,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "sad": 
				draw_sprite_ext(spr_mouth,1,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "happy": 
				draw_sprite_ext(spr_mouth,2,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "suprised": 
				draw_sprite_ext(spr_mouth,3,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
		}
		
		draw_sprite_ext(spr_eyebrows,img_idx_eyebrows,eyebrows_x,eyebrows_y,image_xscale,image_yscale,0,hair_color,1);
    
	if (sunglasses==true) {
			draw_sprite_ext(spr_sunglasses,0,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
		}
		
		
	switch (hair_style) {
		  //hair_style=choose("long","short","bald","braids","long2","short");
			 case "long": 
				draw_sprite_ext(spr_hair_back,0,hair_x,hair_y,image_xscale,image_yscale,0,hair_color,1);
				draw_sprite_ext(spr_hair_front,0,hair_x,hair_y,image_xscale,image_yscale,0,hair_color_2,1);
				break;
			case "short": 
				draw_sprite_ext(spr_hair_back,2,hair_x,hair_y,image_xscale,image_yscale,0,hair_color,1);
				draw_sprite_ext(spr_hair_front,2,hair_x,hair_y,image_xscale,image_yscale,0,hair_color_2,1);
				break;
			case "braids": 
				draw_sprite_ext(spr_hair_back,1,hair_x,hair_y,image_xscale,image_yscale,0,hair_color,1);
				draw_sprite_ext(spr_hair_front,1,hair_x,hair_y,image_xscale,image_yscale,0,hair_color_2,1);
				break;
			case "long2": 
				draw_sprite_ext(spr_hair_back,3,hair_x,hair_y,image_xscale,image_yscale,0,hair_color,1);
				draw_sprite_ext(spr_hair_front,3,hair_x,hair_y,image_xscale,image_yscale,0,hair_color_2,1);
				break;
			case "short2": 
				draw_sprite_ext(spr_hair_back,2,hair_x,hair_y,image_xscale,image_yscale,0,hair_color,1);
				draw_sprite_ext(spr_hair_front,2,hair_x,hair_y,image_xscale,image_yscale,0,hair_color_2,1);
				break;
			case "brain": 
				draw_sprite_ext(spr_hair_back,4,hair_x,hair_y,image_xscale,image_yscale,0,c_white,1);
				draw_sprite_ext(spr_hair_front,4,hair_x,hair_y,image_xscale,image_yscale,0,c_white,1);
				break;
	}
	
	switch (hat_style) {
		case "backwards":
			draw_sprite_ext(spr_hat,0,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "forwards":
			draw_sprite_ext(spr_hat,0,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "beanie":
			draw_sprite_ext(spr_hat,1,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "bandana":
			draw_sprite_ext(spr_hat,2,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "santa":
			draw_sprite_ext(spr_hat,0,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
			
	}
//hat_style=choose("none","backwards","beanie","forwards","bandana");


if (state=="walk" || state=="combat") {
			
		//front arm
			// front arm
		if (in_combat) && dir=="right" {
		    // Aim + gun while walking
		    draw_sprite_ext(spr_idle_arms_skin, img_idx_body, arm_front_x, arm_front_y, sx, sy, aim_angle, skin_color, 1);
			draw_sprite_ext(spr_idle_arms_shirt,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_dir, shirt_color,1);
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, sx, sy, gun_angle, c_white, 1);
			}
		    draw_sprite_ext(spr_idle_arms_hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_dir,skin_color,1);
		} 
		if (in_combat) && dir=="left" {
		    // Aim + gun while walking
		    draw_sprite_ext(spr_idle_arms_skin, img_idx_body, arm_front_x, arm_front_y, -sx, -sy, aim_angle, skin_color, 1);
		    draw_sprite_ext(spr_idle_arms_shirt,img_idx_shirt_sleeves,arm_front_x,arm_front_y,-sx,-sy,aim_angle, shirt_color,1);
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, -sx, -sy, aim_angle, c_white, 1);
			}
		    draw_sprite_ext(spr_idle_arms_hand,img_idx_body,fist_front_x,fist_front_y,sx,-sy,aim_angle+180,skin_color,1);
		} 

		
		
		}
		
		



///====///

var rot       = hsp;
var ufo_scale = scale * 2;
var ufo_idx   = hsp;
var ufo_idx_lights = -hsp;

// wrap subimages safely
var n_topw   = sprite_get_number(sprUFO_top_white);
var n_bttm   = sprite_get_number(sprUFO_bttm);
var n_lights = sprite_get_number(sprUFO_lights);
var fr_topw  = (n_topw>0)   ? (((round(ufo_idx)         % n_topw)   + n_topw)   % n_topw)   : 0;
var fr_bttm  = (n_bttm>0)   ? (((round(-ufo_idx)        % n_bttm)   + n_bttm)  % n_bttm)   : 0;
var fr_lite  = (n_lights>0) ? (((round(-ufo_idx_lights) % n_lights) + n_lights) % n_lights) : 0;

// positions
var top_x   = x + lengthdir_x(10 * ufo_scale, 90+rot);
var top_y   = y + lengthdir_y(10 * ufo_scale, 90+rot);
var lite_x  = top_x + lengthdir_x(0  * ufo_scale, 90+rot);
var lite_y  = top_y + lengthdir_y(0  * ufo_scale, 90+rot);
var glass_x = top_x + lengthdir_x(40 * ufo_scale, 90+rot);
var glass_y = top_y + lengthdir_y(40 * ufo_scale, 90+rot);
var bttm_x  = top_x + lengthdir_x(30 * ufo_scale, 270+rot);
var bttm_y  = top_y + lengthdir_y(30 * ufo_scale, 270+rot);

// draw


draw_sprite_ext(sprUFO_glass,     0,       glass_x, glass_y, ufo_scale, ufo_scale, rot, c_white,     1);
draw_sprite_ext(sprUFO_bttm,      fr_bttm, bttm_x,  bttm_y,  ufo_scale, ufo_scale, rot, hair_color,  1);
draw_sprite_ext(sprUFO_top,       0,       top_x,   top_y,   ufo_scale, ufo_scale, rot, hair_color,  1);
draw_sprite_ext(sprUFO_top_white, fr_topw, top_x,   top_y,   ufo_scale, ufo_scale, rot, c_white,     1);
draw_sprite_ext(sprUFO_lights,    fr_lite, lite_x,  lite_y,  ufo_scale, ufo_scale, rot, hair_color_2,1);
