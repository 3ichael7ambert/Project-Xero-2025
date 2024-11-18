/// @description Insert description here
// You can write your code in this editor


image_angle=90-2*hspeed;
//if keyboard_check(vk_left)=true
//then {direction=direction+1};
if keyboard_check(vk_left)then hspeed-=.4;
if keyboard_check(vk_right)then hspeed+=.4;
if hspeed>20 then hspeed=20;
if hspeed<-20 then hspeed=-20;
