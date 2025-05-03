/// @description Insert description here
// You can write your code in this editor


/// @description Create objects

fpsreal = fps_real;
alarm[2]=30;

global.wave = 1;
global.kill_count = 0;
global.difficulty = 1;
global.high_score = 0;

wave_timer = 90;
enemies_remaining = 0; // this is key
enemy_object=obj_Enemy_Robot;

 enemy_spawned = true;

/*
with (instance_create(0, 0, objCamera))
{
    target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, objMazePlayer);
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
var blended_color;
blend_factor=current_minute/60;


// Create Event
color1 = make_color_rgb(87, 141, 191); // Blue
color2 = make_color_rgb(11, 37, 61); // Navy
color3 = make_color_rgb(239, 192, 50); // Yellow
color4 = make_color_rgb(239, 64, 158); // Red
color5 = make_color_rgb(5,5,15); //black
color6 = make_color_rgb(97, 151, 210); //  Light Blue
blended_color=color1;

if current_hour>=0 && current_hour<6 {
    blended_color = merge_color(color5,color2,blend_factor);
}
else if current_hour>=6 && current_hour<7 {
    blended_color = merge_color(color2,color4,blend_factor);
}
else if current_hour>=7 && current_hour<8 {
    blended_color = merge_color(color4,color3,blend_factor);
}
else if current_hour>=8 && current_hour<9 {
    blended_color = merge_color(color3,color1,blend_factor);
}
else if current_hour>=9 && current_hour<13 {
    blended_color = merge_color(color1,color6,blend_factor);
}
else if current_hour>=13 && current_hour<17 {
    blended_color = merge_color(color6,color1,blend_factor);
}
else if current_hour>=17 && current_hour<18 {
    blended_color = merge_color(color1,color3,blend_factor);
}
else if current_hour>=18 && current_hour<19 {
    blended_color = merge_color(color3,color4,blend_factor);
}
else if current_hour>=19 && current_hour<21 {
    blended_color = merge_color(color4,color2,blend_factor);
}
else if current_hour>=21 && current_hour<25 {
    blended_color = merge_color(color2,color5,blend_factor);
}


__background_set_colour(blended_color);

var lay_id = layer_get_id("Colour");
var back_id = layer_background_get_id(lay_id);
layer_background_blend(back_id, blended_color);



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
	