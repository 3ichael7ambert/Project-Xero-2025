/// @description Insert description here
// You can write your code in this editor

// Infinite Room


if instance_exists(obj_Player1){
x=obj_Player1.x;
y=obj_Player1.y;

with (obj_Player1) {
	if (y<500) {
		y-=vsp;
	}
}

}
infinitydog_wrap_room();
