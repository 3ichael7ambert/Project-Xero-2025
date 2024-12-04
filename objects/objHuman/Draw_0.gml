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
		draw_sprite_ext(sprHuman_Body,img_idx_body,x,y,image_xscale,image_yscale,0,c_white,1);
		
		draw_sprite_ext(sprHuman_Pants,img_idx_pants,pants_x,pants_y,image_xscale,image_yscale,0,c_white,1);draw_sprite_ext(sprHuman_Body,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Shirt,img_idx_shirt,shirt_x,shirt_y,image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprHuman_Shoes,img_idx_shoes,shoes_x,shoes_y,image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprHuman_Head,img_idx_head,head_x,head_y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyes,img_idx_eyes,eyes_x,eyes_y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyelids,img_idx_eyelids,eyelids_x,eyelids_y,image_xscale,image_yscale,0,c_white,1);
       draw_sprite_ext(sprHuman_Head_Nose,img_idx_nose,nose_x,nose_y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyebrows,img_idx_eyebrows,eyebrows_x,eyebrows_y,image_xscale,image_yscale,0,c_white,1);
       draw_sprite_ext(sprHuman_Head_Hair,img_idx_hair,hair_x,hair_y,image_xscale,image_yscale,0,c_white,1);
       draw_sprite_ext(sprHuman_Head_Mouths,img_idx_mouth,mouth_x,mouth_y,image_xscale,image_yscale,0,c_white,1);
       
