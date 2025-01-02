/// @description Insert description here
// You can write your code in this editor
//x=device_mouse_raw_x(0);
//y=device_mouse_raw_y(0);
depth=-1000;
parent=self;
weapon=9;

buffer = 20;
top_edge = camera_get_view_y(view_camera[0]);
left_edge = camera_get_view_x(view_camera[0]);
left_edge_max = left_edge + buffer;

