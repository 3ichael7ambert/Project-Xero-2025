/// @description Insert description here
// You can write your code in this editor
// Draw Event
switch (state) {
    case "idle":
        sprite_index = sprHuman_Body;
		draw_sprite_ext(sprHuman_Body,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprHuman_Pants,image_index,x,y,image_xscale,image_yscale,0,c_white,1);draw_sprite_ext(sprHuman_Body,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Shirt,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprHuman_Shoes,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
		draw_sprite_ext(sprHuman_Head,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyes,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyelids,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
       draw_sprite_ext(sprHuman_Head_Nose,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
        draw_sprite_ext(sprHuman_Head_Eyebrows,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
       draw_sprite_ext(sprHuman_Head_Hair,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
       draw_sprite_ext(sprHuman_Head_Mouths,0,x,y,image_xscale,image_yscale,0,c_white,1);
       
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
draw_self();
