/// @description Insert description here
// You can write your code in this editor

/*
if room=rm_City
{
	//infinitydog_wrap_room();
}
*/



/*
if instance_exists(obj_car)
{
	physics_pause_enable(false);
}
else
{
	physics_pause_enable(true);
}
*/

if (instance_exists(obj_Player1)) {
	target=obj_Player1;
} else {
	target = noone;
}



if !instance_exists(enemy_object) {
  wave_timer--;
}  


if (instance_exists(obj_Player1)) {
	scale=obj_Player1.scale;
}

if  (wave_timer==0) && (instance_number(enemy_object)<=0) {
      global.wave += 1;
        wave_timer = 90;

       spawn_wave(global.wave, enemy_object,1,,3,scale);


    }
	
	
	
if level=8
{

ocean_frame+=1;
if ocean_frame>15 {ocean_frame=0};
}
