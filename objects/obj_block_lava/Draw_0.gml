/// @description Insert description here
// You can write your code in this editor
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);


		
		draw_sprite_3d_matrix(sprSidewalk, 0, x, y, -64, 0, 0, 0);
		
	for (var i = 0; i < 2; i++) {
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, i * 64, 90, 0, 0);
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y+64, i * 64, 90, 0, 0);
		draw_sprite_3d_matrix(sprSidewalk, 0, x, y,(i * 64)-64, 0, 90, 0);
		draw_sprite_3d_matrix(sprSidewalk, 0, x+64, y, (i * 64)-64, 0, 90, 0);
	}
     
        
		


gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);