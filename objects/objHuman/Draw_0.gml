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
			draw_sprite_ext(spr_walk_arms_skin,0,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			draw_sprite_ext(spr_walk_arms_shirt,0,arm_back_x,arm_back_y,image_xscale,image_yscale,0, shirt_color,1);
			draw_sprite_ext(spr_walk_arms_hand,0,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			//backleg
			draw_sprite_ext(spr_walk_legs_feet,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_skin,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_pants,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(spr_idle_legs_shoes,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
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
        draw_sprite_ext(spr_eyes_pupils,1,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,eye_color,1);
		draw_sprite_ext(spr_eyes_pupils,0,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,c_white,1);
        
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
		
		







/*
if (race=="human") {

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
			draw_sprite_ext(spr_walk_arms_skin,0,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			draw_sprite_ext(spr_walk_arms_shirt,0,arm_back_x,arm_back_y,image_xscale,image_yscale,0, shirt_color,1);
			draw_sprite_ext(spr_walk_arms_hand,0,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			//backleg
			draw_sprite_ext(spr_walk_legs_feet,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_skin,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(spr_walk_legs_pants,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(spr_idle_legs_shoes,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
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
        draw_sprite_ext(spr_eyes,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(spr_eyes_pupils,1,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,eye_color,1);
		draw_sprite_ext(spr_eyes_pupils,0,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,c_white,1);
        
		switch (eyes_mood) {
			case "calm": 
				draw_sprite_ext(spr_eye_eyelids,0,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "panic": 
				//draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "blink":
				draw_sprite_ext(spr_eye_eyelids,1,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
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
		
		
}




if (race=="alien") {
// Draw the sprite with flipping
		//back arm
		if (state=="walk" || state=="combat") {
		//back arm
			draw_sprite_ext(sprHuman_Arm_Walk_Arms,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Walk,img_idx_shirt_sleeves+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Walk,img_idx_shirt_sleeves+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0, shirt_color,1);
			}
			draw_sprite_ext(sprHuman_Arm_Walk_Hand,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			//backleg
			draw_sprite_ext(sprHuman_Pants_Walk_Feet,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Walk,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			if (pants_style=="long") {
				draw_sprite_ext(sprHuman_Pants_Walk_Pants,img_idx_pants,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (pants_style=="shorts") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shorts,img_idx_pants,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes,leg_back_x,leg_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
		}
		if (state=="idle") {
			//back arm
			draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Idle,img_idx_shirt_sleeves,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt_sleeves,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_back_x,fist_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			//backleg
			draw_sprite_ext(sprHuman_Pants_Idle_Feet,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Idle,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			if (pants_style=="long") {
				draw_sprite_ext(sprHuman_Pants_Idle_Pants,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (pants_style=="shorts") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shorts,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shoes,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
		}
		
		
		//body
		draw_sprite_ext(sprHuman_Body,0,x,y,image_xscale,image_yscale,angle,skin_color,1);
		//UNDERWEAR//
		if (gender="female"){
			//draw_sprite_ext(sprHuman_Body,2,pants_x,pants_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		draw_sprite_ext(sprHuman_Body,1,x,y,image_xscale,image_yscale,angle,skin_color,1);
		//pants
		if (pants_style!="none"){
			draw_sprite_ext(sprHuman_Body,3,pants_x,pants_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		//pantsbttm
		if (shirt_style!="none"){
			draw_sprite_ext(sprHuman_Shirt,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		//front limbs
		if (state=="walk" || state=="combat") {
			
			//front leg
			draw_sprite_ext(sprHuman_Pants_Walk_Feet,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Walk,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			if (pants_style=="long") {
				draw_sprite_ext(sprHuman_Pants_Walk_Pants,img_idx_pants+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (pants_style=="shorts") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shorts,img_idx_pants+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,shoes_color,1);
			}
			//skirt
			if (pants_style=="skirt") {
				draw_sprite_ext(sprHuman_Pants_Walk_Skirt,img_idx_shoes+4,skirt_x,skirt_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		//front arm
		if (!in_combat && !has_weapon) {
			draw_sprite_ext(sprHuman_Arm_Walk_Arms,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,0,skin_color,1);
			if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Walk,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,0, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Walk,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,0, shirt_color,1);
			}
			draw_sprite_ext(sprHuman_Arm_Walk_Hand,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,0,skin_color,1);
		} else if (!in_combat && has_weapon) {
			
			//draw_sprite_ext(sprHuman_Arm_Walk_Hand, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
			//front arm
			draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
				draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
				draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
				
		}
		
		
		
		}
		
		if (state=="idle") {
		//front leg
			draw_sprite_ext(sprHuman_Pants_Idle_Feet,0,foot_front_x,foot_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Idle,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			if (pants_style=="long") {
				draw_sprite_ext(sprHuman_Pants_Idle_Pants,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (pants_style=="shorts") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shorts,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,pants_color,1);
			}
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shoes,0,foot_front_x,foot_front_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		//skirt
			if (pants_style=="skirt") {
				draw_sprite_ext(sprHuman_Pants_Idle_Skirt,img_idx_shoes,skirt_x,skirt_y,image_xscale,image_yscale,0,shoes_color,1);
			}
			
		//front arm
			draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			if (has_weapon==true) {
				draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,wpn_dir,c_white,1);
			}
				draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
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
		
		draw_sprite_ext(sprAlien_Head,img_idx_head,head_x,head_y,image_xscale,image_yscale,0,skin_color,1);
        draw_sprite_ext(sprHuman_Head_Eyes,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,eye_color,1);
      //  draw_sprite_ext(sprHuman_Head_Eyes_Pupils,1,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,eye_color,1);
	//	draw_sprite_ext(sprHuman_Head_Eyes_Pupils,0,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,c_white,1);
		if (sunglasses==true) {
			draw_sprite_ext(sprHuman_eyes_sunglasses,0,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
		}
		
		switch (eyes_mood) {
			case "calm": 
			//	draw_sprite_ext(sprAlien_Head_Eyelids,0,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "panic": 
				//draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "blink":
			//	draw_sprite_ext(sprAlien_Head_Eyelids,1,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
		}
		
		switch (mouth_mood) {
			case "calm": 
				draw_sprite_ext(sprHuman_Head_Mouths,0,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "sad": 
				draw_sprite_ext(sprHuman_Head_Mouths,1,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "happy": 
				draw_sprite_ext(sprHuman_Head_Mouths,2,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "suprised": 
				draw_sprite_ext(sprHuman_Head_Mouths,3,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
		}
		
		//draw_sprite_ext(sprHuman_Head_Eyebrows,img_idx_eyebrows,eyebrows_x,eyebrows_y,image_xscale,image_yscale,0,hair_color,1);
    

	
	switch (hat_style) {
		case "backwards":
			draw_sprite_ext(sprHuman_Head_Hats,0,hair_x,hair_y-(10*scale),image_xscale,image_yscale,0,hat_color,1);
			break;
		case "forwards":
			//draw_sprite_ext(sprHuman_Head_Hats,0,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "beanie":
			//draw_sprite_ext(sprHuman_Head_Hats,1,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "bandana":
			//draw_sprite_ext(sprHuman_Head_Hats,2,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
			
	}
//hat_style=choose("none","backwards","beanie","forwards","bandana");

if (state=="walk" || state=="combat") {
			
		//front arm
			// front arm
		if (in_combat) && dir=="right" {
		    // Aim + gun while walking
		    draw_sprite_ext(sprHuman_Arm_Idle, img_idx_body, arm_front_x, arm_front_y, sx, sy, aim_angle, skin_color, 1);
		    if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_dir, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_dir, shirt_color,1);
			}
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, sx, sy, gun_angle, c_white, 1);
			}
		    draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_dir,skin_color,1);
		} 
		if (in_combat) && dir=="left" {
		    // Aim + gun while walking
		    draw_sprite_ext(sprHuman_Arm_Idle, img_idx_body, arm_front_x, arm_front_y, -sx, -sy, aim_angle, skin_color, 1);
		    if (shirt_style=="short") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Short_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,-sx,-sy,aim_angle, shirt_color,1);
			}
			if (shirt_style=="long") {
				draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,-sx,-sy,aim_angle, shirt_color,1);
			}
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, -sx, -sy, aim_angle, c_white, 1);
			}
		    draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,sx,-sy,aim_angle+180,skin_color,1);
		} 

		
		
		}
		
		
}




if (race=="spraycan") {
// Draw the sprite with flipping
		//back arm
		if (state=="walk") {
		//back arm
			draw_sprite_ext(sprSpraycan_Arm_Shirt_Long_Walk,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,c_yellow,1);
			draw_sprite_ext(sprSpraycan_Arm_Walk_Hand,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,c_white,1);
			//backleg
			draw_sprite_ext(sprHuman_Pants_Walk_Feet,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_yellow,1);
			draw_sprite_ext(sprHuman_Leg_Walk,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_yellow,1);
			
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_white,1);
			}
		
		}
		if (state=="idle") {
			//back arm
			draw_sprite_ext(sprSpraycan_Arm_Idle,img_idx_body,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
			draw_sprite_ext(sprSpraycan_Arm_Hand,img_idx_body,fist_back_x,fist_back_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
			//backleg
			draw_sprite_ext(sprHuman_Pants_Idle_Feet,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,c_yellow,1);
			draw_sprite_ext(sprHuman_Leg_Idle,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_yellow,1);
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shoes,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,c_white,1);
			}
		
		}
		
		
		//body
		draw_sprite_ext(sprSpraycan_Body,0,x,y,image_xscale,image_yscale,angle,c_white,1);
		//front limbs
//front limbs
		if (state=="walk" || state=="combat") {
			
			//front leg
			draw_sprite_ext(sprHuman_Pants_Walk_Feet,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprSpraycan_Leg_Walk,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
		//front arm
			// front arm
		if (!in_combat && !has_weapon) {
		    // (your original walk front-arm sprites)
		    draw_sprite_ext(sprSpraycan_Arm_Shirt_Long_Walk, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
		
			//draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,wpn_dir,c_white,1);
			draw_sprite_ext(sprSpraycan_Arm_Walk_Hand, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
			

		
		/// START HERE ///
		} 
		
		else if (!in_combat && has_weapon) {
			
			//draw_sprite_ext(sprHuman_Arm_Walk_Hand, img_idx_body, arm_front_x, arm_front_y, sx, sy, 0, skin_color, 1);
			//front arm
			draw_sprite_ext(sprSpraycan_Arm_Idle,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
				draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
				draw_sprite_ext(sprSpraycan_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
				
		}
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
		if dir="right" {
			var spray_eyes_x = eyes_x - (17*scale);;
			var spray_eyes_y = eyes_y + (90*scale);
			var spray_eyes_pupils_x = eyes_pupils_x  - (17*scale);;
			var spray_eyes_pupils_y = eyes_pupils_y + (100*scale);		
			var spray_mouth_x = mouth_x;
			var spray_mouth_y = mouth_y + (100*scale);
		}
		if dir="left" {
			var spray_eyes_x = eyes_x + (17*scale);
			var spray_eyes_y = eyes_y + (90*scale);
			var spray_eyes_pupils_x = eyes_pupils_x  + (17*scale);
			var spray_eyes_pupils_y = eyes_pupils_y + (100*scale);		
			var spray_mouth_x = mouth_x;
			var spray_mouth_y = mouth_y + (100*scale);
		}
		
		
		//draw_sprite_ext(sprAlien_Head,img_idx_head,head_x,head_y,image_xscale,image_yscale,0,skin_color,1);
        draw_sprite_ext(sprSpraycan_Head_Eyes,img_idx_eyes,spray_eyes_x,spray_eyes_y,image_xscale,image_yscale,0,c_white,1);
      //  draw_sprite_ext(sprHuman_Head_Eyes_Pupils,1,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,eye_color,1);
		draw_sprite_ext(sprHuman_Head_Eyes_Pupils,0,spray_eyes_pupils_x,spray_eyes_pupils_y,image_xscale,image_yscale,0,c_white,1);
		
       // draw_sprite_ext(sprHuman_eyes_sunglasses,0,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
        
		switch (eyes_mood) {
			case "calm": 
			//	draw_sprite_ext(sprAlien_Head_Eyelids,0,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "panic": 
				//draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "blink":
			//	draw_sprite_ext(sprAlien_Head_Eyelids,1,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
		}

		switch (mouth_mood) {
			case "calm": 
				draw_sprite_ext(sprHuman_Head_Mouths,0,spray_mouth_x,spray_mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "sad": 
				draw_sprite_ext(sprHuman_Head_Mouths,1,spray_mouth_x,spray_mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "happy": 
				draw_sprite_ext(sprHuman_Head_Mouths,2,spray_mouth_x,spray_mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "suprised": 
				draw_sprite_ext(sprHuman_Head_Mouths,3,spray_mouth_x,spray_mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
		}
		
		//draw_sprite_ext(sprHuman_Head_Eyebrows,img_idx_eyebrows,eyebrows_x,eyebrows_y,image_xscale,image_yscale,0,hair_color,1);
    

	
	

//hat_style=choose("none","backwards","beanie","forwards","bandana");


if (state=="walk" || state=="combat") {
			
		//front arm
			// front arm
		if (in_combat) && dir=="right" {
		    // Aim + gun while walking
		    draw_sprite_ext(sprSpraycan_Arm_Idle, img_idx_body, arm_front_x, arm_front_y, sx, sy, aim_angle, skin_color, 1);
		
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, sx, sy, gun_angle, c_white, 1);
			}
		    draw_sprite_ext(sprSpraycan_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_dir,skin_color,1);
		} 
		if (in_combat) && dir=="left" {
		    // Aim + gun while walking
		    draw_sprite_ext(sprSpraycan_Arm_Idle, img_idx_body, arm_front_x, arm_front_y, -sx, -sy, aim_angle, skin_color, 1);
		
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, -sx, -sy, aim_angle, c_white, 1);
			}
		    draw_sprite_ext(sprSpraycan_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,sx,-sy,aim_angle+180,c_white,1);
		} 

		
		
		}
		


}





if (race=="odonis") {
// Draw the sprite with flipping
		//back arm
		if (state=="walk" || state=="combat") {
		//back arm
			draw_sprite_ext(sprHuman_Arm_Walk_Arms,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			// shirt
			draw_sprite_ext(sprOdonis_Arm_Shirt_Long_Walk,img_idx_shirt_sleeves+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0, c_white,1);
			
			draw_sprite_ext(sprHuman_Arm_Walk_Hand,img_idx_body+4,arm_back_x,arm_back_y,image_xscale,image_yscale,0,skin_color,1);
			//backleg
			
			draw_sprite_ext(sprHuman_Pants_Walk_Feet,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_white,1);
			
			draw_sprite_ext(sprHuman_Leg_Walk,img_idx_body,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_white,1);
			// pants
			draw_sprite_ext(sprOdonis_Pants_Walk_Pants,img_idx_pants,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_white,1);
			
		
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_white,1);
			}
		
		}
		if (state=="idle") {
			//back arm
			draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_body,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			if (shirt_style=="short") {
				//draw_sprite_ext(sprHuman_Arm_Shirt_Short_Idle,img_idx_shirt_sleeves,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			if (shirt_style=="long") {
				//draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt_sleeves,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle, shirt_color,1);
			}
			draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_shirt_sleeves,arm_back_x,arm_back_y,image_xscale,image_yscale,arm_img_angle, c_white,1);
			
			draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_back_x,fist_back_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			//backleg
			draw_sprite_ext(sprHuman_Pants_Idle_Feet,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Idle,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,skin_color,1);
			//pants
			draw_sprite_ext(sprOdonis_Pants_Idle_Pants,0,leg_back_x,leg_back_y,image_xscale,image_yscale,0,c_purple,1);

			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shoes,0,foot_back_x,foot_back_y,image_xscale,image_yscale,0,shoes_color,1);
			}
		
		}
		
		
		//body
		draw_sprite_ext(sprOdonis_Body,0,x,y,image_xscale,image_yscale,angle,c_white,1);
		//UNDERWEAR//
		if (gender="female"){
			//draw_sprite_ext(sprHuman_Body,2,pants_x,pants_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		draw_sprite_ext(sprHuman_Body,1,x,y,image_xscale,image_yscale,angle,skin_color,1);
		//pants
		if (pants_style!="none"){
			//draw_sprite_ext(sprHuman_Body,3,pants_x,pants_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		//pantsbttm
		if (shirt_style!="none"){
			//draw_sprite_ext(sprHuman_Shirt,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,angle, shirt_color,1);
		}
		//front limbs
		if (state=="walk" || state=="combat") {
			
			//front leg
			draw_sprite_ext(sprHuman_Pants_Walk_Feet,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Walk,img_idx_body+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			
			// pants
			draw_sprite_ext(sprOdonis_Pants_Walk_Pants,img_idx_pants+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,c_white,1);
			
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes+4,leg_front_x,leg_front_y,image_xscale,image_yscale,0,c_white,1);
			}
		//front arm
		if (!in_combat && !has_weapon) {
			draw_sprite_ext(sprOdonis_Arm_Shirt_Long_Walk,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,0,skin_color,1);

			draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,0, c_white,1);
			
			draw_sprite_ext(sprHuman_Arm_Walk_Hand,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,0,skin_color,1);
		} else if (!in_combat && has_weapon) {
			
			//front arm
			draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
			
				draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,0, c_white,1);
			
				draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,c_white,1);
				
				draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
				
		}
		
		
		
		}
		
		if (state=="idle") {
		//front leg
			draw_sprite_ext(sprHuman_Pants_Idle_Feet,0,foot_front_x,foot_front_y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Leg_Idle,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,skin_color,1);
			
			draw_sprite_ext(sprOdonis_Pants_Idle_Pants,0,leg_front_x,leg_front_y,image_xscale,image_yscale,0,c_white,1);
		
			if (shoes_style=="sneakers") {
				draw_sprite_ext(sprHuman_Pants_Idle_Shoes,0,foot_front_x,foot_front_y,image_xscale,image_yscale,0,c_white,1);
			}
			
		//front arm
			draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
			draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_img_angle, c_white,1);
		
			if (has_weapon==true) {
				draw_sprite_ext(sprite_gun,gun_idx,fist_front_x,fist_front_y,image_xscale,image_yscale,wpn_dir,c_white,1);
			}
				draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_img_angle,skin_color,1);
		
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
		
		draw_sprite_ext(sprOdonis_Scarf,0,head_x,head_y,image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprOdonis_Scarf,1,head_x,head_y+(60*scale),image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprOdonis_Scarf,2,head_x,head_y+(120*scale),image_xscale,image_yscale,0,c_white,1);
		
		
		draw_sprite_ext(sprOdonis_Head,img_idx_head,head_x,head_y,image_xscale,image_yscale,0,skin_color,1);
        draw_sprite_ext(sprOdonis_Head_Eyes,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
      //  draw_sprite_ext(sprHuman_Head_Eyes_Pupils,1,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,eye_color,1);
	//	draw_sprite_ext(sprHuman_Head_Eyes_Pupils,0,eyes_pupils_x,eyes_pupils_y,image_xscale,image_yscale,0,c_white,1);
	
        draw_sprite_ext(sprOdonis_Head_Hair_Back,0,hair_x,hair_y,image_xscale,image_yscale,0,c_white,1);
	
		
		switch (eyes_mood) {
			case "calm": 
			//	draw_sprite_ext(sprAlien_Head_Eyelids,0,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "panic": 
				//draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
			case "blink":
			//	draw_sprite_ext(sprAlien_Head_Eyelids,1,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
				break;
		}
		
		switch (mouth_mood) {
			case "calm": 
				draw_sprite_ext(sprHuman_Head_Mouths,0,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "sad": 
				draw_sprite_ext(sprHuman_Head_Mouths,1,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "happy": 
				draw_sprite_ext(sprHuman_Head_Mouths,2,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
			case "suprised": 
				draw_sprite_ext(sprHuman_Head_Mouths,3,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
				break;
		}
		
		//draw_sprite_ext(sprHuman_Head_Eyebrows,img_idx_eyebrows,eyebrows_x,eyebrows_y,image_xscale,image_yscale,0,hair_color,1);
    

	
	switch (hat_style) {
		case "backwards":
			//draw_sprite_ext(sprHuman_Head_Hats,0,hair_x,hair_y-(10*scale),image_xscale,image_yscale,0,hat_color,1);
			break;
		case "forwards":
			//draw_sprite_ext(sprHuman_Head_Hats,0,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "beanie":
			//draw_sprite_ext(sprHuman_Head_Hats,1,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
		case "bandana":
			//draw_sprite_ext(sprHuman_Head_Hats,2,hair_x,hair_y,image_xscale,image_yscale,0,hat_color,1);
			break;
			
	}
//hat_style=choose("none","backwards","beanie","forwards","bandana");

if (state=="walk" || state=="combat") {
			
		//front arm
			// front arm
		if (in_combat) && dir=="right" {
		    // Aim + gun while walking
		    draw_sprite_ext(sprHuman_Arm_Idle, img_idx_body, arm_front_x, arm_front_y, sx, sy, aim_angle, skin_color, 1);
		  
				draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,aim_angle, c_white,1);
			
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, sx, sy, gun_angle, c_white, 1);
			}
		    draw_sprite_ext(sprHuman_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,image_xscale,image_yscale,arm_dir,skin_color,1);
		} 
		if (in_combat) && dir=="left" {
		    // Aim + gun while walking
		    draw_sprite_ext(sprHuman_Arm_Idle, img_idx_body, arm_front_x, arm_front_y, -sx, -sy, aim_angle, skin_color, 1);
				draw_sprite_ext(sprOdonis_Arm_Idle,img_idx_shirt_sleeves,arm_front_x,arm_front_y,image_xscale,image_yscale,arm_dir, c_white,1);
			
		    if (has_weapon) {
		        draw_sprite_ext(sprite_gun, gun_idx, fist_front_x, fist_front_y, -sx, -sy, aim_angle, c_white, 1);
			}
		    draw_sprite_ext(sprSpraycan_Arm_Hand,img_idx_body,fist_front_x,fist_front_y,sx,-sy,aim_angle+180,skin_color,1);
		} 

		
		
		}
		
		
}


*/

if (has_mission)
{
	//triangle
    var cx = x;
    var cy = y - sprite_height - 10; // Above head
    var r = 12;

    var scale_y = sin(degtorad(spin_angle)); // Simulate horizontal spin
    var flatten = 0.5; // How flat the spin gets (1 = full height, 0 = flat)

    var y_scale = scale_y * flatten;

    var x1 = cx - r;
    var y1 = cy - y_scale * r;

    var x2 = cx + r;
    var y2 = cy - y_scale * r;

    var x3 = cx;
    var y3 = cy + y_scale * r;

    draw_set_color(mission_indicator_color);
    draw_triangle(x1, y1, x2, y2, x3, y3, true); // true = filled
	
	///
	/*
	if (show_msg && !global.mission_active && distance_to_object(target)<50) {
    draw_text(x, y - 32, "Press [Enter] or (A) to accept mission");
	}

	if (mission_active) {
	    draw_text(x, y - 48, "Mission Active");
	}
	*/

}


if instance_exists(oMissionManager) {
	
//mission

if (array_length(oMissionManager.active_missions) == 0) {
    

	if (distance_to_object(player_nearest)<100*scale) && (has_mission==true) {
		state = "idle";
		if (mission_active==false) {
			mission_indicator_color=c_fuchsia;
		}
		/*
		if (player_nearest.talk_button) {
			mission_active=true;
		}*/
	} else if (has_mission==true) && (distance_to_object(player_nearest)>100*scale) {
		mission_indicator_color=c_aqua;
	}
}
if (mission_active==true) {
		mission_indicator_color=c_yellow;
	}
}

/*
if (has_mission) {
	if (mission_active) {
		draw_text(x,y,"ACTIVE");
	} else {
		draw_text(x,y,"INACTIVE");
	}
}
*/



//DEBUG

//draw_text_outlined(x,y,"POI: " + string(poi),c_black,c_white);
//draw_text_outlined(x,y+15,"Weapon: " + string(weapon),c_black,c_white);
//draw_text_outlined(x,y+30,"Attacking: " + string(attacking),c_black,c_white);
/*
var _t = instance_exists(target) ? string(target.id) : "noone";
draw_text(x+12, y-48, "state:"+string(state)
    + "\nattacking:"+string(attacking)
    + "\nfire_cd:"+string(fire_cd)
    + "\ntarget:"+_t);

draw_text(x+12, y+48, "target:" + (instance_exists(target)? string(target.id) : "noone"));

*/

if instance_exists(target) {
	if (target.x > x) {dir = "right";}
	if (target.x < x) {dir = "left";}
}