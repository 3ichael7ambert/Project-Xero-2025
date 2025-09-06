/// Draw GUI
var xx = 24, yy = 524, pw = 480, ph = 220, pad = 12, line_h = 18;

draw_set_alpha(0.9);
draw_set_color(make_color_rgb(20,24,30));
draw_rectangle(xx, yy, xx+pw, yy+ph, false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(32,38,48));
draw_rectangle(xx, yy, xx+pw, yy+30, false);
draw_set_color(c_white);
draw_text(xx+pad, yy+8, "IP Geolocation (ip-api.com)");

var bx = xx+pad, by = yy+38, ly = by;

draw_set_color(c_aqua); draw_text(bx, ly, "status:");     draw_set_color(c_white); draw_text(bx+180, ly, "success? " + string(weather.city != "")); ly += line_h;
draw_set_color(c_aqua); draw_text(bx, ly, "country:");    draw_set_color(c_white); draw_text(bx+180, ly, string(weather.country));    ly += line_h; // may be undefined; okay
draw_set_color(c_aqua); draw_text(bx, ly, "regionName:"); draw_set_color(c_white); draw_text(bx+180, ly, string(weather.state));      ly += line_h;
draw_set_color(c_aqua); draw_text(bx, ly, "city:");       draw_set_color(c_white); draw_text(bx+180, ly, string(weather.city));       ly += line_h;
draw_set_color(c_aqua); draw_text(bx, ly, "lat:");        draw_set_color(c_white); draw_text(bx+180, ly, string(weather.lat));        ly += line_h;
draw_set_color(c_aqua); draw_text(bx, ly, "lon:");        draw_set_color(c_white); draw_text(bx+180, ly, string(weather.lon));        ly += line_h;
draw_set_color(c_aqua); draw_text(bx, ly, "updated:");    draw_set_color(c_white);
var ago = (weather.last_update < 0) ? "--" : string( round( (current_time - weather.last_update)/1000 ) ) + "s ago";
draw_text(bx+180, ly, ago); ly += line_h;

draw_set_color(c_silver);
draw_text(xx+pad, yy+ph-22, "HTTPS • data by ip-api.com");
