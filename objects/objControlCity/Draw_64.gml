/// @description Insert description here
// You can write your code in this editor
/*
draw_set_color(c_white);
draw_set_alpha(0.6);
draw_rectangle(16,16,320,224,0);
draw_set_color(c_black);
draw_set_alpha(1);
draw_text(32,32,string_hash_to_newline("#FPS: "+string(fps)+
"#FPS REAL: "+string(fpsreal)
+"##ARROW KEYS TO MOVE PLAYER#ENTER TO GO TO NEXT ROOM"+"##HOUR: "+string(current_hour)+"#Min:"+string(current_minute)));
*/
////

// Draw Health Bar
draw_text(32, 32, "Health:");
draw_rectangle_color(120, 30, 220, 50, c_red, c_red, c_red, c_red, false);
draw_rectangle_color(120, 30, 120 + (global.health / global.max_health) * 100, 50, c_lime, c_lime, c_lime, c_lime, false);

// Draw Burnout Bar
draw_text(32, 60, "Burnout:");
draw_rectangle_color(120, 58, 220, 78, c_gray, c_gray, c_gray, c_gray, false);
draw_rectangle_color(120, 58, 120 + (global.burnout / global.max_burnout) * 100, 78, c_orange, c_orange, c_orange, c_orange, false);

// Draw Aggression
draw_text(32, 100, "Aggression: " + string(global.aggression));

// Draw Coins and Credits
draw_text(32, 130, "Coins: " + string(global.coins));
draw_text(32, 160, "Credits: " + string(global.credits));

// Draw Lives
draw_text(32, 190, "Lives: " + string(global.lives));
