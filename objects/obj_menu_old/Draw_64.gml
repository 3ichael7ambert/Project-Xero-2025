
// BACKGROUND
draw_sprite_stretched_ext(spr_any_pixel,0,0,0,gui_w(),gui_h(),make_color_hsv(224,121,25),1);


// MENU
draw_sprite_ext(spr_menu_logo,0,gui_w()/2,70,1,1,0,c_white,1);


// SCREENS
switch (Menu_Screen)
{
    case "main":
	#region SCREEN >> MAIN
        
		// button start
		var _xx = gui_w()/2;
		var _yy = 165;
		draw_sprite_ext(spr_menu_bt_start,bt_i[0],_xx,_yy,1,1,0,c_white,1);
		if point_in_rectangle(gui_mouse_x(),gui_mouse_y(),_xx-64,_yy-22, _xx+64,_yy+22)
		{
			if mouse_check_button(mb_left)
			{
				bt_i[0] = 1;
			}
			if mouse_check_button_released(mb_left)
			{
				bt_i[0] = 0;
				game_transition(room_level_1,1,2,1);
			}
		}
		else
		{
			bt_i[0] = 0;
		}
		
		
		
		
		
		// button settings [for volume screen]
		var _xx = gui_w()/2;
		var _yy = 215;
		draw_sprite_ext(spr_menu_bt_control,bt_i[1],_xx,_yy,1,1,0,c_white,1);
		if point_in_rectangle(gui_mouse_x(),gui_mouse_y(),_xx-64,_yy-22, _xx+64,_yy+22)
		{
			if mouse_check_button(mb_left)
			{
				bt_i[1] = 1;
			}
			if mouse_check_button_released(mb_left)
			{
				bt_i[1] = 0;
				Menu_Screen = "control";
			}
		}
		else
		{
			bt_i[1] = 0;
		}
		#endregion
        break;
		
		
	case "control":
    #region SCREEN >> CONTROL
		
		// music slider [0]
		var _slw = sprite_get_width(spr_hud_menu_slider_bg);
		var _slh = sprite_get_height(spr_hud_menu_slider_bg);
		var _slx = gui_w()/2-_slw/2;
		var _sly = gui_h()/2+30;
		
		draw_sprite(spr_hud_menu_slider_bg,0,_slx,_sly);
		draw_sprite(spr_hud_menu_slider,0,_slx+_slw*global.Volume_Music,_sly+3);
		draw_set_color(c_white);
		draw_text(_slx+1, _sly-14, "Music Volume");
		
		// focus on the slider [0]
		if !(pause_menu_VolumeSlider_move[0] xor pause_menu_VolumeSlider_move[1])
		{
			if point_in_rectangle(gui_mouse_x(),gui_mouse_y(),_slx,_sly ,_slx+_slw, _sly+_slh)
			{
				if (mouse_check_button(mb_left))
				{
				    pause_menu_VolumeSlider_move[0] = true;
				}
			}
		}
		
		// move slider [0]
		if (pause_menu_VolumeSlider_move[0])
		{
			global.Volume_Music = median(0, 1, (gui_mouse_x()-_slx)/_slw);
			audio_group_set_gain(AG_Music,global.Volume_Music,0);
		}
		
		// reset focus [0]
		if (mouse_check_button_released(mb_left))
		{
			if (pause_menu_VolumeSlider_move[0]) {pause_menu_VolumeSlider_move[0] = false;}
		}
		
		
		
		
		
		// audio slider [1]
		var _slw = sprite_get_width(spr_hud_menu_slider_bg);
		var _slh = sprite_get_height(spr_hud_menu_slider_bg);
		var _slx = gui_w()/2-_slw/2;
		var _sly = gui_h()/2+80;
		
		draw_sprite(spr_hud_menu_slider_bg,0,_slx,_sly);
		draw_sprite(spr_hud_menu_slider,0,_slx+_slw*global.Volume_SFX,_sly+3);
		draw_set_color(c_white);
		draw_text(_slx+1, _sly-14, "Sound Volume");
		
		// focus on the slider [1]
		if !(pause_menu_VolumeSlider_move[1] xor pause_menu_VolumeSlider_move[0])
		{
			if point_in_rectangle(gui_mouse_x(),gui_mouse_y(),_slx,_sly ,_slx+_slw, _sly+_slh)
			{
				if (mouse_check_button(mb_left))
				{
					pause_menu_VolumeSlider_move[1] = true;
				}
			}
		}
		
		// move slider [1]
		if (pause_menu_VolumeSlider_move[1])
		{
			global.Volume_SFX = median(0, 1, (gui_mouse_x()-_slx)/_slw);
			audio_group_set_gain(AG_SFX,global.Volume_SFX,0);
		}
		
		// reset focus [1]
		if (mouse_check_button_released(mb_left))
		{
			if (pause_menu_VolumeSlider_move[1]) {pause_menu_VolumeSlider_move[1] = false;}
		}
		
		
		
		// back button
		var _btx = gui_w()/2-165;
		var _bty = gui_h()-80;
		draw_sprite_ext(spr_menu_back,bt_i[2],_btx,_bty,1,1,0,c_white,1);
		if point_in_rectangle(gui_mouse_x(),gui_mouse_y(), _btx-32 ,_bty-32 ,_btx+32 , _bty+32)
		{
			if (mouse_check_button(mb_left))
			{
				bt_i[2] = 1;
			}
			if (mouse_check_button_released(mb_left))
			{
				bt_i[2] = 0;
				Menu_Screen = "main";
			}
		}
		else
		{
			bt_i[2] = 0;
		}
		
		#endregion
        break;
}


// DISCLAIMER
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(gui_w()/2,gui_h()-8,"(C) 2020 Kazan Games\nAll rights reserved");
draw_set_valign(fa_top);
draw_set_halign(fa_left);