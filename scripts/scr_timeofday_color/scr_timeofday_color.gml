/// scr_timeofday_color(hour, minute) -> blended_color
function scr_timeofday_color(cloudy=0){
	var _hour = current_hour
	var _minute = current_minute
    var blend_factor = (_minute / 60);
    var color1 = make_color_rgb(87,141,191);
    var color2 = make_color_rgb(11,37,61);
    var color3 = make_color_rgb(239,192,50);
    var color4 = make_color_rgb(239,64,158);
    var color5 = make_color_rgb(5,5,15);
    var color6 = make_color_rgb(97,151,210);

    var blended_color;

    if      (_hour>=0  && _hour<6 ) blended_color = merge_color(color5,color2,blend_factor);
    else if (_hour>=6  && _hour<7 ) blended_color = merge_color(color2,color4,blend_factor);
    else if (_hour>=7  && _hour<8 ) blended_color = merge_color(color4,color3,blend_factor);
    else if (_hour>=8  && _hour<9 ) blended_color = merge_color(color3,color1,blend_factor);
    else if (_hour>=9  && _hour<13) blended_color = merge_color(color1,color6,blend_factor);
    else if (_hour>=13 && _hour<17) blended_color = merge_color(color6,color1,blend_factor);
    else if (_hour>=17 && _hour<18) blended_color = merge_color(color1,color3,blend_factor);
    else if (_hour>=18 && _hour<19) blended_color = merge_color(color3,color4,blend_factor);
    else if (_hour>=19 && _hour<21) blended_color = merge_color(color4,color2,blend_factor);
    else                             blended_color = merge_color(color2,color5,blend_factor);


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


    /*// optional: update your layer, but keep the RETURN
    __background_set_colour(blended_color);
    var lay_id = layer_get_id("Colour");
    if (lay_id != -1) {
        var back_id = layer_background_get_id(lay_id);
        if (back_id != -1) layer_background_blend(back_id, blended_color);
    }
	*/
    return cloudy_color; // <-- critical
}
