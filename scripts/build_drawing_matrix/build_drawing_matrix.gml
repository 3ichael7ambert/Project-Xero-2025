// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function build_drawing_matrix(xx, yy, zz, rotx, roty, rotz){
	var matrix_translate = matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1);
    var matrix_rotate = matrix_build(0, 0, 0, rotx, roty, rotz, 1, 1, 1);
    var matrix_scale = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);

    var matrix_rs = matrix_multiply(matrix_scale, matrix_rotate);
    var matrix_final = matrix_multiply(matrix_rs, matrix_translate);
	return matrix_final;
}

function build_drawing_matrix_scale(xx, yy, zz, rotx, roty, rotz,xscale,yscale,zscale){
	var matrix_translate = matrix_build(xx, yy, zz, 0, 0, 0, 1, 1, 1);
    var matrix_rotate = matrix_build(0, 0, 0, rotx, roty, rotz, 1, 1, 1);
    var matrix_scale = matrix_build(0, 0, 0, 0, 0, 0, xscale,yscale,zscale);

    var matrix_rs = matrix_multiply(matrix_scale, matrix_rotate);
    var matrix_final = matrix_multiply(matrix_rs, matrix_translate);
	return matrix_final;
}