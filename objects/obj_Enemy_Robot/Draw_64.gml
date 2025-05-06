/// @description Insert description here
// You can write your code in this editor
// Get camera bounds
/*
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
*/

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
