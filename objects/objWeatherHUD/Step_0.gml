/*
/// Toggle with F9
if (keyboard_check_pressed(vk_f9)) visible_gui = !visible_gui;

// No controller? bail on interactions
if (!visible_gui || !_has_weather()) exit;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Panel rect
var x1 = panel.x, y1 = panel.y, x2 = panel.x + panel.w, y2 = panel.y + panel.h;

// Drag panel by header (top 28px)
var in_header = (mx >= x1 && mx <= x2 && my >= y1 && my <= y1 + 28);
if (mouse_check_button_pressed(mb_left) && in_header) {
    dragging = true;
    drag_dx = mx - panel.x;
    drag_dy = my - panel.y;
}
if (dragging) {
    if (mouse_check_button(mb_left)) {
        panel.x = max(0, mx - drag_dx);
        panel.y = max(0, my - drag_dy);
    } else dragging = false;
}

// Buttons layout (computed every step so they “stick”)
btn_refresh.x = x2 - panel.pad - btn_refresh.w;
btn_refresh.y = y2 - panel.pad - btn_refresh.h;

btn_hide.x = x2 - panel.pad - btn_hide.w;
btn_hide.y = y1 + (28 - btn_hide.h) div 2;

// Hover states
btn_refresh.hover = (mx >= btn_refresh.x && mx <= btn_refresh.x + btn_refresh.w &&
                     my >= btn_refresh.y && my <= btn_refresh.y + btn_refresh.h);

var hide_hover = (mx >= btn_hide.x && mx <= btn_hide.x + btn_hide.w &&
                  my >= btn_hide.y && my <= btn_hide.y + btn_hide.h);

// Clicks
if (mouse_check_button_released(mb_left)) {
    if (btn_refresh.hover) {
        // tell controller to refresh now
        with (global.WEATHER) {
            if (weather.lat != 0 || weather.lon != 0) {
                var url = "https://api.open-meteo.com/v1/forecast"
                        + "?latitude=" + string(weather.lat)
                        + "&longitude=" + string(weather.lon)
                        + "&current_weather=true";
                weather_req_id = http_request(url, "GET", "", "");
            } else {
                ip_req_id = http_request("http://ip-api.com/json/", "GET", "", "");
            }
        }
    }
    if (hide_hover) visible_gui = false;
}
