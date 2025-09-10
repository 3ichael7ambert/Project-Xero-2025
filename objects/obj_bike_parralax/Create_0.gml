/// Parallax BG: Create
layers = []; // array of layer structs

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

// Example: add as many as you like (front to back or back to front)
add_layer(backCloudLayer1,    0.20,  80, 1, 1, 1);  // very far
add_layer(backCloudLayer2,    0.35, 140, 1, 1, 1);  // mid
add_layer(backCloudLayer3,   0.60, 220, 1, 1, 1);  // near

// Track camera for smooth parallax deltas
cam = view_camera[0];
last_cam_x = camera_get_view_x(cam);


//instance_create(x,y,objCityWeather);
instance_create(x,y,objCityLighting);
