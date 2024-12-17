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

    // Push the starting point
    array_push(points, [x1, y1]);

    while (bounces < max_bounces) {
        // Calculate the endpoint for the ray
        var x2 = x1 + lengthdir_x(10000, angle);
        var y2 = y1 + lengthdir_y(10000, angle);

        // Perform raycast
        var collision = raycast(x1, y1, x2, y2, wall_obj);
        if (collision == -1) {
            // No collision, stop
            array_push(points, [x2, y2]);
            break;
        }

        // Add collision point to the array
        array_push(points, collision);

        // Calculate the reflection angle
        var normal_angle = point_direction(collision[0], collision[1], x1, y1);
        angle = 2 * normal_angle - angle;

        // Slightly offset start point to prevent re-collision
        x1 = collision[0] + lengthdir_x(1, angle);
        y1 = collision[1] + lengthdir_y(1, angle);

        bounces++;
    }

    return points;
}
