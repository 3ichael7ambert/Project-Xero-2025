// DEBUG

var cel = instance_number(objBuilding_sky);
var grnd = instance_number(objChunk_sky);
var bull = instance_number(objBullet);

draw_text_outlined(50,room_height/2,"Buildings: " + string( cel),c_black,c_white);
draw_text_outlined(50,room_height/2+100,"Chunks: " + string(grnd),c_black,c_white);
//draw_text_outlined(50,room_height/2+200,"Bullets: " + string(bull),c_black,c_white);