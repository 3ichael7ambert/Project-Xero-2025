/// objEnemy_mv.Draw

// --- color variants based on enemy mode ---
var col = c_white;

switch (mode) {
    case ENEMY_MV_MODE.SKY_DRILL:      col = make_color_rgb(255, 230, 50);  break; // yellow-gold
    case ENEMY_MV_MODE.LAVA_BALL:      col = make_color_rgb(255, 80, 0);    break; // lava red/orange
    case ENEMY_MV_MODE.BOUNCER_CHASE:  col = make_color_rgb(120, 255, 120); break; // greenish goo
    case ENEMY_MV_MODE.HOMER_STRAIGHT: col = make_color_rgb(90, 180, 255);  break; // blue ghost
    case ENEMY_MV_MODE.HOMER_DRIFT:    col = make_color_rgb(150, 150, 255); break; // pale blue
    case ENEMY_MV_MODE.GRAV_SWITCHER:  col = make_color_rgb(255, 180, 255); break; // pink-purple crawler
    case ENEMY_MV_MODE.POT_TURRET:     col = make_color_rgb(200, 200, 200); break; // metallic gray
}

// --- elite tint overlay ---
if (elite) {
    col = merge_color(col, make_color_rgb(255, 255, 150), 0.5);
}

// --- Draw main sprite ---
draw_sprite_ext(sprite_index, 0, x, y, scale, scale, image_angle, col, 1);

// --- Optional: additive glow for elites ---
if (elite) {
    draw_set_blend_mode(bm_add);
    draw_sprite_ext(sprite_index, 0, x, y, scale * 1.05, scale * 1.05, image_angle, col, 0.25);
    draw_set_blend_mode(bm_normal);
}
