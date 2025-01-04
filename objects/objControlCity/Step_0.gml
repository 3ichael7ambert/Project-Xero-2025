/// @description Insert description here
// You can write your code in this editor

// Infinite Room



/*
with(objCityParent_Skyline) {

	
	
	var minX = view_xview - 200;
	var minY = view_yview - 200;
	var maxX = view_xview + view_wview + 200;
	var maxY = view_yview + view_hview + 200;
	

	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	var minX = vx + 200;
	var minY = vy + 200;
	var vw = camera_get_view_width(view_camera[0]) 
	var vh = camera_get_view_height(view_camera[0]);
	var maxX = vw - 200;
	var maxY = vh - 200;
	
	if (bbox_right < minX || bbox_left > maxX || bbox_bottom < minY || bbox_top > maxY) {
    //instance_deactivate_object(id);	
} else {
	//instance_activate_object(self);
}
}
*/

//instance_activate_region(minX,minY,maxX,maxY,true);




if object_exists(obj_Player1) {
	
	
	
}

//Fireworks
if (fireworks) {
	instance_create(x+irandom_range(-500,500),room_height,objFirework);
}

//Rain
if (rain) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	effect_create_above(ef_rain, irandom(room_width), irandom(room_height), 1, c_white);
}

//Snow
if (snow) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	effect_create_above(ef_snow, irandom(room_width), irandom(room_height), 1, c_white);
}

//Wind
if (wind) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	//effect_create_above(ef_rain, irandom(room_width), irandom(room_height), 1, c_white);
	//_effect_windblown_particles
	//_effect_gaussian_blur
	
	
	//setup_wind_blown_particles(sprite, effect_layer_name)
	var _fx_wind_blown_particles = fx_create("_effect_windblown_particles");
	fx_set_parameter(_fx_wind_blown_particles, "param_sprite", sprite);
	layer_set_fx(effect_layer_name, _fx_wind_blown_particles);
}

//Fog
if (fog) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	//effect_create_above(ef_fog, irandom(room_width), irandom(room_height), 1, c_white);
var _fx_fog = fx_create("_filter_fractal_noise");
var _fx_gradient = fx_create("_filter_gradient");
var _fx_colorbalance = fx_create("_filter_colour_balance");
var _fx_tint = fx_create("_filter_tintfiltere");
var _fx_colorise = fx_create("_filter_colourise");
var _fx_contrast = fx_create("_filter_contrast");
var _fx_edge = fx_create("_filter_edgedetect");
var _fx_grey = fx_create("_filter_greyscale");
var _fx_heat = fx_create("_filter_heathaze");
var _fx_lut = fx_create("_filter_lut_colour");
var _fx_hue = fx_create("_filter_hue");
var _fx_mask = fx_create("_filter_mask");
var _fx_posterise = fx_create("_filter_posterise");
var _fx_rgbnoise = fx_create("_filter_rgbnoise");
var _fx_oldfilm = fx_create("_filter_old_film");
var _fx_ripples = fx_create("_filter_ripples");
var _fx_screenshake = fx_create("_filter_screenshake");
var _fx_underwater = fx_create("_filter_underwater");
var _fx_vignette = fx_create("_filter_vignette");
var _fx_zoomblur = fx_create("_filter_zoom_blur");
fx_set_parameter(_fx_fog, "g_TintCol", [1, 0, 0, 1]);
layer_set_fx("EffectLayer", _fx_fog);

}

//Cloudy
if (cloudy) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	effect_create_behind(ef_cloud, irandom(room_width), irandom(room_height), 1, c_white);
}


//Apocalypse
if (apocalypse) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	effect_create_behind(ef_smoke, irandom(room_width), irandom(room_height), 1, c_white);
	effect_create_behind(ef_spark, irandom(room_width), irandom(room_height), 1, c_white);
	effect_create_behind(ef_flare, irandom(room_width), irandom(room_height), 1, c_white);

}


//Apocalypse
if (night) {
	//effect_create_above(ef_rain, x+irandom_range(-100,100), y+irandom_range(-100,100), 1, c_white);
	effect_create_behind(ef_star, irandom(room_width), irandom(room_height), 1, c_white);
}







