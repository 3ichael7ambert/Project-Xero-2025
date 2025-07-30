/// @description Insert description here
// You can write your code in this editor
// Draw Event
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
		draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,x,y,image_xscale,image_yscale,0,skin_color,1);
		 draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,0, shirt_color,1);
		//backleg
		draw_sprite_ext(sprHuman_Leg_Idle,img_idx_body,x,y,image_xscale,image_yscale,0,skin_color,1);
		draw_sprite_ext(sprHuman_Pants_Walk_Pants,img_idx_pants,pants_x,pants_y,image_xscale,image_yscale,0,pants_color,1);
		draw_sprite_ext(sprHuman_Shoes,img_idx_shoes,shoes_x,shoes_y,image_xscale,image_yscale,0,shoes_color,1);
	
		//body
		draw_sprite_ext(sprHuman_Body,0,x,y,image_xscale,image_yscale,0,skin_color,1);
		//UNDERWEAR//
		draw_sprite_ext(sprHuman_Body,1,x,y,image_xscale,image_yscale,0,skin_color,1);
		draw_sprite_ext(sprHuman_Shirt,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,0, shirt_color,1);
		//pantsbttm
		//draw_sprite_ext(sprHuman_Shirt,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,0, shirt_color,1);
		//front leg
		if (state == "idle") {
			draw_sprite_ext(sprHuman_Leg_Idle,0,x,y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Pants_Idle_Pants,0,pants_x,pants_y,image_xscale,image_yscale,0,pants_color,1);
			draw_sprite_ext(sprHuman_Pants_Idle_Shoes,0,shoes_x,shoes_y,image_xscale,image_yscale,0,shoes_color,1);
		}
		//front leg
		if (state == "walk") {
			draw_sprite_ext(sprHuman_Leg_,img_idx_body,x,y,image_xscale,image_yscale,0,skin_color,1);
			draw_sprite_ext(sprHuman_Pants_Walk_Pants,img_idx_pants,pants_x,pants_y,image_xscale,image_yscale,0,pants_color,1);
			draw_sprite_ext(sprHuman_Pants_Walk_Shoes,img_idx_shoes,shoes_x,shoes_y,image_xscale,image_yscale,0,shoes_color,1);
		}
		//front arm
		draw_sprite_ext(sprHuman_Arm_Idle,img_idx_body,x,y,image_xscale,image_yscale,0,skin_color,1); 
		 draw_sprite_ext(sprHuman_Arm_Shirt_Long_Idle,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,0, shirt_color,1);
		
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
		draw_sprite_ext(sprHuman_Head,img_idx_head,head_x,head_y,image_xscale,image_yscale,0,skin_color,1);
        draw_sprite_ext(sprHuman_Head_Eyes,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyes_Pupils,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,skin_color,1);
		 draw_sprite_ext(sprHuman_Head_Mouths,img_idx_mouth,mouth_x,mouth_y,image_xscale,image_yscale,0,hair_color,1);
		draw_sprite_ext(sprHuman_Head_Eyebrows,img_idx_eyebrows,eyebrows_x,eyebrows_y,image_xscale,image_yscale,0,hair_color,1);
       draw_sprite_ext(sprHuman_Head_Hair_Back,img_idx_hair,hair_x,hair_y,image_xscale,image_yscale,0,hair_color,1);
       
