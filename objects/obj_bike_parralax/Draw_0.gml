/// Parallax BG: Draw
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var vw    = camera_get_view_width(cam);
var vh    = camera_get_view_height(cam);

for (var i = 0; i < array_length(layers); i++) {
    var L = layers[i];
    if (L.spr == noone) continue;

    var sw = sprite_get_width (L.spr)  * L.sx;
    var sh = sprite_get_height(L.spr)  * L.sy;

    // Start tiling a bit left of view so we fill the whole screen
    var start_x = floor((cam_x - L.scrollx) / sw) * sw + L.scrollx;
    var yy = cam_y + L.y;

    draw_set_alpha(L.alpha);

    // Tile horizontally across the view
    var xx = start_x;
    while (xx < cam_x + vw) {
       draw_sprite_ext(L.spr, 0, xx, yy, L.sx, L.sy, 0, c_white, 1);
        xx += sw;
    }
}

draw_set_alpha(1);
