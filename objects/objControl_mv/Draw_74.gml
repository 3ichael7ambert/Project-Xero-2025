// DEBUG

var cel = instance_number(objCeil_mv);
var grnd = instance_number(objGround_mv);
var bull = instance_number(objBullet);

draw_text_outlined(50,room_height/2,"Ceil: " + string( cel),c_black,c_white);
draw_text_outlined(50,room_height/2+100,"Ground: " + string(grnd),c_black,c_white);
draw_text_outlined(50,room_height/2+200,"Bullets: " + string(bull),c_black,c_white);