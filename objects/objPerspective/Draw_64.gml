/// @description  DRAW THE INFO BOX FOR THE DEMO

draw_set_color(c_white);
draw_set_alpha(0.6);
draw_rectangle(16,16,320,224,0);
draw_set_color(c_black);
draw_set_alpha(1);
draw_text(32,32,string_hash_to_newline("MOUSE PERSPECTIVE ROOM##CUBE COUNT: "+
string(instance_number(objCube))+"#FPS: "+string(fps)+
"#FPS REAL: "+string(fpsreal)
+"##SPACE TO PLACE BLOCK#ENTER TO GO TO NEXT ROOM"));

