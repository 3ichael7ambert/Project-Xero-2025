var rotation_speed = 5; // Adjust the rotation speed as needed
var easing_factor = 0.1; // Adjust the easing factor for smoother transitions

if (keyboard_check_pressed(vk_left)) {
    selected_item = (selected_item - 1 + array_number) % array_number;
    target_rot = 360 * selected_item / array_number;
}

if (keyboard_check_pressed(vk_right)) {
    selected_item = (selected_item + 1) % array_number;
    target_rot = 360 * selected_item / array_number;
}

// Smoothly interpolate the rotation towards the target rotation
rot = lerp(rot, target_rot, easing_factor);

menu_x = (room_width/2) -  (string_width(menu_items[selected_item])/2);
menu_y=room_height-(room_height/5);

menu2_x = (room_width/2);
menu2_y=room_height/3-(menu2_height/2);

armB_dir=-75-body_angle;
armF_dir=-75+body_angle;

body_angle=0+rot;

if keyboard_check(vk_enter){
	switch (selected_item) {
		case 0: // Cityscape
			room_goto(rmCity); 
			break;
		case 1: // Asteroid Belt
			room_goto(rm_Infinite); 
			break;
		case 2: // Survival
			room_goto(rm_space); 
			break;
		case 3: // Invasion
			room_goto(rm_Infinite); 
			break;
		case 4: // Zero Gravity
			room_goto(rm360); 
			break;
		case 5: // Streetbike
			room_goto(rm_Neonx1080_bike); 
			break;
		case 6: // Beach
			room_goto(rm_Infinite); 
			break;
		case 7: // Forest
			room_goto(rm_Infinite); 
			break;
		case 8: // Boss
			room_goto(rm_boss); 
			break;
		case 10: // Lava Run
			room_goto(rm_lava); 
			break;
		case 11: // Lava Run
			game_end();
			break;
		
	}
}