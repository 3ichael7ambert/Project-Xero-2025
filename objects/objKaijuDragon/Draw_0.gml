/// objKaijuDragon : Draw

if (dead) exit;

// Shadow (subtle)
var sh = shadow_alpha;
draw_set_alpha(sh);
for (var i = seg_count-1; i >= 0; i--) {
    draw_sprite_ext(spr_seg, 0, seg_x[i]+6, seg_y[i]+12, 1, 1, seg_a[i], c_black, 1);
}
draw_set_alpha(1);

// Body from tail -> head for nicer overlap
for (var i = seg_count-1; i >= 1; i--) {
    draw_sprite_ext(spr_seg, (i % sprite_get_number(spr_seg)), seg_x[i], seg_y[i], 1, 1, seg_a[i], c_white, 1);
}

// Head
draw_sprite_ext(spr_head, 0, seg_x[0], seg_y[0], 1, 1, seg_a[0], c_white, 1);

// Tail cap (optional – draws over last segment)
draw_sprite_ext(spr_tail, 0, seg_x[seg_count-1], seg_y[seg_count-1], 1, 1, seg_a[seg_count-1], c_white, 1);
