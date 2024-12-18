
/// @desc raycast_bounce(x1, y1, x2, y2, bounces, wall_obj)
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param bounces
/// @param wall_obj
///
/// Returns an array of structs, each containing:
/// - x: Collision or end point x-coordinate
/// - y: Collision or end point y-coordinate
/// - obj: The instance of wall_obj that was hit (noone for end points)

function raycast_bounce3(x1, y1, x2, y2, bounces, wall_obj) {
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
    
    var remaining_dist = total_dist;
    
    var last_deactivated = noone; // To keep track of the last deactivated object

    // We allow up to `bounces` reflections.
    for (var i = 0; i < bounces; i++) {
        // Calculate the potential end point based on remaining distance
        var ex = sx + dx * remaining_dist;
        var ey = sy + dy * remaining_dist;
        
        // Perform raycast
        var collision = raycast3(sx, sy, ex, ey, wall_obj);
        
        if (collision == noone) {
            // No collision, add the final end point and exit the loop
            array_push(result_points, [ex, ey]);
            break;
        } else {
            // Collision occurred
            var cx = collision.x;
            var cy = collision.y;
            var obj_hit = collision.obj;
            
            // Record the collision point and object
            array_push(result_points, [cx, cy]);
            
            // Manage object activation/deactivation
            if (last_deactivated != noone) {
                instance_activate_object(last_deactivated);
            }
            if (obj_hit != noone) {
                instance_deactivate_object(obj_hit);
                last_deactivated = obj_hit;
            }
            
            // Calculate the distance traveled to the collision point
            var dist_traveled = point_distance(sx, sy, cx, cy);
            remaining_dist -= dist_traveled;
            
            if (remaining_dist <= 0) {
                // No remaining distance to travel
                break;
            }
            
            // Update direction based on reflection
            dx = collision.dx;
            dy = collision.dy;
            
            // Update starting point for the next bounce
            sx = cx;
            sy = cy;
        }
    }
    
    // After handling all bounces, calculate the final end point if there's remaining distance
    if (remaining_dist > 0) {
        var final_ex = sx + dx * remaining_dist;
        var final_ey = sy + dy * remaining_dist;
        array_push(result_points, [final_ex, final_ey]);
    }
    
    // Reactivate the last deactivated object before exiting
    if (last_deactivated != noone) {
        instance_activate_object(last_deactivated);
    }
    
    return result_points;
}
