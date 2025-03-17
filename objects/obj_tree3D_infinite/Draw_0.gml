/// @description Insert description here
// You can write your code in this editor
gpu_set_zwriteenable(true);
//gpu_set_ztestenable(true);

//backleaves

		draw_sprite_3d_part(sprite, 3, x*scale, y-(y_origin*6*scale), z-32*scale, -90, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 3, x*scale, y-32-(y_origin*6*scale)*scale, z-32*scale, -45, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //down back 45
		draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z-32*scale, -135, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //up back  45
		
//trunk
        draw_sprite_3d_part(sprite, 1, x*scale, y-(y_origin*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 2, x*scale, y-(y_origin*2*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 1, x*scale, y-(y_origin*3*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 2, x*scale, y-(y_origin*4*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 1, x*scale, y-(y_origin*5*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 0, x*scale, y-(y_origin*6*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
//front leaves
		draw_sprite_3d_part(sprite, 3, x*scale, y-(y_origin*6*scale)*scale, z+64, 90, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 3, x*scale, y-(y_origin*6*scale)*scale, z, 0, 90, 90,0,0,sw,sh,scale,scale,c_white,1); //riightside flat
		draw_sprite_3d_part(sprite, 3, x+64*scale, y-(y_origin*6*scale)*scale, z, 0, 90, -90,0,0,sw,sh,scale,scale,c_white,1);//leftside flat
		
		
		draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z, 0, 0, 90,0,0,sw,sh,scale,scale,c_white,1); //riightside 
		draw_sprite_3d_part(sprite, 3, x+64*scale, y-32-(y_origin*6*scale)*scale, z, 0, 0, -90,0,0,sw,sh,scale,scale,c_white,1);//leftside 
		
		draw_sprite_3d_part(sprite, 3, x*scale, y-32-(y_origin*6*scale)*scale, z+32, 45, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //down 45
		draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z+32, 135, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //up 45
		
		
		
		
		
		//draw_sprite_3d_part(sprite, 3, x*scale, y-32-(y_origin*6*scale)*scale, z+32, 45, 90, 0,0,0,sw,sh,scale,scale,c_white,1); //down 45 90right
		//draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z+32, 135, 90, 0,0,0,sw,sh,scale,scale,c_white,1); //up 45 90right
		
		
		/*
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 90,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -90,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 65,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -65,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 125,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -125,0,0,sw,sh,scale,scale,c_white,1);
		*/
		
        

		
		

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);