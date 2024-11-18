// end the game
if keyboard_check_pressed(vk_escape)
{
	game_end();
}

if (global.input_key_x_pressed)
{
	bt_i[0] = 0;
	game_transition(room_level_1,1,2,1);
}