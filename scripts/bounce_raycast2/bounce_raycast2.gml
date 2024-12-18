
/// @desc raycast_bounce(x1, y1, x2, y2, bounces, wall_obj)
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param bounces
/// @param wall_obj
///
/// Returns an array of [x,y] points for each hit, and the final endpoint.

function raycast_bounce2(x1, y1, x2, y2, bounces, wall_obj) {
    var result_points = [[x1,y1]];
    var total_dist = point_distance(x1, y1, x2, y2);
    if (total_dist == 0) {
        // Start and end are the same point
        array_push(result_points, [x1, y1]);
        return result_points;
    }
    
    // Initial direction
    var dx = (x2 - x1) / total_dist;
    var dy = (y2 - y1) / total_dist;
    
    var sx = x1;
    var sy = y1;
    
    // We allow up to `bounces` reflections.
    for (var i = 0; i <= bounces; i++) {
        // Calculate the end point if no collision happens
        var ex = sx + dx * total_dist;
        var ey = sy + dy * total_dist;
        
        var collision = raycast2(sx, sy, ex, ey, wall_obj);
        if (collision == noone) {
            // No collision, just push the end point
            array_push(result_points, [ex, ey]);
            return result_points;
        } else {
            // Collision occurred
            var cx = collision.x;
            var cy = collision.y;
            // Record the collision point
            array_push(result_points, [cx, cy]);
            
            // Distance traveled so far
            var dist_traveled = point_distance(sx, sy, cx, cy);
            total_dist -= dist_traveled;
            
            if (i == bounces) {
                // No more bounces allowed, end here
                return result_points;
            }
            
            // Reflect direction
            dx = collision.dx;
            dy = collision.dy;
            
            // Continue from collision point
            sx = cx;
            sy = cy;
        }
    }
    
    // If we exit the loop naturally, it means we've done all bounces and ended
    // But typically we'd have returned inside the loop. Just in case:
    var final_x = sx + dx * total_dist;
    var final_y = sy + dy * total_dist;
    array_push(result_points, [final_x, final_y]);
    return result_points;
}
