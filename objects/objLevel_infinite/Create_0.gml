/// @description Create objects
randomize();

global.gameReady=false;


instance_create(x,y,oGameSystem);




show_debug_message(" LEVEL NAME + " + string(global.level_name));

if !variable_global_exists("levels"){
	global.levels=1; 
}
//0=sky
//1=space
//4=stars
global.ships=0;
#macro level global.levels
#macro ship global.ships

/*
//global.players=1;

//controller check
for (var i = 0; i < 3; i++;)
{
    if (true)
    {
     //   global.players++;
    }
    else
    {
     // global.players=1;
    }
}
*/

//Player Color
color1 = make_color_rgb(random(255),random(255),random(255));
color2 = make_color_rgb(random(255),random(255),random(255));
color3 = make_color_rgb(random(255),random(255),random(255));

global.p1lives=3;

global.p2lives=3;

global.p3lives=3;

global.p4lives=3;


if (instance_exists(obj_Player1)) {
	target=obj_Player1;
} else {
	target = noone;
}

scale=1;

scr_infinite_hud_init();

wave_timer = 90;
enemies_remaining = 0; // this is key
enemy_object=obj_Enemy_Robot;

 enemy_spawned = true;
 
 
 
///DEBUG
//globalvar level,ship;

//level=19;
//ship=0;
//////
//level=0;

spawn_x=x;
spawn_y=y;

target_player=obj_Player1;
playerScale=.9;

//--------------------//
// STEAM
//steam_set_stat_int("match_count", steam_get_stat_int("match_count") + 1);
//--------------------//


with (instance_create(0, 0, objCamera))
{	
	target_player=objLevel_infinite;
	/*
	target_player=obj_Player1;
	if (global.players==1) {
		target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, target_player);
			target.player=1;
	}
	
	if (global.players==2) {
		target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, target_player);
			target.player=1;
		var a = instance_create(__view_get( e__VW.WView, 0 )*.6 , __view_get( e__VW.HView, 0 )/2, target_player);
			a.player=2;
	}

	if (global.players==3) {
		target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, target_player);
			target.player=1;
		var a = instance_create(__view_get( e__VW.WView, 0 )/4 , __view_get( e__VW.HView, 0 )/2, target_player);
			a.player=2;
		var b = instance_create(__view_get( e__VW.WView, 0 )*.75, __view_get( e__VW.HView, 0 )/2, target_player);
			b.player=3;
	}
	if (global.players==4) {
		target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, target_player);
			target.player=1;
		var a = instance_create(__view_get( e__VW.WView, 0 )*.4 , __view_get( e__VW.HView, 0 )/2, target_player);
			a.player=2;
		var b = instance_create(__view_get( e__VW.WView, 0 )*.6, __view_get( e__VW.HView, 0 )/2, target_player);
			b.player=3;
		var c = instance_create(__view_get( e__VW.WView, 0 )*.7, __view_get( e__VW.HView, 0 )/2, target_player);
		c.player=4;
	}
*/
}

if level!=5 {target=obj_Player1;}
if level=5 {target=obj_Player1;}


//physics_world_create(.1/32);

/*
LEVELS
0 Sky -gravity
1 space -no gravity
2  sky top- no gravity
3 city top - gravity
4 moon - gravity
5 asteroids
6 desert beach
7 forest top - no gravity
8-ocean top
9 desert side
10 city side - no gravity
11 forest side - gravity
12 Jungle side
13 RAINBOW
14 Snow
15 Sketchbook
16 Comic
17 Pixel
18 ROUND MOON
19 Worm hole
20 3D World
21 Asteroid Ball (soccer)
22 ALIEN UFO PINBALL
23 Hyper Drive - Tron

*/

//SKY SIDE
//if level=0
if (global.level_name == "Sky")
{


create_parallax_layer(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
create_parallax_layer(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
create_parallax_layer(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);

alarm[0] = room_speed;


///Set random background colour
/*
__background_set_colour( choose(
                    make_colour_rgb(240, 220, 160),
                    make_colour_rgb(200, 230, 240),
                    make_colour_rgb(200, 240, 200),
                    make_colour_rgb(240, 180, 180),
                    ) );
					*/
scr_timeofday_background_init();
					
}


//SPACE Vacant

if (global.level_name == "Outerspace")
{
create_parallax_layer(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( c_black);
}


///SKY TOP
if level=2
{

create_parallax_layer(sprAerialView4, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
//create_parallax_layer(sprAerialView2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(sprAerialView3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer(sprAerialView2, 0.8, 0.8, 0.05, 0, 1020, c_white, 1);
create_parallax_layer(sprAerialView1, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 222, 16),
                    make_colour_rgb(20, 223, 24),
                    make_colour_rgb(20, 224, 20),
                    make_colour_rgb(24, 218, 18),
                    ) );
					
}


//CITY TOP
if level=3
{

//create_parallax_layer(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
//create_parallax_layer(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
//create_parallax_layer(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;



					
}

//MOON
if level=4
{

create_parallax_layer(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}


//ASTEROIDS
if level=5
{

create_parallax_layer(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}

//beach
if level=6
{

create_parallax_layer(sprSand, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer(sprAerialView6, -0.2, -0.2, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView5, -0.4, -0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView4, -0.6, -0.6, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(sprAerialView3, -0.8, -0.8, 0.05, 0, -1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}

//forest
if level=7
{

create_parallax_layer(bgGrass, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer(sprAerialView6, -0.2, -0.2, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView5, -0.4, -0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView4, -0.6, -0.6, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(sprAerialView3, -0.8, -0.8, 0.05, 0, -1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}

//ocean
if level=8
{

globalvar ocean_frame;
ocean_frame=0;

create_parallax_layer(sprBeach, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer_ext(sprOcean, ocean_frame, 0.15, 0.15, 0.2, 0, 900, c_white, .7);

create_parallax_layer(sprAerialView6, -0.2, -0.2, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView5, -0.4, -0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView4, -0.6, -0.6, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(sprAerialView3, -0.8, -0.8, 0.05, 0, -1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}
//desert_side
if level=9
{

create_parallax_layer(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}
//city side
if level=10
{

create_parallax_layer(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}
//forest
if level=11
{

create_parallax_layer(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}
//jungle
if level=12
{

create_parallax_layer(sprGrassJungle, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer(sprAerialView6, -0.2, -0.2, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView5, -0.4, -0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView4, -0.6, -0.6, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(sprAerialView3, -0.8, -0.8, 0.05, 0, -1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}

//Rainbow
if level=13
{

create_parallax_layer(sprGrassJungle, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer(sprAerialView6, -0.2, -0.2, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView5, -0.4, -0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView4, -0.6, -0.6, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(sprAerialView3, -0.8, -0.8, 0.05, 0, -1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}

//SNOW BLIZZARD
if level=14
{

create_parallax_layer(sprSnow, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer(sprAerialView6, -0.2, -0.2, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView5, -0.4, -0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(sprAerialView4, -0.6, -0.6, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(sprAerialView3, -0.8, -0.8, 0.05, 0, -1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					
}

//SKETCHBOOK
if level=15
{

var surf;
surf = surface_create(640, 480);
surface_set_target(surf);
draw_set_color(c_black);
//draw_rectangle(0,0,640,480,false);
draw_clear_alpha(c_black, 0);
draw_set_color(c_white);
repeat (irandom_range(10,20)) {
draw_sprite(sprSketch_stars, irandom_range(0,5), irandom_range(0,640), irandom_range(0,480));
}
spr_customBG = sprite_create_from_surface(surf, 0, 0, 640, 480, true, true, 0, 0);
surface_reset_target();
surface_free(surf);

create_parallax_layer(spr_customBG, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);

create_parallax_layer(sprPaperLined, 1, 1, 0, 0, -1000, c_white, 1);
create_parallax_layer(sprPaperText, 1, 1, 0, 0, -1000, c_black, 1);


alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour(c_white);
/*
__background_set_colour( choose(
                    make_colour_rgb(24, 22, 16),
                    make_colour_rgb(20, 23, 24),
                    make_colour_rgb(20, 24, 20),
                    make_colour_rgb(24, 18, 18),
                    ) );
					*/
					
}




if level=16 //COMIC
{
//border
create_parallax_layer(sprComic, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);







///@desc Initialize

//Anti-aliasing level 8
display_reset(8, false);
//Initialize default parameters
halftone_initialize(spr_noise, spr_paper);
//Set ink colors slightly faded
halftone_set_cmyk_colors(#22FFFF, #FF22FF, #FFFF22, #222222);

//instance_create(x,y,obj_comicShader)

//We'll draw this manually



/*
var mask_x = 0;   // Replace with the x position of the mask
var mask_y = 0;  
//panel 1
// Create the parallax layer
var parallax_layer1 = create_parallax_layer(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
//var parallax_layer2 = create_parallax_layer(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
//var parallax_layer3 = create_parallax_layer(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);
// Set the blend mode to bm_dest_alpha
gpu_set_blendmode(bm_dest_alpha);

// Draw a mask sprite with alpha 0 over the area to be masked
draw_sprite(sprComic, 1, mask_x, mask_y);

// Set the blend mode back to normal
gpu_set_blendmode(bm_normal);

// Draw the tiled background over the masked area
draw_background_tiled_ext(backCloudLayer1, x, y, 1, 1, c_white, 1);
//draw_background_tiled_ext(parallax_layer2, x, y, 1, 1, c_white, 1);
//draw_background_tiled_ext(parallax_layer3, x, y, 1, 1, c_white, 1);

		*/
		
		alarm[0] = room_speed;
}

//PIXEL
if level=17
{

var surf;
surf = surface_create(640, 480);
surface_set_target(surf);
draw_set_color(c_black);
//draw_rectangle(0,0,640,480,false);
draw_clear_alpha(c_black, 0);

repeat (irandom_range(10,20)) {
	// Define the color ranges
	var yellow_range = make_color_rgb(255, 255, 0); // Bright yellow
	var pink_range = make_color_rgb(255, 182, 193); // Light pink
	var blue_range = make_color_rgb(0, 0, 255); // Bright blue

	// Choose a random color from each range
	var random_yellow = choose(yellow_range, make_color_rgb(255, 255, 100));
	var random_pink = choose(pink_range, make_color_rgb(255, 182, 210));
	var random_blue = choose(blue_range, make_color_rgb(100, 100, 255));

	// Set the color to a random color from the ranges
	draw_set_color(choose(random_yellow, random_pink, random_blue));

	// Now you can use draw functions to draw stars with the selected color
	// For example, draw a point at the desired location
	draw_point(irandom_range(0,640), irandom_range(0,480));
}

spr_customBG = sprite_create_from_surface(surf, 0, 0, 640, 480, true, true, 0, 0);
surface_reset_target();
surface_free(surf);

create_parallax_layer(spr_customBG, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);


alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(10, 5, 15),
                    make_colour_rgb(5, 5, 10),
                    make_colour_rgb(10, 15, 20),
                    make_colour_rgb(5, 10, 20),
                    ) );
					
}


//MOON 360
if level=18  {
width360=3840;
height360=2160;
camera_set_view_size(view_camera[0], width360, height360);
instance_create(x,y,obj360);
create_parallax_layer(sprMoonText, .2, .2, 0, 0, 1000, c_white, 1);

alarm[0] = room_speed;

}

//WORMHOLE
if level=19  {
width360=3840;
height360=2160;
camera_set_view_size(view_camera[0], width360, height360);
instance_create(x,y,obj360);


create_parallax_layer(backStars3, 0.2, 0.2, 0.2, .2, 1000, c_white, 1);
create_parallax_layer(backStars4, 0.4, 0.4, 0.1, 0.1, 1010, c_white, 1);
create_parallax_layer(backStars5, 0.6, 0.6, 0.05, 0.05, 1020, c_white, 1);



var lay_id_19 = layer_get_id("Colour");
var back_id_19 = layer_background_get_id(lay_id_19);
var col_bg_19 = make_colour_rgb(5, 5, 15) ;
layer_background_blend(back_id_19,col_bg_19);

alarm[0] = room_speed;

}


//RAGDOLL
global.cur_rag = 1;

kills=0;