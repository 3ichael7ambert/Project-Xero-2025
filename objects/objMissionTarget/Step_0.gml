// Add some randomness to wander
if (species=="bird") {
	scr_bird_step();
	
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
}

if (species=="balloon") {
	t += 1 / max(1, room_speed);
	x = x_anchor + sin(t * sway_freq) * sway_amp;   // gentle wind sway
	y_anchor -= rise_speed;                         // climb
	depth = -y_anchor;
	if (y_anchor < -64) instance_destroy();


}