/// @description Insert description here
// You can write your code in this editor
//x=device_mouse_x(0);
//y=device_mouse_y(0);
//move_towards_point(device_mouse_x,device_mouse_y,100);


// Get the raw mouse position
var mx = device_mouse_raw_x(0);
var my = device_mouse_raw_y(0);

// Get the view dimensions
var view_width = view_get_wport(0);
var view_height = view_get_hport(0);

// Calculate the central safe zone boundaries
var safe_zone_left = view_width * 0.25;
var safe_zone_right = view_width * 0.75;
var safe_zone_top = view_height * 0.25;
var safe_zone_bottom = view_height * 0.75;

// Define panning speed
var pan_speed = 10;

// Check horizontal edge-panning
if (mx < safe_zone_left) {
    x -= pan_speed; // Pan left
} else if (mx > safe_zone_right) {
    x += pan_speed; // Pan right
}

// Check vertical edge-panning
if (my < safe_zone_top) {
    y -= pan_speed; // Pan up
} else if (my > safe_zone_bottom) {
    y += pan_speed; // Pan down
}


