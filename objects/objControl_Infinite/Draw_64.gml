/// @description Insert description here
// You can write your code in this editor
scr_infinite_hud_draw();




draw_set_color(c_white);
draw_set_alpha(0.6);
draw_rectangle(16,16,320,224,0);
draw_set_color(c_black);
draw_set_alpha(1);
draw_text(32,32,string_hash_to_newline("#FPS: "+string(fps)+
"#FPS REAL: "+string(fpsreal)
+"##ARROW KEYS TO MOVE PLAYER#ENTER TO GO TO NEXT ROOM"+"##HOUR: "+string(current_hour)+"#Min:"+string(current_minute)));


draw_text(32, 128, "Next wave in: " + string(wave_timer div room_speed));

draw_text(32, 313, "Enemy Count: "+ string(instance_number(enemy_object)));

// Optional: Display UI
draw_text(32, 32, "Wave: " + string(global.wave));
draw_text(32, 64, "Kills: " + string(global.kill_count));

