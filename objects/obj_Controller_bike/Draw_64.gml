// Draw heads up to assist new players

draw_set_font(fnt_Debug_s14_bike);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(8, 8, string_hash_to_newline(@"Press [D] to enter debug
Press [F] to toggle fill
Press [R] to restart
Press [Left/Right] to move
Press [Space] to jump"));

draw_set_halign(fa_center);
//draw_text(room_width / 2, 8, string_hash_to_newline("Floor Instance Count: " + string(obj_Floor.instance_count) +
//"#FPS: " + string(fps)));

