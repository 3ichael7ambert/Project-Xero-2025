/// @description  SET UP VARIABLES

event_inherited();

fenceMatrix = build_drawing_matrix(x,y-64,300,0,0,0);

swMatrix1 = build_drawing_matrix(x,y,300,90,0,0);
swMatrix2 = build_drawing_matrix(x,y,236,90,0,0);
swMatrix3 = build_drawing_matrix(x,y,172,90,0,0);
swMatrix4 = build_drawing_matrix(x,y,128,90,0,0);
swMatrix5 = build_drawing_matrix(x,y,64,90,0,0);
swMatrix6 = build_drawing_matrix(x,y,0,90,0,0);
swMatrix7 = build_drawing_matrix(x,y,-64,90,0,0);

swMatrixCurb = build_drawing_matrix(x,y,-128,0,0,0);
swMatrixStreet = build_drawing_matrix(x,y+8,-128,90,0,0);

transform_selections = [
	fenceMatrix,swMatrix1,swMatrix2,swMatrix3,swMatrix4,swMatrix5,swMatrix6,swMatrix7,swMatrixCurb,swMatrixStreet
];

transform_index = array_create(10, 0);
transform_index[0] = 6;

// draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);
position_update = array_create(10, -1);
position_update[8] = [0,0,64,0,64,8,0,8];