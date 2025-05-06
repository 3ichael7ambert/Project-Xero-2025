// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function world_to_screen(_x, _y, _z) {
    var pos = matrix_transform_vertex(_projMat, matrix_transform_vertex(_viewMat, _x, _y, _z));
    return [ (pos[0] * 0.5 + 0.5) * display_get_gui_width(),
             (1 - (pos[1] * 0.5 + 0.5)) * display_get_gui_height() ]; // flip Y
}
