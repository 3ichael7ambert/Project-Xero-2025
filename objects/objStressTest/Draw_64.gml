/// @description  DRAW THE INFO BOX FOR THE DEMO

draw_set_color(c_white);
draw_set_alpha(0.6);
draw_rectangle(16,16,320,224,0);

if (hasdropped == 1) {

    draw_set_color(c_red);

} else {

    draw_set_color(c_black);

}

draw_set_alpha(1);
draw_text(32,32,string_hash_to_newline("STRESS TEST ROOM##CUBE COUNT: "+
string(instance_number(objCube2))+"#FPS: "+string(fps)+
"#FPS REAL: "+string(fpsreal)
+"##HOLD SPACE TO PLACE BLOCKS#ENTER TO GO TO NEXT ROOM##FIRST FPS HIT AT "
+string(mydrop)+" CUBES"));

