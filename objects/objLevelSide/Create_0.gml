/// @description Create objects
randomize();
//Player Color
color1 = make_color_rgb(random(255),random(255),random(255));
color2 = make_color_rgb(random(255),random(255),random(255));
color3 = make_color_rgb(random(255),random(255),random(255));

p1lives=3;
gui_pad=32;
///DEBUG
//globalvar level,ship;
//level=12;
//ship=0;
////

playerScale=.2;


with (instance_create(0, 0, objCameraSide))
{	
	if level!=5{
    target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, objPlane);
	}
	
	if level=5{
    target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, objPlanePhy);
	}
	
}


if level!=5 {target=objPlane;}
if level=5 {target=objPlanePhy;}


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
if level=0
{

create_parallax_layer_side()(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
create_parallax_layer_side(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
create_parallax_layer_side(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);

alarm[0] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(240, 220, 160),
                    make_colour_rgb(200, 230, 240),
                    make_colour_rgb(200, 240, 200),
                    make_colour_rgb(240, 180, 180),
                    ) );
					
}


//SPACE Vacant
if level=1
{

create_parallax_layer_side(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer_side(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

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


///SKY TOP
if level=2
{

create_parallax_layer_side(sprAerialView4, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
//create_parallax_layer_side(sprAerialView2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(sprAerialView3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer_side(sprAerialView2, 0.8, 0.8, 0.05, 0, 1020, c_white, 1);
create_parallax_layer_side(sprAerialView1, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

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

//create_parallax_layer_side(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
//create_parallax_layer_side(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
//create_parallax_layer_side(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

alarm[0] = room_speed; //enemies
alarm[1] = room_speed; //asteroids
alarm[2] = room_speed;



					
}

//MOON
if level=4
{

create_parallax_layer_side(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer_side(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer_side(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer_side(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

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

create_parallax_layer_side(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer_side(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

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

create_parallax_layer_side(backStarsLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer_side(backStarsLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(backStarsLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);

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

create_parallax_layer_side(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer_side(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer_side(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer_side(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

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

create_parallax_layer_side(backStars1, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);
create_parallax_layer_side(backStars2, 0.4, 0.4, 0.1, 0, 1010, c_white, 1);
create_parallax_layer_side(backStars4, 0.6, 0.6, 0.05, 0, 1020, c_white, 1);
create_parallax_layer_side(backStars5, 0.8, 0.8, 0.25, 0, 1020, c_white, 1);
create_parallax_layer_side(backStars3, 1.0, 1.0, 0.12, 0, 1020, c_white, 1);

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

create_parallax_layer_side(sprDesert, 0, 0.8, 0, 0, 100, 1040, c_white, 1);
create_parallax_layer_side(sprDesert, 1, 0.6, 0, 0, 0, 1030, c_white, 1);
create_parallax_layer_side(sprDesert, 2, 0.4, 0, 0, 0, 1020, c_white, 1);
create_parallax_layer_side(sprDesert, 3, 0.2, 0, 0, 0, 1010, c_white, 1);
create_parallax_layer_side(sprDesert, 4, 0.0, 0, 0, 0, 1005, c_white, 1);

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

create_parallax_layer_side(sprLevelTitle_Metro, 0, 0.8, 0, 0, 100, 1040, c_white, 1);
create_parallax_layer_side(sprLevelTitle_Metro, 1, 0.6, 0, 0, 0, 1030, c_white, 1);
create_parallax_layer_side(sprLevelTitle_Metro, 2, 0.4, 0, 0, 0, 1020, c_white, 1);
create_parallax_layer_side(sprLevelTitle_Metro, 3, 0.2, 0, 0, 0, 1010, c_white, 1);

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
//forest  side
if level=11
{

create_parallax_layer_side(sprForestLevel, 0, 0.8, y, 0, 100, 1040, c_white, 1);
create_parallax_layer_side(sprForestLevel, 1, 0.6, 0, 0, 0, 1030, c_white, 1);
create_parallax_layer_side(sprForestLevel, 2, 0.4, 0, 0, 0, 1020, c_white, 1);
create_parallax_layer_side(sprForestLevel, 3, 0.2, 0, 0, 0, 1010, c_white, 1);


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
//jungle side
if level=12
{

create_parallax_layer_side(sprJungleLevel, 0, 0.8, 0, 0, 100, 1080, c_white, 1);
create_parallax_layer_side(sprJungleLevel, 1, 0.7, 0, 0, 0, 1070, c_white, 1);
create_parallax_layer_side(sprJungleLevel, 2, 0.6, 0, 0, 0, 1060, c_white, 1);
create_parallax_layer_side(sprJungleLevel, 3, 0.5, 0, 0, 0, 1050, c_white, 1);
create_parallax_layer_side(sprJungleLevel, 4, 0.4, 0, 0, 100, 1040, c_white, 1);
create_parallax_layer_side(sprJungleLevel, 5, 0.3, 0, 0, 0, 1030, c_white, 1);
create_parallax_layer_side(sprJungleLevel, 6, 0.2, 0, 0, 0, 1020, c_white, 1);

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






if level=16 //COMIC
{
//border
create_parallax_layer_side(sprComic, 0.2, 0.2, 0.2, 0, 1000, c_white, 1);







///@desc Initialize

//Anti-aliasing level 8
display_reset(8, false);
//Initialize default parameters
halftone_initialize(spr_noise, spr_paper);
//Set ink colors slightly faded
halftone_set_cmyk_colors(#22FFFF, #FF22FF, #FFFF22, #222222);

instance_create(x,y,obj_comicShader)

//We'll draw this manually



/*
var mask_x = 0;   // Replace with the x position of the mask
var mask_y = 0;  
//panel 1
// Create the parallax layer
var parallax_layer1 = create_parallax_layer_side(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
//var parallax_layer2 = create_parallax_layer_side(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
//var parallax_layer3 = create_parallax_layer_side(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);
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
}


//MOON 360
if level=18  {
width360=3840;
height360=2160;
camera_set_view_size(view_camera[0], width360, height360);
instance_create(x,y,obj360);
create_parallax_layer_side(sprMoonText, .2, .2, 0, 0, 1000, c_white, 1);
}

//WORMHOLE
if level=19  {
width360=3840;
height360=2160;
camera_set_view_size(view_camera[0], width360, height360);
instance_create(x,y,obj360);


create_parallax_layer_side(backStars3, 0.2, 0.2, 0.2, .2, 1000, c_white, 1);
create_parallax_layer_side(backStars4, 0.4, 0.4, 0.1, 0.1, 1010, c_white, 1);
create_parallax_layer_side(backStars5, 0.6, 0.6, 0.05, 0.05, 1020, c_white, 1);



var lay_id_19 = layer_get_id("Colour");
var back_id_19 = layer_background_get_id(lay_id_19);
var col_bg_19 = make_colour_rgb(5, 5, 15) ;
layer_background_blend(back_id_19,col_bg_19);

}


//RAGDOLL
global.cur_rag = 1;

kills=0;