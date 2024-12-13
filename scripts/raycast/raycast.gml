/// @desc raycast(x1, y1, x2, y2, wall_obj)
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param wall_obj
///
/// Returns the [collision_x, collision_y] if a collision occurs, otherwise returns noone.
function raycast(x1, y1, x2, y2, wall_obj) {
    // First, quickly check if there's any collision at all.
    if (!collision_line(x1, y1, x2, y2, wall_obj, true, false)) {
        return -1; // No collision, exit early.
    }
    
    var low = 0.0;
    var high = 1.0;
    var iterations = 15; // Number of binary search steps (adjust for precision)
    
    for (var i = 0; i < iterations; i++) {
        var mid = (low + high) * 0.5;
        
        // Calculate midpoint coordinates
        var mx = x1 + (x2 - x1) * mid;
        var my = y1 + (y2 - y1) * mid;
        
        // Check collision from start point to midpoint
        if (collision_line(x1, y1, mx, my, wall_obj, true, false)) {
            // Collision is closer to the start, move the search high end
            high = mid;
        } else {
            // No collision up to midpoint, so collision must be farther along the line
            low = mid;
        }
    }
    
    // After iterations, low and high are very close. We can pick either low or high.
    var final_t = (low + high) * 0.5;
    var final_x = x1 + (x2 - x1) * final_t;
    var final_y = y1 + (y2 - y1) * final_t;

    return [final_x, final_y];
}
