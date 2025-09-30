/// objKaijuDragon : Draw
if (dead) exit;




// Shadow pass (unchanged)
var sh = shadow_alpha;
draw_set_alpha(sh);
for (var i = seg_count-1; i >= 0; i--) {
    //draw_sprite_ext(spr_seg, 0, seg_x[i]+6, seg_y[i]+12, scale, scale, seg_a[i], c_black, 1);
}
draw_set_alpha(1);

// --- BODY + BELLY ---
// Drawing tail->head to overlap nicely
var body_frames = sprite_get_number(spr_seg); // you said 3
for (var i = seg_count-1; i >= 1; i--) {

    // ----- roll per segment -> sprite frame selection -----
    // lock the neck roll to 0 (i==1, optionally i<2..3)
    var roll_deg = (i <= 1) ? 0 : seg_roll[i];

    // BODY: map roll to 3 frames; advance “rotation” along body
    // Using both index and roll gives the illusion of twist traveling
    var body_idx = ((i + floor(abs(roll_deg) * 0.05)) mod body_frames);

    // BELLY: 80 frames — map roll into 0..79
    var belly_idx;
    if (i <= 1) {
        belly_idx = 0; // neck stays neutral
    } else {
        // normalize roll to 0..1, wrap, then scale to frames
        var u = frac((roll_deg / 360) + 1); // make sure positive
        belly_idx = clamp(floor(u * belly_frames), 0, belly_frames-1);
    }

   // Draw body segment on top
    draw_sprite_ext(spr_seg, body_idx, seg_x[i], seg_y[i], scale, scale, seg_a[i], c_white, 1);


    // Draw belly first (underlay). You can tint it slightly darker if you like.
    draw_sprite_ext(spr_belly, belly_idx, seg_x[i], seg_y[i], scale, scale, seg_a[i], c_white, 1);

 }

// Head (keeps stable roll look by using frame 0)
draw_sprite_ext(spr_head, 0, seg_x[0], seg_y[0], scale, scale, seg_a[0], c_white, 1);

// Tail cap (optional)
draw_sprite_ext(spr_tail, 0, seg_x[seg_count-1], seg_y[seg_count-1], scale, scale, seg_a[seg_count-1], c_white, 1);
