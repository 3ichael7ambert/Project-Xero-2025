/*
if (!visible_gui) {
    draw_set_alpha(0.8);
    draw_set_color(c_white);
    draw_text(24, 24, "Press F9 to show Weather HUD");
    exit;
}

var x = panel.x, y = panel.y, w = panel.w, h = panel.h;
var r = 10;

// Shadow
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_roundrect(x + panel.shadow, y + panel.shadow, x + w + panel.shadow, y + h + panel.shadow, false);

// Panel
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(20,24,30));
draw_roundrect(x, y, x + w, y + h, false);

// Header bar
draw_set_alpha(1);
draw_set_color(make_color_rgb(32,38,48));
draw_rectangle(x, y, x + w, y + 28, false);

// Title
draw_set_color(c_white);
draw_text(x + panel.pad, y + 6, "Local Weather");

// Hide “X”
draw_set_color(c_lime);
draw_text(btn_hide.x + 8, btn_hide.y + 4, "×");

// If no controller / no data yet
if ( !_has_weather() ) {
    draw_set_color(c_white);
    draw_text(x + panel.pad, y + 40, "Loading controller…");
    exit;
}

// Pull data
var wc   = global.WEATHER.weather;
var city = string(wc.city);
var st   = string(wc.state);
var mode = string(wc.mode);
var wmo  = string(wc.wmo);
var tmpc = wc.temp_c;
var wind = wc.wind_kph;

// Convert °C → °F for display (optional)
var tmpf = is_undefined(tmpc) ? undefined : (tmpc * 9/5 + 32);

// Label text
var label = "Unknown";
if (wc.wmo != undefined) label = map_wmo_to_label(wc.wmo);
else                     label = string_upper(mode);

// Icon (ASCII-based)
var icon = "☀";
switch (mode) {
    case "clear":  icon = "☀"; break;
    case "cloudy": icon = "☁"; break;
    case "fog":    icon = "〰"; break;
    case "rain":   icon = "☂"; break;
    case "snow":   icon = "❄"; break;
    case "storm":  icon = "⚡"; break;
}

// Left block: location + condition
var line_y = y + 40;
draw_set_color(c_white);
draw_text(x + panel.pad, line_y,        city + ", " + st);
draw_text(x + panel.pad, line_y + 22,   icon + "  " + label + "  (WMO " + wmo + ")");

// Right block: numbers
var rx = x + w - panel.pad - 120;
draw_set_color(c_ltgray);
var ttxt = is_undefined(tmpf) ? "Temp: --°F" : "Temp: " + string_format(tmpf, 0, 0) + "°F";
var wtxt = is_undefined(wind) ? "Wind: -- km/h" : "Wind: " + string_format(wind, 0, 0) + " km/h";
draw_text(rx, line_y, ttxt);
draw_text(rx, line_y + 22, wtxt);

// Timestamp
var ago = "--";
if (wc.last_update >= 0) {
    var sec = (current_time - wc.last_update) / 1000;
    if (sec < 60) ago = string(round(sec)) + "s ago";
    else ago = string(round(sec/60)) + "m ago";
}
draw_set_color(c_silver);
draw_text(x + panel.pad, y + h - 22, "Updated " + ago);

// Refresh button
draw_set_color(btn_refresh.hover ? make_color_rgb(70,110,180) : make_color_rgb(52,82,130));
draw_rectangle(btn_refresh.x, btn_refresh.y, btn_refresh.x + btn_refresh.w, btn_refresh.y + btn_refresh.h, false);
draw_set_color(c_white);
draw_text(btn_refresh.x + 10, btn_refresh.y + 6, "Refresh");
