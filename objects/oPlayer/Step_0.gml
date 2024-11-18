// Move left or right
if keyboard_check(vk_left) {
    hsp = -max_speed;
} else if keyboard_check(vk_right) {
    hsp = max_speed;
} else {
    hsp = approach(hsp, 0, friction);
}

// Jump
if place_meeting(x, y+1, oWall) and keyboard_check_pressed(vk_space) {
    vsp = -jump_speed;
}

// Apply gravity
vsp = vsp + gravity;
if vsp > 10 { // Limit fall speed
    vsp = 10;
}

// Move player
move_contact_solid(hsp, vsp);
