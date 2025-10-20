/// obj_cave_extractor_sky.Create — single Tile3d aggregator for skyline
alarm[0] = 1;

builder      = new Tile3d();
mesh_dirty   = true;     // build once at start
default_w    = 64;
default_h    = 64;

light_target_x = camera_get_view_x(0);
light_target_y = camera_get_view_y(0);

// tiny helpers
function _clamp(v,a,b){ return max(a, min(b, v)); }
function hash01(a,b,c,d) {
    var xh = (a * 73856093) ^ (b * 19349663) ^ (c * 83492791) ^ (d * 2654435761);
    xh = (xh ^ (xh << 13)) & $ffffffff;
    xh = (xh ^ (xh >> 17)) & $ffffffff;
    xh = (xh ^ (xh << 5 )) & $ffffffff;
    return (xh & $7fffffff) / 2147483647;
}
