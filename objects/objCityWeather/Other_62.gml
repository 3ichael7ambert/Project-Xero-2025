var id          = async_load[? "id"];
var http_status = async_load[? "http_status"];
var result      = async_load[? "result"];

if (id == ip_req_id) {
    if (http_status == 200) {
        var m = json_parse(result);
        if (m[? "status"] == "success") {
            weather.city = m[? "city"];
            weather.state = m[? "regionName"];
            weather.lat = m[? "lat"];
            weather.lon = m[? "lon"];
            ds_map_destroy(m);

            // Call Open-Meteo for current weather
            var url = "https://api.open-meteo.com/v1/forecast"
                      + "?latitude=" + string(weather.lat)
                      + "&longitude=" + string(weather.lon)
                      + "&current_weather=true";
            weather_req_id = http_request(url, "GET", "", "");
        } else {
            ds_map_destroy(m);
            show_debug_message("IP lookup failed.");
            alarm[0] = room_speed * 10;
        }
    } else {
        show_debug_message("IP http error: " + string(http_status));
        alarm[0] = room_speed * 10;
    }
}

if (id == weather_req_id) {
    if (http_status == 200) {
        var w = json_parse(result);
        if (ds_map_exists(w, "current_weather")) {
            var cw = w[? "current_weather"];
            var code = cw[? "weathercode"];
            weather.mode = map_wmo_to_mode(code);
            weather.last_update = current_time;
        }
        ds_map_destroy(w);
    } else {
        show_debug_message("Weather http error: " + string(http_status));
    }
    // schedule next refresh
    alarm[0] = ceil(update_interval_ms / 1000) * room_speed;
}
