function scr_timeofday_background_init(){

 blended_color=c_white;
blend_factor=current_minute/60;


// Create Event
color1 = make_color_rgb(87, 141, 191); // Blue
color2 = make_color_rgb(11, 37, 61); // Navy
color3 = make_color_rgb(239, 192, 50); // Yellow
color4 = make_color_rgb(239, 64, 158); // Red
color5 = make_color_rgb(5,5,15); //black
color6 = make_color_rgb(97, 151, 210); //  Light Blue
blended_color=color1;


if current_hour>=0 && current_hour<6 {
    blended_color = merge_color(color5,color2,blend_factor);
}
else if current_hour>=6 && current_hour<7 {
    blended_color = merge_color(color2,color4,blend_factor);
}
else if current_hour>=7 && current_hour<8 {
    blended_color = merge_color(color4,color3,blend_factor);
}
else if current_hour>=8 && current_hour<9 {
    blended_color = merge_color(color3,color1,blend_factor);
}
else if current_hour>=9 && current_hour<13 {
    blended_color = merge_color(color1,color6,blend_factor);
}
else if current_hour>=13 && current_hour<17 {
    blended_color = merge_color(color6,color1,blend_factor);
}
else if current_hour>=17 && current_hour<18 {
    blended_color = merge_color(color1,color3,blend_factor);
}
else if current_hour>=18 && current_hour<19 {
    blended_color = merge_color(color3,color4,blend_factor);
}
else if current_hour>=19 && current_hour<21 {
    blended_color = merge_color(color4,color2,blend_factor);
}
else if current_hour>=21 && current_hour<25 {
    blended_color = merge_color(color2,color5,blend_factor);
}


__background_set_colour(blended_color);

var lay_id = layer_get_id("Colour");
var back_id = layer_background_get_id(lay_id);
layer_background_blend(back_id, blended_color);

}