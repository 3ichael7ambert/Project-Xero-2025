// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function patrol() {
    var target_x = patrol_points[patrol_index][0];
    var target_y = patrol_points[patrol_index][1];

    move_toward_point(target_x, target_y, move_speed);

    if (point_distance(x, y, target_x, target_y) < 5) {
        patrol_index = (patrol_index + 1) mod array_length(patrol_points);
    }
}


function follow_player() {
    // Jetpack behavior variation
    if (jetpack_type == "basic") {
        move_toward_point(player.x, player.y, move_speed);
    }
    else if (jetpack_type == "aggressive") {
        // Fast bursts
        if (random(1) < 0.1) {
            move_toward_point(player.x, player.y, move_speed + 2);
        } else {
            move_toward_point(player.x, player.y, move_speed);
        }
    }
    else if (jetpack_type == "hover") {
        // Smooth glide with lerp
        x = lerp(x, player.x, 0.05);
        y = lerp(y, player.y, 0.05);
    }
}

function attack_player() {
    switch (weapon_type) {
        case "laser":
            instance_create_layer(x, y, "Bullets", objBullet_Enemy);
            break;
        case "rocket":
            instance_create_layer(x, y, "Bullets", objBullet_Enemy);
            break;
        case "blaster":
            instance_create_layer(x, y, "Bullets", objBullet_Enemy);
            break;
    }
}

////////////////////////////////////////////

function can_see_target(obj_wall) {
    if (!instance_exists(target)) return false;

    var _x1 = x;
    var _y1 = y;
    var _x2 = target.x;
    var _y2 = target.y;

    // Replace obj_wall with whatever blocks sight
   var _hit = collision_line(_x1, _y1, _x2, _y2, obj_wall, false, true);
    
    return (_hit == noone);
}
