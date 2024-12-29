// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_interpolated_color(charge, charge_max) {
    // Normalize the charge to a value between 0 and 1
    var norm_charge = clamp(charge / charge_max, 0, 1);
    
    // Solar star colors in order
    var colors = [$FF0000, $FF7F00, $FFFF00, $FFFFE0, $FFFFFF, $7F7FFF, $0000FF];
    var num_colors = array_length(colors);
    
    // Calculate the segment index
    var segment = floor(norm_charge * (num_colors - 1));
    var t = (norm_charge * (num_colors - 1)) - segment; // Interpolation factor between two colors

    // Get the two colors to interpolate
    var color1 = colors[segment];
    var color2 = colors[min(segment + 1, num_colors - 1)];
    
    // Interpolate between the two colors
    var r1 = (color1 >> 16) & 0xFF, g1 = (color1 >> 8) & 0xFF, b1 = color1 & 0xFF;
    var r2 = (color2 >> 16) & 0xFF, g2 = (color2 >> 8) & 0xFF, b2 = color2 & 0xFF;
    
    var r = lerp(r1, r2, t);
    var g = lerp(g1, g2, t);
    var b = lerp(b1, b2, t);
    
    return make_color_rgb(r, g, b);
}