/// @description Insert description here
// You can write your code in this editor
x=device_mouse_x;
y=device_mouse_y;

buffer = 20;
top_edge = camera_get_view_y(view_camera[0]);
left_edge = camera_get_view_x(view_camera[0]);
left_edge_max = left_edge + buffer;

