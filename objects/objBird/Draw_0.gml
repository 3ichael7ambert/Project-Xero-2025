scr_bird_draw();
shader_reset();
draw_set_colour(c_white);
if (state="fly") draw_text_outlined(x,y,string("fly"),c_black,c_white);
if (state="ground") draw_text_outlined(x,y,string("ground"),c_black,c_white);
draw_text_outlined(x,y+10,"HP: " + string(hp),c_black,c_white);