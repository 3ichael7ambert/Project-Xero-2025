/// @desc raycast(x1, y1, x2, y2, wall_obj)
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param wall_obj
///
/// Returns a struct {x, y, dx, dy, obj} where:
/// - (x, y) is the collision point,
/// - (dx, dy) is the reflection direction vector,
/// - obj is the instance of wall_obj that was hit.
/// If no collision, returns noone.

function raycast3(x1, y1, x2, y2, wall_obj) {
    // Quick check for collision
    if (!collision_line(x1, y1, x2, y2, wall_obj, true, false)) {
        return noone;
    }

    var low = 0.0;
    var high = 1.0;
    var iterations = 15;
    for (var i = 0; i < iterations; i++) {
        var mid = (low + high) * 0.5;
        var mx = x1 + (x2 - x1) * mid;
        var my = y1 + (y2 - y1) * mid;
        
        if (collision_line(x1, y1, mx, my, wall_obj, true, false)) {
            high = mid;
        } else {
            low = mid;
        }
    }
    var final_t = (low + high) * 0.5;
    var cx = x1 + (x2 - x1) * final_t;
    var cy = y1 + (y2 - y1) * final_t;
    
    // Determine the normal vector by probing around the collision point
    var eps = 1;
    // We'll check horizontally and vertically:
    var inside_left = collision_point(cx - eps, cy, wall_obj, true, false);
    var inside_right = collision_point(cx + eps, cy, wall_obj, true, false);
    var inside_up = collision_point(cx, cy - eps, wall_obj, true, false);
    var inside_down = collision_point(cx, cy + eps, wall_obj, true, false);
    
    var nx = 0;
    var ny = 0;
    
    // Horizontal normal check
    if (inside_left && !inside_right) {
        // Wall is to the left side, normal points right
        nx = 1;
        ny = 0;
    } else if (inside_right && !inside_left) {
        // Wall is to the right side, normal points left
        nx = -1;
        ny = 0;
    }

    // Vertical normal check (only if we haven't decided horizontally)
    if (nx == 0 && ny == 0) {
        if (inside_up && !inside_down) {
            // Wall is above, normal points down
            nx = 0;
            ny = 1;
        } else if (inside_down && !inside_up) {
            // Wall is below, normal points up
            nx = 0;
            ny = -1;
        }
    }

    // If we still don't have a normal (edge case), just assume a default (e.g., normal up)
    if (nx == 0 && ny == 0) {
        nx = 0;
        ny = -1;
    }

    // Normalize incoming direction vector
    var dx_in = x2 - x1;
    var dy_in = y2 - y1;
    var length_in = sqrt(dx_in*dx_in + dy_in*dy_in);
    if (length_in != 0) {
        dx_in /= length_in;
        dy_in /= length_in;
    }

    // Reflect v_in about n: v_reflect = v_in - 2*(v_in·n)*n
    var dot = dx_in*nx + dy_in*ny; 
    var dx_reflect = dx_in - 2 * dot * nx;
    var dy_reflect = dy_in - 2 * dot * ny;

    // Identify the collision object at (cx, cy)
    var obj_hit = instance_position(cx, cy, wall_obj);
    
    // Return struct with collision object
    return {
        x: cx,
        y: cy,
        dx: dx_reflect,
        dy: dy_reflect,
        obj: obj_hit
    };
}