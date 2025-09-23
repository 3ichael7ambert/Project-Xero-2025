/// ===== objKaiju : Draw =====

// Root never draws (controller only)
if (is_root) exit;

// -------------------------------------------------
// Generic part drawing (mech & dragon segments/head)
// -------------------------------------------------
image_xscale=scale;
image_yscale=scale;
// Basic sprite
if (sprite_index >= 0) {
    draw_sprite_ext(
        sprite_index,
        image_index,
        x, y,
        image_xscale, image_yscale,
        image_angle,
        c_white,
        image_alpha
    );
}

/*
/// objKaiju : Draw
if (is_root) {
    // Example mech order: back parts first → core → front parts
    var order = [
        "wingL", "wingR",
        "thighL", "calfL", "footL",
        "thighR", "calfR", "footR",
        "torsoL", "torsoU",
        "armU_L", "armL_L", "handL",
        "armU_R", "armL_R", "handR",
        "head"
    ];

    for (var i = 0; i < array_length(order); i++) {
        var nm = order[i];
        if (ds_map_exists(parts_by_name, nm)) {
            var prt = parts_by_name[? nm];
            if (instance_exists(prt)) with (prt) {
                if (sprite_index >= 0) {
                    draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, 1);
                }
            }
        }
    }
}


// -------------------------------------------------
// Optional: hit flash when damaged
// -------------------------------------------------
if (hit_time > 0) {
    draw_set_blend_mode(bm_add);
    draw_sprite_ext(
        sprite_index,
        image_index,
        x, y,
        image_xscale, image_yscale,
        image_angle,
        c_red,
        0.5
    );
    draw_set_blend_mode(bm_normal);
}

// -------------------------------------------------
// Optional: HP bar (above each part)
// -------------------------------------------------
if (hp_max > 1) {
    var bar_w = 32;
    var bar_h = 4;
    var hp_ratio = clamp(hp / hp_max, 0, 1);
    var bx = x - bar_w/2;
    var by = y - sprite_height/2 - 8;

    draw_set_color(c_black);
    draw_rectangle(bx-1, by-1, bx+bar_w+1, by+bar_h+1, false);

    draw_set_color(c_red);
    draw_rectangle(bx, by, bx + bar_w * hp_ratio, by + bar_h, false);

    draw_set_color(c_white);
}
