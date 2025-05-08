/// @description Insert description here
// You can write your code in this editor
// Get camera bounds
/*
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
*/



/*
////OLD FLAT
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

// Player world position
var px = x;
var py = y;

// Only draw if offscreen
if (px < vx || px > vx + vw || py < vy || py > vy + vh) {

    // Screen center
    var cx = vx + vw * 0.5;
    var cy = vy + vh * 0.5;

    // Direction toward player
    var angle = point_direction(cx, cy, px, py);
    var dx = lengthdir_x(1, angle);
    var dy = lengthdir_y(1, angle);

    // Initialize t_x and t_y to -1 (will be replaced)
    var t_x, t_y;

    // Determine horizontal intersection
    if (dx > 0) {
        t_x = (vx + vw - cx) / dx;
    } else if (dx < 0) {
        t_x = (vx - cx) / dx;
    } else {
        t_x = -1;
    }

    // Determine vertical intersection
    if (dy > 0) {
        t_y = (vy + vh - cy) / dy;
    } else if (dy < 0) {
        t_y = (vy - cy) / dy;
    } else {
        t_y = -1;
    }

    // Choose the smallest positive t (closest screen edge)
    var t;
    if (t_x > 0 && t_y > 0) {
        t = min(t_x, t_y);
    } else if (t_x > 0) {
        t = t_x;
    } else {
        t = t_y;
    }

    t -= 8; // Margin from edge

    // World space edge location
    var bx = cx + dx * t;
    var by = cy + dy * t;

    // GUI-space position
    var gx = bx - vx;
    var gy = by - vy;

    // Draw bubble
	
//	draw_set_alpha(.5);
	//draw_circle_colour(gx,gy,(sprite_get_width(sprite_index)/2),color1,color2,false);
	draw_set_alpha(1);
    draw_sprite_ext(sprite_head, image_angle, gx, gy, scale, scale, angle, c_white, 1);
	draw_set_colour(c_white);
	draw_circle(gx,gy,((sprite_get_width(sprite_index)*scale)),true);
	

    // Optional: draw label
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
  //  draw_text(gx, gy, "ENEMY");
}
*/








/*

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

var px = x;
var py = y;

var is_offscreen = (px < vx || px > vx + vw || py < vy || py > vy + vh);

// Screen center
var cx = vx + vw * 0.5;
var cy = vy + vh * 0.5;

// Direction from center to player
var angle = point_direction(cx, cy, px, py);
var dx = lengthdir_x(1, angle);
var dy = lengthdir_y(1, angle);

// Compute edge intersection
var t_x = -1, t_y = -1;
if (dx > 0) t_x = (vx + vw - cx) / dx;
else if (dx < 0) t_x = (vx - cx) / dx;
if (dy > 0) t_y = (vy + vh - cy) / dy;
else if (dy < 0) t_y = (vy - cy) / dy;

var t = (t_x > 0 && t_y > 0) ? min(t_x, t_y) : max(t_x, t_y);
t = max(t - 8, 0); // margin from screen edge

// Final world position
var bx = cx + dx * t;
var by = cy + dy * t;

// GUI-space
var gx = bx - vx;
var gy = by - vy;

// === VISUAL EFFECTS ===

// Fade in/out alpha
if (is_offscreen) {
    bubble_visible = true;
    bubble_alpha = clamp(bubble_alpha + 0.1, 0, 1);
    bubble_scale = lerp(bubble_scale, bubble_target_scale, 0.1);
} else {
    bubble_alpha = clamp(bubble_alpha - 0.1, 0, 1);
    bubble_scale = lerp(bubble_scale, 0, 0.1);
    if (bubble_alpha <= 0.01) bubble_visible = false;
}

// Skip drawing if not visible
if (!bubble_visible) exit;

// Pulse size based on distance from center
var dist = point_distance(cx, cy, px, py);
var pulse = 0.05 * sin(current_time * 0.005 + bubble_pulse_offset);
var final_scale = bubble_scale + pulse * (dist / 300); // pulse strength by distance

// === DRAW INDICATOR ===

// Transparent glowing inner circle
draw_set_alpha(bubble_alpha * 0.4);
draw_circle_colour(gx, gy, (sprite_get_width(sprite_head) * final_scale) * 0.5, c_white, c_white, false);

// Draw bubble sprite
draw_set_alpha(bubble_alpha);
draw_sprite_ext(sprite_head, image_index, gx, gy, final_scale, final_scale, angle, c_white, 1);

// Outline ring
draw_set_alpha(bubble_alpha);
draw_set_color(c_white);
draw_circle(gx, gy, (sprite_get_width(sprite_head) * final_scale) * 0.5, true);

// Label (optional)
draw_set_alpha(bubble_alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
// draw_text(gx, gy, "ENEMY");

// Reset alpha
draw_set_alpha(1);
*/

// === CAMERA AND PLAYER POSITION ===
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

var px = x;
var py = y;

var is_offscreen = (px < vx || px > vx + vw || py < vy || py > vy + vh);

var cx = vx + vw * 0.5;
var cy = vy + vh * 0.5;

var angle = point_direction(cx, cy, px, py);
var dx = lengthdir_x(1, angle);
var dy = lengthdir_y(1, angle);

// === SCREEN EDGE INTERSECTION ===
var t_x = -1, t_y = -1;
if (dx != 0) t_x = (dx > 0) ? (vx + vw - cx) / dx : (vx - cx) / dx;
if (dy != 0) t_y = (dy > 0) ? (vy + vh - cy) / dy : (vy - cy) / dy;

var t = (t_x > 0 && t_y > 0) ? min(t_x, t_y) : max(t_x, t_y);
t = max(t - 16, 0); // buffer from screen edge

var bx = cx + dx * t;
var by = cy + dy * t;

var gx = bx - vx;
var gy = by - vy;

// === FADE AND SCALE ===
if (is_offscreen) {
    bubble_visible = true;
    bubble_alpha = clamp(bubble_alpha + 0.05, 0, 1);
    bubble_scale = lerp(bubble_scale, bubble_target_scale, 0.1);
} else {
    bubble_alpha = clamp(bubble_alpha - 0.05, 0, 1);
    bubble_scale = lerp(bubble_scale, 0, 0.1);
    if (bubble_alpha <= 0.01) bubble_visible = false;
}

if (!bubble_visible) exit;

// === BUBBLE ANIMATION ===
var dist = point_distance(cx, cy, px, py);
var pulse = 0.1 * sin(current_time * 0.008 + bubble_pulse_offset); // faster sine
var dist_mod = clamp(dist / 500, 0.5, 1.5);
var final_scale = bubble_scale + pulse * dist_mod;

// === DRAWING ===
var base_radius = sprite_get_width(sprite_head) * 0.5 * final_scale;

// Glowing pulsing aura
draw_set_alpha(bubble_alpha * 0.3);
draw_circle_colour(gx, gy, base_radius + 2, c_white, c_white, false);

// Bubble image
draw_set_alpha(bubble_alpha);

// Offset to center the head (if origin is neck/bottom-center)
var head_offset_y = sprite_get_height(sprite_head) * 0.5 * final_scale;
var eyes_offset_x = (sprite_get_height(sprite_head)-80) * 0.5 * final_scale;
var eyes_offset_y = (sprite_get_width(sprite_head)-85) * 0.5 * final_scale;

// Draw centered head
draw_sprite_ext(sprite_head, image_index, gx, gy + head_offset_y, final_scale, final_scale, 0, c_white, 1);
// Draw eyes aligned with head
draw_sprite_ext(sprite_eyes, image_index, gx + eyes_offset_x, gy + eyes_offset_y, final_scale, final_scale, 0, c_white, 1);


// Outer ring
draw_set_alpha(bubble_alpha);
draw_set_color(c_white);
draw_circle(gx, gy, base_radius, true);

// Label (if needed)
// draw_text(gx, gy - base_radius - 8, "ENEMY");

// Reset alpha
draw_set_alpha(1);



