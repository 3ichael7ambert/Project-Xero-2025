/// ===== BIRD: Draw =====

var base_ang = 0;


// --- BACK WING (behind)
_draw_part(spr_wing_back, wing_img, off_wing_x, off_wing_y, body_angle + wing_angle);

// --- BODY
_draw_part(spr_body, 0, off_body_x, off_body_y, body_angle);

// --- TAIL (slightly behind body center)
_draw_part(spr_tail, 0, off_tail_x, off_tail_y, body_angle + tail_angle);

// --- HEAD
_draw_part(spr_head, 0, off_head_x, off_head_y, head_angle);

// --- EYE (kept simple; could add tiny bob)
_draw_part(spr_eye, 0, off_eye_x, off_eye_y, head_angle);

// --- BEAK (top rotates to “open”)
var beak_top_ang = head_angle + (beak_open ? beak_open_ang : 0);
_draw_part(spr_beak_btm, 0, off_beak_x, off_beak_y, head_angle);
_draw_part(spr_beak_top, 0, off_beak_x, off_beak_y, beak_top_ang);

// --- FRONT WING (in front)
_draw_part(spr_wing_front, wing_img, off_wing_x, off_wing_y, body_angle - wing_angle);
