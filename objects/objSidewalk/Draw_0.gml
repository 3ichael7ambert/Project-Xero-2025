/// @description  DRAW THE BOTTOM AND THE SIDES IN THE DRAW EVENT
//  SO THAT THEY WILL NOT COVER THE TOP OF OTHER CUBES
/*
//draw_self();

// LEFT
//draw_sprite_pos(sprSidewalk,0,x,y,x-hdepth,y-vdepth,x-hdepth,y-64-vdepth,x,y-64,1);

// RIGHT
//draw_sprite_pos(sprSidewalk,0,x+64,y,x+64-hdepth,y-vdepth,x+64-hdepth,y+64-vdepth,x+64,y+64,1);

// TOP
//draw_sprite_pos(sprSidewalk,0,x-hdepth,y,x+64-hdepth,y,x+64,y-64,x,y-64,1);
draw_sprite_pos(sprSidewalk,0,x-hdepth/2,y,x+64-hdepth/2,y,x+64+hdepth,y-64,x+hdepth,y-64,1);
draw_sprite_pos(sprSidewalk,0,x+64-hdepth,y+64,x-hdepth,y+64,x-hdepth/2,y,x+64-hdepth/2,y,1);


// TOP
//draw_sprite_pos(sprSidewalk,0,x-hdepth,y-vdepth,x+64-hdepth,y-vdepth,x+64,y,x,y,1);

// BOTTOM
//draw_sprite_pos(sprSidewalk,0,x-hdepth,y+64-vdepth,x+64-hdepth,y+64-vdepth,x+64,y+64,x,y+64,1);

// BOTTOM
draw_sprite_pos(sprSidewalk,0,x-hdepth,y+64,x+64-hdepth,y+64,x+64,y+72,x,y+72,1);

*/
//fence

gpu_set_zwriteenable(true);
 gpu_set_ztestenable(true);
 
 
draw_sprite_3d(sprSidewalk,0,fenceMatrix);
//sidewalk
draw_sprite_3d(sprSidewalk,0,swMatrix1);
draw_sprite_3d(sprSidewalk,0,swMatrix2);
draw_sprite_3d(sprSidewalk,0,swMatrix3);
draw_sprite_3d(sprSidewalk,0,swMatrix4);
draw_sprite_3d(sprSidewalk,0,swMatrix5);
draw_sprite_3d(sprSidewalk,0,swMatrix6);
draw_sprite_3d(sprSidewalk,0,swMatrix7);

//street
draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);
draw_sprite_3d(sprSidewalk,0,swMatrixStreet);


gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);

matrix_set(matrix_world, matrix_build_identity());