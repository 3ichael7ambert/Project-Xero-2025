function scr_player_1_init_controls(player){
//BUTTONS
if gamepad_is_connected(player-1) {
    // Gamepad is plugged in, set controls to gamepad
    // Use analog stick axis for movement
     axislh_value = gamepad_axis_value(0, gp_axislh);
     axislv_value = gamepad_axis_value(0, gp_axislv);
     shoot_button = gamepad_button_check_pressed(0, gp_face1);
     melee_button = gamepad_button_check_pressed(0, gp_face2);
     change_weapon_button = gamepad_button_check_pressed(0, gp_shoulderl);
     pause_button = gamepad_button_check_pressed(0, gp_start);

    move_left = axislh_value < -0.5;
    move_right = axislh_value > 0.5;
    move_up = axislv_value > 0.5;
    move_down = axislv_value < -0.5;

    if (axislh_value != 0 || axislv_value != 0) {
        direction = point_direction(0, 0, axislh_value, -axislv_value);
    }
}
else {
    // Gamepad is not plugged in, set controls to keyboard
    // Use arrow keys for movement
	if (player==1) {
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
	}
	
	if (player==2) {
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
	}
	
	if (player==3) {
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
	}
	
	if (player==4) {
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
	}
}

}