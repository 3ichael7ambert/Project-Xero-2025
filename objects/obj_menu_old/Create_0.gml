
// VARS
game_transition(-1,0,0,0);
Menu_Screen = "main";
pause_menu_VolumeSlider_move[0] = false;
pause_menu_VolumeSlider_move[1] = false;
bt_i = array_create(3);


// MUSIC
audio_stop_all();
audio_play_sound(snd_menu,100,true);