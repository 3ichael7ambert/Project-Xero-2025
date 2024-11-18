/// @description Insert description here
// You can write your code in this editor
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

		draw_sprite_3d_matrix(sprite, 0, x, y, -64, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, -128, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, -192, -90, 0, 0);
        draw_sprite_3d_matrix(sprite, 0, x, y, 0, -90, 0, 0);
        
        draw_sprite_3d_matrix(sprite, 0, x, y, 64, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, 128, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, 192, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, 192, 90, 0, 0);
		
		
		draw_sprite_3d_matrix(spriteBG, 0, x, y, 256, 0, 0, 0);
		
		

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);