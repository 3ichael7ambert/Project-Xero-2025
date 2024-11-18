/// @description Insert description here
// You can write your code in this editor

target=obj_Player1;

if ((place_meeting(x + 64, y, obj_block_lava) || place_meeting(x + 64, y, obj_block_lava)) && y > room_height / 2) {
dist_to_top = range_finder(x+32,y-1,90,room_height,obj_block_lava,false,false);
}



alarm[0]=room_speed;











