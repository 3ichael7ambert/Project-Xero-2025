// objParallaxSide Step Event

/// @description Move with view
var x_diff = __view_get(e__VW.XView, 0) - previous_xview;
var y_diff = __view_get(e__VW.YView, 0) - previous_yview;

// Only update x position
x += x_diff * x_follow + x_speed;
previous_xview = __view_get(e__VW.XView, 0);
previous_yview = __view_get(e__VW.YView, 0);

// Limit vertical movement to the top and bottom edges of the tiles
y = clamp(y, 0, room_height - sprite_height);

// Draw the background
