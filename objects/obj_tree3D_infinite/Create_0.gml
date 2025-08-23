/// @description Insert description here
// You can write your code in this editor

randomize();


z=irandom_range(-192,256);
scale=1;

sprite=sprPalmTree;

sw=sprite_get_width(sprite);
sh=sprite_get_height(sprite);

x_origin = sprite_get_xoffset(sprite);
y_origin = sprite_get_yoffset(sprite);



/// @description Insert description here
// You can write your code in this editor



////


/// @description  SET UP VARIABLES

event_inherited();

trunk = build_drawing_matrix_scale(x,y,z,15,0,0,1,1,1);
trunkL = build_drawing_matrix_scale(x+56,y,z+24,15,45,0,1,1,1);
trunkR = build_drawing_matrix_scale(x-56,y,z+24,15,-45,0,1,1,1);

swMatrix3 = build_drawing_matrix(x,y-128,z,0,0,0);
swMatrix4 = build_drawing_matrix(x,y-128,z,0,45,0);
swMatrix5 = build_drawing_matrix(x,y-128,z+128,0,-45,0);
swMatrix6 = build_drawing_matrix(x,y-128,z,0,0,0);

swMatrix7 = build_drawing_matrix(x,y-128,z,0,0,0);

//swMatrixCurb = build_drawing_matrix(x,y,-128,0,0,0);
//swMatrixCurb = build_drawing_matrix_scale(x-32,y,-96,0,0,0,1,1,1);

//draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);

swMatrixStreet = build_drawing_matrix(x,y,-128,90,0,0);

transform_selections = [
	trunk,trunkL,trunkR,swMatrix3,swMatrix4,swMatrix5,swMatrix6,swMatrix7,/*swMatrixCurb,*/swMatrixStreet
];

transform_index = array_create(10, 0);
/*transform_index[0] = 6; //fence
transform_index[0] = 0; //curb
transform_index[9] = 12; //steet
*/

// draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);
position_update = array_create(10, -1);
position_update[8] = [0,0,0,0,0,8,0,0];








