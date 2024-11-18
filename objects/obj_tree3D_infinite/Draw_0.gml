/// @description Insert description here
// You can write your code in this editor
gpu_set_zwriteenable(true);
//gpu_set_ztestenable(true);


        draw_sprite_3d_part(sprite, 1, x, y-(y_origin*scale), z, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 2, x, y-(y_origin*2*scale), z, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 1, x, y-(y_origin*3*scale), z, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 2, x, y-(y_origin*4*scale), z, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 1, x, y-(y_origin*5*scale), z, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 0, x, y-(y_origin*6*scale), z, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
		
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*6*scale), z+64, 90, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 90,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -90,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 65,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -65,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 125,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -125,0,0,sw,sh,scale,scale,c_white,1);
		
		
        

		
		

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);