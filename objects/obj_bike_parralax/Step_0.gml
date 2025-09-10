/// Parallax BG: Step
var cam_x = camera_get_view_x(cam);
var dx = cam_x - last_cam_x;

for (var i = 0; i < array_length(layers); i++) {
    var L = layers[i];
    L.scrollx += dx * L.factor; // move slower than camera
    layers[i] = L;              // write back (structs copy in arrays)
}

last_cam_x = cam_x;
