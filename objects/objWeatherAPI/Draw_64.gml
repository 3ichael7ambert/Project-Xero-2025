/// Draw GUI
var xx = 24, yy = 524, pw = 480, ph = 320, pad = 12, line_h = 18;

draw_set_alpha(0.9);
draw_set_color(make_color_rgb(20,24,30));
draw_rectangle(xx, yy, xx+pw, yy+ph, false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(32,38,48));
draw_rectangle(xx, yy, xx+pw, yy+30, false);
draw_set_color(c_white);
draw_text(xx+pad, yy+8, "IP Geolocation (ip-api.com)");

var bx = xx+pad, by = yy+38, ly = by;

draw_set_color(c_aqua); draw_text(bx, ly, "status:");
draw_set_color(c_white); draw_text(bx+180, ly, "success? " + string(weather.city != "")); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "country:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.country)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "regionName:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.state)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "city:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.city)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "lat:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.lat)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "lon:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.lon)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "updated:");
draw_set_color(c_white);
var ago = (weather.last_update < 0) ? "--" : string( round( (current_time - weather.last_update)/1000 ) ) + "s ago";
draw_text(bx+180, ly, ago); ly += line_h;

draw_set_color(c_silver);
//draw_text(xx+pad, yy+ph-22, "HTTPS • data by ip-api.com");

///---
/// API v2 Weather

draw_set_color(c_aqua); draw_text(bx, ly, "condition:");
draw_set_color(c_white);
var label = (is_undefined(weather.wmo)) ? "--" : map_wmo_to_label(weather.wmo);
draw_text(bx+180, ly, label); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "temp:");
draw_set_color(c_white);
var ttxt = is_undefined(weather.temp_c) ? "--°C / --°F"
                                        : string(round(weather.temp_c)) + "°C  /  " + string(round(weather.temp_c*9/5+32)) + "°F";
draw_text(bx+180, ly, ttxt); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "wind:");
draw_set_color(c_white);
var wtxt = is_undefined(weather.wind_kph) ? "-- km/h"
                                          : string(round(weather.wind_kph)) + " km/h";
draw_text(bx+180, ly, wtxt); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "precip:");
draw_set_color(c_white);
var pptxt = is_undefined(weather.precip_pct) ? "--%" : string(weather.precip_pct) + "%";
draw_text(bx+180, ly, pptxt); ly += line_h;

//API v3 Biomes

draw_set_color(c_aqua); draw_text(bx, ly, "biome:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.biome)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "koppen:");
draw_set_color(c_white); draw_text(bx+180, ly, string(weather.koppen)); ly += line_h;

draw_set_color(c_aqua); draw_text(bx, ly, "elev:");
draw_set_color(c_white); draw_text(bx+180, ly, is_undefined(weather.elev_m) ? "-- m" : string(round(weather.elev_m)) + " m"); ly += line_h;
