/// @description Insert description here
// You can write your code in this editor
//x=device_mouse_x(0);
//y=device_mouse_y(0);
//move_towards_point(device_mouse_x,device_mouse_y,100);


if (device_mouse_raw_x(0)<view_get_wport(0)/2) {
x-=10;
}
if (device_mouse_raw_x(0)>view_get_wport(0)/2) {
x+=10;
}
if (device_mouse_raw_y(0)<view_get_hport(0)/2) {
y-=10;
}
if (device_mouse_raw_y(0)>view_get_hport(0)/2) {
y+=10;
}
