/// Parallax BG: Create
layers = []; // array of layer structs
depth=100;
//_level=choose("desert","forest","jungle");
_level="desert";


fg_bg="background";
if (fg_bg=="background") {
	depth=100;
} else {
	depth=-100;
}

if (_level=="jungle") {
	var a = instance_create(x,y,obj_bike_parralax);
	a.fg_bg="foreground";
	a._level = _level;
}



scr_timeofday_background_init();
//col_ambient=scr_timeofday_color();

if (current_hour<7 || current_hour>19) {
	night=true;}
else {
	night=true;
}
cloudy=true;


function add_layer(_spr, _factor, _y, _alpha, _scale_x, _scale_y) {
    var L = {
        spr     : _spr,
        factor  : _factor,   // 0..1 (smaller = farther = slower)
        y       : _y,
        alpha   : _alpha,
        sx      : _scale_x,
        sy      : _scale_y,
        scrollx : 0
    };
    array_push(layers, L);
}

if (night==true) {
	add_layer(backStars5,    1.00,  80, 1, .8, .8);  // very far
	add_layer(backStars4,    0.99, 140, 1, .8, .8);  // mid
	add_layer(backStars3,   0.98, 220, 1, .9, .9);  // near
	add_layer(backStars2,    0.97, 140, 1, .8, .8);  // mid
	add_layer(backStars1,   0.96, 220, 1, .9, .9);  // near
}

if (cloudy==true) {
	// Example: add as many as you like (front to back or back to front)
	add_layer(backCloudLayer3,    0.95,  80, 1, .8, .8);  // very far
	add_layer(backCloudLayer2,    0.93, 140, 1, .8, .8);  // mid
	add_layer(backCloudLayer1,   0.91, 220, 1, .9, .9);  // near
}

if (_level=="sky") {
// Example: add as many as you like (front to back or back to front)
add_layer(backCloudLayer1,    0.20,  80, 1, 1, 1);  // very far
add_layer(backCloudLayer2,    0.35, 140, 1, 1, 1);  // mid
add_layer(backCloudLayer3,   0.60, 220, 1, 1, 1);  // near

}

if (_level=="desert") {
	add_layer(sprDesert_Bike_1,    0.90,  0, 1, 1, 1);  // very far
	add_layer(sprDesert_Bike_2,    0.65, 0, 1, 1, 1);  // mid
	add_layer(sprDesert_Bike_3,   0.35, 0, 1, 1, 1);  // near
	add_layer(sprDesert_Bike_4,   0.20, 0, 1, 1, 1);  // near
}
if (_level=="forest") {
	add_layer(sprForestLevel_1,    0.80,  0, 1, 1, 1);  // very far
	add_layer(sprForestLevel_2,    0.65, 0, 1, 1, 1);  // mid
	add_layer(sprForestLevel_3,   0.35, 0, 1, 1, 1);  // near
}
if (_level=="jungle" && fg_bg=="background") {
	add_layer(sprJungleLevel_1,    0.80,  0, 1, 1, 1);  // very far
	add_layer(sprJungleLevel_2,    0.65, 0, 1, 1, 1);  // mid
	add_layer(sprJungleLevel_3,   0.45, 0, 1, 1, 1);  // near
	add_layer(sprJungleLevel_4,   0.30, 0, 1, 1, 1);  // near
}
if (_level=="jungle" && fg_bg=="foreground") {

	add_layer(sprJungleLevel_5,   1.05, 0, 1, 1, 1);  // near
	add_layer(sprJungleLevel_6,   1.20, 0, 1, 1, 1);  // near
}


// Track camera for smooth parallax deltas
cam = view_camera[0];
last_cam_x = camera_get_view_x(cam);


//instance_create(x,y,objCityWeather);
//instance_create(x,y,objCityLighting);



/*
create_parallax_layer_bike(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
create_parallax_layer_bike(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
create_parallax_layer_bike(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);
*/