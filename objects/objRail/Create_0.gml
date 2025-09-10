// Direction/slope for movement
switch (image_index) {
    case 0:
        grind_angle = 0;    // Horizontal
        break;
    case 1:
        grind_angle = -26.565; // Approx 26.5° upward (atan2(-32,64))
        break;
    case 2:
        grind_angle = 26.565;  // Approx 26.5° downward
        break;
}

// Optional: custom speed on each segment
grind_speed = 6;
