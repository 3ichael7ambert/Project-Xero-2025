/// @description Insert description here
// You can write your code in this editor
if level=18 || level=19 {
half_wview = __view_get( e__VW.WView, 0 )/2;
half_hview = __view_get( e__VW.HView, 0 )/2;
}


with (target) {
//if y<0 {y=0;
//if y>room_height y=room_height;
if y<100 {
	gravity_direction=270;
	gravity=2;
}
else if (y>room_height-100) {
	gravity_direction=90;
	gravity=2;
}
else {
	gravity_direction=270;
	gravity=.3;
	}
}















