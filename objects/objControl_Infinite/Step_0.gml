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



if instance_exists(obj_Enemy_Robot){
		a=instance_create(x,y,obj_Enemy_Robot);
		a.jetpack_mode=choose(1,2,3);
		a.weapon=irandom_range(0,12);
}