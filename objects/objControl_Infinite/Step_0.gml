/// @description Insert description here
// You can write your code in this editor





// Check if all enemies are dead
if (enemies_remaining <= 0) {
    wave_timer--;
    
    if (wave_timer <= 0) {
        global.wave += 1;
        wave_timer = 120; // reset timer
        spawn_wave(global.wave,obj_Enemy_Robot);
    }
}

// Optional: Display UI
draw_text(32, 32, "Wave: " + string(global.wave));
draw_text(32, 64, "Kills: " + string(global.kill_count));



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