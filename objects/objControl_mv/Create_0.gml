/// @description Insert description here
// You can write your code in this editor

randomize();
depth=-10000;
/// @description Create objects

grav_dir="down";

//
//init
// Game Stats
randomize();

global.gameReady=false;


instance_create(x,y,oGameSystem);
//instance_create(x,y,oMissionManager);

if (!variable_global_exists("players")) {global.players=1;}

for (i=1;i<=global.players;i++) {
	//var a = instance_create(__view_get( e__VW.WView, 0 )/2+(i*50),  room_height-1000, obj_Player1);
	//a.player=i;
}

/*
if !variable_global_exists(players) {
	global.players=1;
}
*/
///
///


fpsreal = fps_real;
alarm[2]=30;

rain=false; //WORKS
snow=false; //WORKS
fireworks=false;
night=false;
fog=true;
apocalypse=false;
cloudy=false;
wind=true;


	// var a = instance_create(x,y,objCityLighting);
