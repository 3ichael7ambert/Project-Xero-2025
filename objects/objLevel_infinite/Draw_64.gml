/// @description Kingdom Hearts-style circular health bar with spr_head in center (no ternary)


///
var hp=50;
var maxhp=100;
var spr_head=sprHead;
///


var cx = display_get_gui_width() * 0.5;
var cy = display_get_gui_height() - 100;

var radius = 64; // Radius of health arc
var hp_ratio = clamp(hp / maxhp, 0, 1);


var segments = 100;       // Smoothness of arc
var angle_range = 270;    // Arc coverage
var start_angle = -135;   // Arc begins left side, wraps clockwise

// Draw head sprite at center
draw_sprite_ext(spr_head, 0, cx, cy,.8,.8,0,c_white,1);

// Decide color based on HP ratio
var col;
if (hp_ratio > 0.5) {
    col = c_lime;
} else if (hp_ratio > 0.25) {
    col = c_yellow;
} else {
    col = c_red;
}
draw_set_color(col);

// End angle based on hp
var end_angle = start_angle + angle_range * hp_ratio;

// Draw the health arc
for (var i = 0; i < segments; i++) {
    var a0 = start_angle + (angle_range / segments) * i;
    var a1 = start_angle + (angle_range / segments) * (i + 1);

    if (a1 > end_angle) {
        break;
    }

    var x0 = cx + lengthdir_x(radius, a0);
    var y0 = cy + lengthdir_y(radius, a0);
    var x1 = cx + lengthdir_x(radius, a1);
    var y1 = cy + lengthdir_y(radius, a1);

    draw_triangle(cx, cy, x0, y0, x1, y1, false);
}
