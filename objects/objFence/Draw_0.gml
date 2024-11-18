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

//sidewalk
/*
draw_sprite_3d(sprSidewalk,0,x,y,300,90,0,0);
draw_sprite_3d(sprSidewalk,0,x,y,236,90,0,0);
draw_sprite_3d(sprSidewalk,0,x,y,172,90,0,0);
draw_sprite_3d(sprSidewalk,0,x,y,128,90,0,0);
draw_sprite_3d(sprSidewalk,0,x,y,64,90,0,0);
draw_sprite_3d(sprSidewalk,0,x,y,0,90,0,0);
draw_sprite_3d(sprSidewalk,0,x,y,-64,90,0,0);
*/
//draw_sprite_3d_part(sprSidewalk,0,x,y,0,0,0,0,0, 0, 8, 64,1,1,c_blue,1);

gpu_set_zwriteenable(true);
 gpu_set_ztestenable(true);

//SIDES

draw_sprite_3d_part(sprSidewalk,0,x,y,300,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x+8,y,300,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,236,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x+8,y,236,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,172,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x+8,y,172,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,128,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x+8,y,128,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,64,0,90,0,0, 0, 64, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x+8,y,64,0,90,0,0, 0, 64, 64,1,1,c_blue,1);


//TOP
draw_sprite_3d_part(sprSidewalk,0,x,y,364,90,0,0,0, 0, 8, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,300,90,0,0,0, 0, 8, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,236,90,0,0,0, 0, 8, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,172,90,0,0,0, 0, 8, 64,1,1,c_blue,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,128,90,0,0,0, 0, 8, 64,1,1,c_blue,1);
//FRONT
draw_sprite_3d_part(sprSidewalk,0,x,y,64,0,0,0,0, 0, 8, 64,1,1,c_blue,1);
//draw_sprite_3d_part(sprite, index, xx, yy, zz, rotx, roty, rotz, top, left, width, height,xscale,yscale,col,alpha)

gpu_set_zwriteenable(false);
 gpu_set_ztestenable(false);