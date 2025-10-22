/// Draw
var cam   = view_camera[0];
var vx    = camera_get_view_x(cam);
var vy    = camera_get_view_y(cam);
var vw    = camera_get_view_width(cam);
var vh    = camera_get_view_height(cam);

// choose dimensions + draw proc depending on sprite vs background
var draw_fn, tile_w, tile_h;
if (use_sprite) {
    tile_w = sprite_get_width(spr_or_bg);
    tile_h = sprite_get_height(spr_or_bg);
    draw_fn = function(xx,yy){
        draw_sprite_ext(spr_or_bg, 0, xx, yy, 1, 1, 0, col, alp);
    };
} else {
    tile_w = background_get_width(spr_or_bg);
    tile_h = background_get_height(spr_or_bg);
    draw_fn = function(xx,yy){
        draw_background_ext(spr_or_bg, xx, yy, 1, 1, 0, col, alp);
    };
}

// world-space offset for this layer (camera parallax + autoscroll)
var layer_x_ = vx * parx + t_accum_x;
var layer_y_ = vy * pary + t_accum_y;

// wrap so a tile always starts on-screen
var ox = -frac(layer_x_ / tile_w) * tile_w;
var oy = -frac(layer_y_ / tile_h) * tile_h;

// tile enough to cover view (one extra tile as guard)
for (var xx = ox - tile_w; xx < vw + tile_w; xx += tile_w) {
    for (var yy = oy - tile_h; yy < vh + tile_h; yy += tile_h) {
        draw_fn(vx + xx, vy + yy);
    }
}
