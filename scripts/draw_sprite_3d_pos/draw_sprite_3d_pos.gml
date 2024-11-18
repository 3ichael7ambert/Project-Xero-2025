// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//yeah, but you don't need 3d models to do it, you can draw 5 walls, one for each face the camera can see... 

function draw_sprite_3d_pos_matrix(sprite, index, xx, yy, zz, rotx, roty, rotz,x1,y1,x2,y2,x3,y3,x4,y4) {
    depth = 0;
    var matrix_translate = matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1);
    var matrix_rotate = matrix_build(0, 0, 0, rotx, roty, rotz, 1, 1, 1);
    var matrix_scale = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);

    var matrix_rs = matrix_multiply(matrix_scale, matrix_rotate);
    var matrix_final = matrix_multiply(matrix_rs, matrix_translate);

    matrix_set(matrix_world, matrix_final);

    // Draw part of the sprite
    draw_sprite_pos(sprite, index, x1,y1,x2,y2,x3,y3,x4,y4,1);

    matrix_set(matrix_world, matrix_build_identity());
}


function draw_sprite_3d_pos(sprite, index, draw_matrix, x1, y1, x2, y2, x3, y3, x4, y4) {
    depth = 0;

    matrix_set(matrix_world, draw_matrix);

    // Draw part of the sprite
    draw_sprite_pos(sprite, index, x1,y1,x2,y2,x3,y3,x4,y4,1);

   // matrix_set(matrix_world, matrix_build_identity());
}