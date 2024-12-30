function get_interpolated_color(charge, charge_max) {
    // Normalize the charge to a value between 0 and 1
    var norm_charge = clamp(charge / charge_max, 0, 1);
    
    // Solar star colors using make_color_rgb
    var colors = [
        make_color_rgb(255, 0, 0),      // Red
        make_color_rgb(255, 127, 0),    // Orange
        make_color_rgb(255, 255, 0),    // Yellow
        make_color_rgb(255, 255, 224),  // Yellow-White
        make_color_rgb(255, 255, 255),  // White
        make_color_rgb(127, 127, 255),  // Blue-White-Cyan
        make_color_rgb(0, 0, 255)       // Blue
    ];
    var num_colors = array_length(colors);
    
    // Calculate the segment index
    var segment = floor(norm_charge * (num_colors - 1));
    var t = (norm_charge * (num_colors - 1)) - segment; // Interpolation factor between two colors

    // Get the two colors to interpolate
    var color1 = colors[segment];
    var color2 = colors[min(segment + 1, num_colors - 1)];
    
    // Extract RGB components for interpolation
    var r1 = color_get_red(color1), g1 = color_get_green(color1), b1 = color_get_blue(color1);
    var r2 = color_get_red(color2), g2 = color_get_green(color2), b2 = color_get_blue(color2);
    
    // Interpolate between the two colors
    var r = lerp(r1, r2, t);
    var g = lerp(g1, g2, t);
    var b = lerp(b1, b2, t);
    
    return make_color_rgb(r, g, b);
}
