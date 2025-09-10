/// helper
function _draw_bird_part(_spr, _sub, _ox, _oy, _ang) {
    var sx = image_xscale;   // = dir * scale
    var sy = image_yscale;   // = scale
    var dx = _ox * sx;       // flip + scale in X
    var dy = _oy * sy;       // scale in Y
	shader_hue_start(col);
    draw_sprite_ext(_spr, _sub, x + dx, y + dy, sx, sy, _ang, c_white, 1);
	//shader_reset();
}
