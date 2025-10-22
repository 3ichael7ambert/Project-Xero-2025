/// @description Move with view
/*
var x_diff = __view_get( e__VW.XView, 0 )-previous_xview;
var y_diff = __view_get( e__VW.YView, 0 )-previous_yview;
x += x_diff*x_follow+x_speed;
y += y_diff*y_follow+y_speed;
previous_xview = __view_get( e__VW.XView, 0 );
previous_yview = __view_get( e__VW.YView, 0 );
*/


//x = global.CameraManager.x;
//y = global.CameraManager.y;


var x_diff = global.CameraManager.x-previous_xview;
var y_diff = global.CameraManager.y-previous_yview;
x += x_diff*x_follow+x_speed;
y += y_diff*y_follow+y_speed;
previous_xview =global.CameraManager.x;
previous_yview = global.CameraManager.y;