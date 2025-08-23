/// @description Insert description here
// You can write your code in this editor





sprite=sprSand;
spriteBG=sprMtnDist;

/*
		draw_sprite_3d_matrix(sprite, 0, x, y, -64, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, -128, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, -192, -90, 0, 0);
        draw_sprite_3d_matrix(sprite, 0, x, y, 0, -90, 0, 0);
        
        draw_sprite_3d_matrix(sprite, 0, x, y, 64, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, 128, -90, 0, 0);
		draw_sprite_3d_matrix(sprite, 0, x, y, 192, -90, 0, 0);
		
		*/
		


/// @description  SET UP VARIABLES

event_inherited();

fenceMatrix = build_drawing_matrix_scale(x, y, 256,0,0,0,1,1,1); ///

swMatrix1 = build_drawing_matrix(x, y, 192,90,0,0); ///
swMatrix2 = build_drawing_matrix(x,y,236,90,0,0);
swMatrix3 = build_drawing_matrix(x,y,172,90,0,0);
swMatrix4 = build_drawing_matrix(x,y,128,90,0,0);
swMatrix5 = build_drawing_matrix(x,y,64,90,0,0);
swMatrix6 = build_drawing_matrix(x,y,0,90,0,0);
swMatrix7 = build_drawing_matrix(x,y,-64,90,0,0);
swMatrix8 = build_drawing_matrix(x,y,-128,90,0,0);
swMatrix9 = build_drawing_matrix(x,y,-192,90,0,0);

//swMatrixCurb = build_drawing_matrix(x,y,-128,0,0,0);
//swMatrixCurb = build_drawing_matrix_scale(x-32,y,-96,0,0,0,1,1,1);

//draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);

swMatrixStreet = build_drawing_matrix(x,y,-128,90,0,0);

transform_selections = [
	fenceMatrix,swMatrix1,swMatrix2,swMatrix3,swMatrix4,swMatrix5,swMatrix6,swMatrix7,/*swMatrix8,swMatrix9,*//*swMatrixCurb,*/swMatrixStreet
];

transform_index = array_create(10, 0);
transform_index[0] = 6; //fence
transform_index[8] = 0; //curb
transform_index[9] = 12; //steet

// draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);
position_update = array_create(9, -1);
position_update[8] = [0,0,64,0,64,8,0,8];