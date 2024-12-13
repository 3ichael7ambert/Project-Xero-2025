/// @desc bounce_raycast(x1, y1, angle, max_bounces, wall_obj)
/// @param x1
/// @param y1
/// @param angle
/// @param max_bounces
/// @param wall_obj
///
/// Returns an array of collision points tracing the laser's path with bounces.

function bounce_raycast(x1, y1, angle, max_bounces, wall_obj) {
    var points = [];
    var bounces = 0;

    while (bounces < max_bounces) {
        // Calculate the end point for the current ray
        var x2 = x1 + lengthdir_x(10000, angle); // Extend far enough for collisions
        var y2 = y1 + lengthdir_y(10000, angle);
        
        // Perform raycasting
        var collision = raycast(x1, y1, x2, y2, wall_obj);
        if (collision == -1) {
            // No collision, terminate the path
            break;
        }
        
        // Store the collision point
        array_push(points, collision);
        
        // Get the surface normal at the collision point
        var normal_angle = point_direction(collision[0], collision[1], x1, y1);
        
        // Reflect the angle: reflection = 2 * normal - angle
        angle = 2 * normal_angle - angle;
        
        // Update the starting point for the next ray
        x1 = collision[0];
        y1 = collision[1];
        
        // Increment bounce counter
        bounces += 1;
    }

    // Return the array of collision points
    return points;
}
