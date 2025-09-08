function scr_timeofday_background_init(cloudy=0){

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

switch (cloudy) {
		case 0:
			var cloudy_color = blended_color;
		break;
		
		case 1:
			var cloudy_color = merge_color(blended_color,c_gray,.25);
		break;
		
		case 2:
			var cloudy_color = merge_color(blended_color,c_gray,.5);
		break;
		
		case 3:
			var cloudy_color = merge_color(blended_color,c_gray,.75);
		break;
}

  if (cloudy == 45 || cloudy == 48) var cloudy_color = merge_color(blended_color,c_gray,.75);
    if (cloudy >= 51 && cloudy <= 57) var cloudy_color = merge_color(blended_color,c_gray,.33);
    if (cloudy >= 61 && cloudy <= 67) var cloudy_color = merge_color(blended_color,c_gray,.66);
    if (cloudy == 71 || cloudy == 73 || cloudy == 75 || cloudy == 77) var cloudy_color = merge_color(blended_color,c_gray,.75);
    if (cloudy >= 80 && cloudy <= 82) var cloudy_color = merge_color(blended_color,c_gray,.5);              // showers
    if (cloudy == 95 || cloudy == 96 || cloudy == 99) var cloudy_color = merge_color(blended_color,c_black,.5);




 __background_set_colour(blended_color);
    var lay_id = layer_get_id("Colour");
    if (lay_id != -1) {
        var back_id = layer_background_get_id(lay_id);
        if (back_id != -1) layer_background_blend(back_id, cloudy_color);
    }

}