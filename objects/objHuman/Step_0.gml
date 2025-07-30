/// @description Insert description here
// You can write your code in this editor
  img_idx_body=image_index;
 img_idx_pants=image_index;
 img_idx_shirt=image_index;
 img_idx_shoes=image_index;
 img_idx_head=0;
 img_idx_nose=0;
 img_idx_eyes=0;
 img_idx_eyelids=0;
 img_idx_nose=0;
 img_idx_hair=0;
 img_idx_hair=0;
 
 // Apply gravity
if !is_on_ground {
    vsp += grav; // Increase vertical speed due to gravity
}
// Move vertically
y += vsp;

// Check for ground collision
if place_meeting(x, y, objSidewalk) {
    // If colliding with the ground, stop falling
    is_on_ground = true;
    vsp = 0; // Reset vertical speed
    y = yprevious; // Adjust position to stop on the ground
} else {
    is_on_ground = false; // Not on the ground
}

 if dir == "left" {
    image_xscale = -1*scale; // Flip the sprite horizontally
} else {
    image_xscale = 1*scale;  // Default orientation
}

image_yscale=scale;
// Step Event

// Example: Basic AI state transitions
if state == "idle" {
    // Randomly decide to start walking
    if irandom_range(0, 100) < 5 {
        state = "walk";
        dir = choose("left", "right");
    }
} else if state == "walk" {
    // Move in the chosen direction
    speed = 2; // Slow speed
    if dir == "left" {
        x -= speed;
    } else if dir == "right" {
        x += speed;
    }

    // Randomly decide to stop walking
    if irandom_range(0, 100) < 2 {
        state = "idle";
        speed = 0;
    }
} else if state == "panic" {
    // Panic behavior: Fast, erratic movement
    speed = 4;
    if dir == "left" {
        x -= speed;
    } else {
        x += speed;
    }

    // Add logic to exit the panic state
    if panic_cooldown <= 0 {
        state = "idle";
        speed = 0;
    } else {
        panic_cooldown -= 1;
    }
}


// If the player is close, panic
if (instance_exists(target))
{
if distance_to_object(target) < 100 {
    state = "panic";
    panic_cooldown = 100; // Number of steps to stay in panic state
    dir = (x < target.x) ? "left" : "right";
}
}




head_x = x + lengthdir_x(78 * scale, 90);
head_y = y + lengthdir_y(78 * scale, 90);

eyes_x = head_x + lengthdir_x(100 * scale, 75);
eyes_y = head_y + lengthdir_y(100 * scale, 75);

eyes_pupils_x = eyes_x + lengthdir_x(50 * scale, 75);
eyes_pupils_y = eyes_y + lengthdir_y(50 * scale, 75);

eyelids_x = eyes_x + lengthdir_x(50 * scale, 75);
eyelids_y = eyes_y + lengthdir_y(50 * scale, 75);
mouth_x = head_x + lengthdir_x(50 * scale, 75);
mouth_y = head_y + lengthdir_y(50 * scale, 75);
nose_x = head_x + lengthdir_x(50 * scale, 75);
nose_y = head_y + lengthdir_y(50 * scale, 75);
eyebrows_x = eyes_x + lengthdir_x(50 * scale, 75);
eyebrows_y = eyes_y + lengthdir_y(50 * scale, 75);
shirt_x = x + lengthdir_x(125 * scale, 85);
shirt_y = y + lengthdir_y(125 * scale, 85);
pants_x = x + lengthdir_x(150 * scale, 75);
pants_y = y + lengthdir_y(150 * scale, 75);
shoes_x = x + lengthdir_x(40 * scale, 270);
shoes_y = y + lengthdir_y(40 * scale, 270);
hair_x = head_x + lengthdir_x(210 * scale, 80);
hair_y = head_y + lengthdir_y(210 * scale, 80);
