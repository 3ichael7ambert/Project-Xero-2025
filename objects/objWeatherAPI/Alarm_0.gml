/// Alarm[0] (IP-only refresh/retry)
if (!is_struct(weather)) {
    weather = { mode:"clear", country:"", city:"", state:"", lat:0, lon:0,
                temp_c:undefined, wind_kph:undefined, wmo:undefined, last_update:-1 };
}

// Re-do IP lookup occasionally
ip_req_id = http_get("http://ip-api.com/json/");

// schedule next check
alarm[0] = ceil(update_interval_ms / 1000) * room_speed;

if (weather.lat != 0 || weather.lon != 0) {
    var _url = "https://api.open-meteo.com/v1/forecast"
             + "?latitude="  + string(weather.lat)
             + "&longitude=" + string(weather.lon)
             + "&current_weather=true";
    weather_req_id = http_get(_url);
} else {
    ip_req_id = http_get("https://ip-api.com/json/");
}
alarm[0] = ceil(update_interval_ms / 1000) * room_speed;
