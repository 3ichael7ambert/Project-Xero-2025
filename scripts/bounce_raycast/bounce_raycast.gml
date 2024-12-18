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

    // Add the starting point
    array_push(points, [x1, y1]);

    while (bounces < max_bounces) {
        // Calculate a far endpoint for the ray
        var x2 = x1 + lengthdir_x(10000, angle);
        var y2 = y1 + lengthdir_y(10000, angle);

        // Perform raycast
        var collision = raycast(x1, y1, x2, y2, wall_obj);
        if (collision == -1) {
            // No collision; add the end point and break
            array_push(points, [x2, y2]);
            break;
        }

        // Add the collision point to the path
        array_push(points, collision);

        // Calculate the surface normal and reflection angle
        var normal_angle = point_direction(collision[0], collision[1], x1, y1);
        angle = 2 * normal_angle - angle;

        // Debug: Log reflection angle
        show_debug_message("Bounce " + string(bounces + 1) + ": Reflection angle = " + string(angle));

        // Apply a larger offset to move away from the collision point
        x1 = collision[0] + lengthdir_x(15, angle); // Offset by 5 pixels
        y1 = collision[1] + lengthdir_y(15, angle);

        // Check if the offset moves the ray out of collision
        if (collision_point(x1, y1, wall_obj, true, false)) {
            show_debug_message("Stuck in collision! Adjusting offset further.");
            x1 += lengthdir_x(5, angle); // Offset further if still in collision
            y1 += lengthdir_y(5, angle);
        }

        // Increment bounce count
        bounces++;
    }

    return points;
}
