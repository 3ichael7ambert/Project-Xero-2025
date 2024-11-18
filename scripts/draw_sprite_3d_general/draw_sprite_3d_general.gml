// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//yeah, but you don't need 3d models to do it, you can draw 5 walls, one for each face the camera can see... 
/*
function draw_sprite_3d_pafrt(sprite, index, xx, yy, zz, rotx, roty, rotz, top, left, width, height,xscale,yscale,rot,c1,c2,c3,c4,alpha) {
    depth = 0;
    var matrix_translate = matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1);
    var matrix_rotate = matrix_build(0, 0, 0, rotx, roty, rotz, 1, 1, 1);
    var matrix_scale = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);

    var matrix_rs = matrix_multiply(matrix_scale, matrix_rotate);
    var matrix_final = matrix_multiply(matrix_rs, matrix_translate);

    matrix_set(matrix_world, matrix_final);

    // Draw part of the sprite
    draw_sprite_general(sprite, index, left, top, width, height,0,0,xscale,yscale,rot, c1,c2,c3,c4, alpha);

    matrix_set(matrix_world, matrix_build_identity());
}
*/