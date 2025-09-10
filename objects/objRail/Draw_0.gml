// In obj_rail Draw Event
var segs = ceil(length / 64); // How many 64px tiles
for (var i = 0; i < segs; i++) {
    draw_sprite(spr_grind_rail, 0, x + i * 64, y);
}
