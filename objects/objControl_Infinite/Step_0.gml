/// @description Insert description here
// You can write your code in this editor





// Check if all enemies are dead
//if (enemies_remaining <= 0)  {	
// Wait for all enemies to be defeated
if !instance_exists(enemy_object) {
  wave_timer--;
}  


if (instance_exists(obj_Player1)) {
	scale=obj_Player1.scale;
}

if  (wave_timer==0) && (instance_number(enemy_object)<=0) {
      global.wave += 1;
        wave_timer = 90;
       //spawn_wave(global.wave, enemy_object);
       spawn_wave(global.wave, enemy_object,1,,,scale);
	//instance_create(x,y,enemy_object);

    }




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


/*
if instance_exists(obj_Enemy_Robot){
		a=instance_create(x,y,obj_Enemy_Robot);
		a.jetpack_mode=choose(1,2,3);
		a.weapon=irandom_range(0,12);
}*/