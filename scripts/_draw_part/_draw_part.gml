// Helper to draw a part with offset + local angle
function _draw_part(_spr, _sub, _ox, _oy, _ang){
	var sx = image_xscale; // includes dir*scale
	var sy = image_yscale;
    var dx = _ox * sx;
    var dy = _oy * sy;
    draw_sprite_ext(_spr, _sub, x + dx, y + dy, sx, sy, _ang, c_white, 1);
}