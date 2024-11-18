/// @description  DRAW THE INFO BOX FOR THE DEMO




draw_set_color(c_white);
draw_set_alpha(0.6);
draw_rectangle(16,16,320,224,0);
draw_set_color(c_black);
draw_set_alpha(1);
draw_text(32,32,string_hash_to_newline("MAZE EXAMPLE ROOM##CUBE COUNT: "+
string(instance_number(objCaveWall))+"#FPS: "+string(fps)+
"#FPS REAL: "+string(fpsreal)
+"##ARROW KEYS TO MOVE PLAYER#ENTER TO GO TO NEXT ROOM"+"##HOUR: "+string(current_hour)+"#Min:"+string(current_minute)));

