/// @description Insert description here
// You can write your code in this editor


if (room=rm_Infinite_beach) {
	global.kill_count += 1;
global.difficulty += 1;
objControl_Infinite.enemies_remaining -= 1;
}

if (room=r_level_infinite) {
	global.kill_count += 1;
global.difficulty += 1;
//objLevel_infinite.enemies_remaining -= 1;
}

// inside obj_enemy_robot just before destroying:
if (instance_exists(objControl_mv)) {
    with (objControl_mv) kill_counter += 1;
}
// (enemy_count_robot auto-syncs via instance_number() in the director)
//instance_destroy();
