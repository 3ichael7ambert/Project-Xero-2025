// Add some randomness to wander
dir += random_range(-wander_jit, wander_jit);

// Smooth turning
direction = lerp(direction, dir, 0.05);

// Move
x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);

// Keep inside room
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    dir = point_direction(x, y, room_width/2, room_height/2);
}

// Optional: avoid solids
if (place_meeting(x, y, objSidewalk)) {
    dir += 180; // turn around
}

