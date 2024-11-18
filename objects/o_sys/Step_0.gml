if keyboard_check_pressed(vk_escape) game_end();
if keyboard_check_pressed(vk_f5) game_restart();
if keyboard_check_pressed(vk_f1) showTips = !showTips;
if keyboard_check_pressed(vk_enter) {
	if room_next(room) != -1 {
	room_goto_next();
	} else {room_goto_previous()};
};
if keyboard_check_pressed(ord("E")) {
	//ragdoll_define_size(1,5,5,5,5,5,5,5,5,5,5,5);
	//ragdoll_spawn(mouse_x,mouse_y,0,0); 
	ragdoll_spawn(mouse_x,mouse_y,0,0); 
};

if keyboard_check_pressed(ord("Q")) instance_create_depth(mouse_x,mouse_y,0,o_crate);

if keyboard_check_pressed(vk_alt) {
	global.debugMode = !global.debugMode;
	show_debug_overlay(global.debugMode);
};
if keyboard_check_pressed(vk_space) {
	global.pause = !global.pause;
	physics_pause_enable(global.pause);
};
