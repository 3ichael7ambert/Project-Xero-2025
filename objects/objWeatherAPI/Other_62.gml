/*/// Async - HTTP
var _id     = async_load[? "id"];
var _stat   = async_load[? "status"];      // works across runtimes
var _hstat  = async_load[? "http_status"]; // some runtimes use this; we'll fall back
var _ok     = (is_real(_stat)  && _stat  == 0) || (is_real(_hstat) && _hstat == 200);
var _result = async_load[? "result"];

// ---- IP LOOKUP RESPONSE ----
if (_id == ip_req_id) {
    if (_ok && is_string(_result)) {
        var m = json_parse(_result); // struct in modern runtimes
        if (is_struct(m) && m.status == "success") {
            weather.city  = string(m.city);
            weather.state = string(m.regionName);
            weather.lat   = m.lat;
            weather.lon   = m.lon;

            // Build URL now that we have coords
            var url = "https://api.open-meteo.com/v1/forecast"
                      + "?latitude="  + string(weather.lat)
                      + "&longitude=" + string(weather.lon)
                      + "&current_weather=true";

            weather_req_id = http_get(url);
        } else {
            show_debug_message("IP lookup failed or unexpected JSON.");
            alarm[0] = room_speed * 10;
        }
    } else {
        show_debug_message("IP request not OK. status=" + string(_stat) + " http_status=" + string(_hstat));
        alarm[0] = room_speed * 10;
    }
}

// ---- WEATHER RESPONSE ----
if (_id == weather_req_id) {
    if (_ok && is_string(_result)) {
        var w = json_parse(_result); // struct
        // Avoid variable_struct_exists(); just check for undefined safely
        if (is_struct(w) && !is_undefined(w.current_weather)) {
            var cw = w.current_weather;
            if (is_struct(cw) && !is_undefined(cw.weathercode)) {
