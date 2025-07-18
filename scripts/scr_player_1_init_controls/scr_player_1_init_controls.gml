function scr_player_1_init_controls(gamepad_num){
//BUTTONS
if (gamepad_is_connected(gamepad_num)) && (gamepad==true) {
    // Gamepad is plugged in, set controls to gamepad
    // Use analog stick axis for movement
     axislh_value = gamepad_axis_value(gamepad_num, gp_axislh);
     axislv_value = gamepad_axis_value(gamepad_num, gp_axislv);
     shoot_button = gamepad_button_check(gamepad_num, gp_face1);
     melee_button = gamepad_button_check_pressed(gamepad_num, gp_face2);
     change_weapon_button = gamepad_button_check_pressed(gamepad_num, gp_shoulderlb);
     pause_button = gamepad_button_check_pressed(gamepad_num, gp_start);
	 
	 shoot_button_pressed = gamepad_button_check_pressed(gamepad_num, gp_face1);
	 shoot_button_released = gamepad_button_check_pressed(gamepad_num, gp_face1);
	 wpn_chg_up = gamepad_button_check_pressed(gamepad_num, gp_face3);
	 wpn_chg_down = gamepad_button_check_pressed(gamepad_num, gp_face4);
     pause_button = keyboard_check_pressed(vk_escape);

    move_left = axislh_value < -0.5;
    move_right = axislh_value > 0.5;
    move_up = axislv_value > 0.5;
    move_down = axislv_value < -0.5;

    if (axislh_value != 0 || axislv_value != 0) {
        direction = point_direction(0, 0, axislh_value, -axislv_value);
    }
}
else if (gamepad==false) {
    // Gamepad is not plugged in, set controls to keyboard
    // Use arrow keys for movement
    move_left = keyboard_check(vk_left);
    move_right = keyboard_check(vk_right);
    move_up = keyboard_check(vk_up);
    move_down = keyboard_check(vk_down);
    
     shoot_button = keyboard_check(ord("A"));
	 shoot_button_pressed = keyboard_check_pressed(ord("A"));
	 shoot_button_released = keyboard_check_released(ord("A"));
     melee_button = keyboard_check_pressed(ord("S"));
	 wpn_chg_up = keyboard_check_pressed(ord("C"));
	 wpn_chg_down = keyboard_check_pressed(ord("X"));
     change_weapon_button = keyboard_check_pressed(ord("V"));
     pause_button = keyboard_check_pressed(vk_escape);
} else {
	
	//global.players_array = array_delete(global.players_array, self_id, 1);
	//instance_destroy();
}
}