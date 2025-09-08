/// @description Insert description here
// You can write your code in this editor

randomize();
depth=-10000;
/// @description Create objects
for (i=0;i<50;i++) {
	var a=instance_create(random(room_width),3533,objHuman);
	a.depth=-10000;
}

//
//init
// Game Stats
randomize();

global.gameReady=false;

scr_building_skyline();
scr_building_skyline_bg(3584,350,irandom_range(5, 7),irandom_range(7, 11),irandom_range(3, 5),irandom_range(1,2),irandom_range(1,2),-3,-3)
scr_building_skyline_bg(3584,600,irandom_range(5, 7),irandom_range(7, 11),irandom_range(3, 5),irandom_range(1,2),irandom_range(1,2),-3,-3)
scr_building_skyline_bg(3584,950,irandom_range(5, 7),irandom_range(7, 11),irandom_range(3, 5),irandom_range(1,2),irandom_range(1,2),-3,-3)


scr_hud_bubble_init();
scr_infinite_hud_init();

instance_create(x,y,oGameSystem);
instance_create(x,y,oMissionManager);

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


/*
with (instance_create(0, 0, objCamera))
{
    target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, obj_Player1);
}

create_parallax_layer(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
create_parallax_layer(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
create_parallax_layer(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);

alarm[0] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(240, 220, 160),
                    make_colour_rgb(200, 230, 240),
                    make_colour_rgb(200, 240, 200),
                    make_colour_rgb(240, 180, 180),
                    ) );


*/
//scr_timeofday_background_init();

blended_color=c_red;

//instance_create(x,y,oMissionManager);
//Deactivate
alarm[1]=1;
vx = camera_get_view_x(view_camera[0]);
vy = camera_get_view_y(view_camera[0]);
minX = vx + 200;
minY = vy + 200;
vw = camera_get_view_width(view_camera[0]) 
vh = camera_get_view_height(view_camera[0]);
maxX = vw - 200;
maxY = vh - 200;
	
	
	//BIRDS
	for (i=0;i<20;i++) {
		var a = instance_create(random(room_width),random(room_height),objBird);
		a.depth=-9999
	}
	//LIGHTING
	 var a = instance_create(x,y,objCityLighting);
	 var b = instance_create(x,y,objCityWeather);
	// b.part_state_player = choose("Snow","Rain","Slush");
	// instance_create(x,y,objToDPost);