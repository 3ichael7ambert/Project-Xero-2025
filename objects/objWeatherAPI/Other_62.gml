/// Async - HTTP
var _id    = async_load[? "id"];
var _res   = async_load[? "result"];
var _stat  = async_load[? "status"];       // 0 ok (runner)
var _hstat = async_load[? "http_status"];  // 200 ok (http)
var _ok    = (is_real(_stat) && _stat == 0) || (is_real(_hstat) && _hstat == 200);

// IP only
if (_id == ip_req_id) {
    if (_ok && is_string(_res)) {
        var m = json_parse(_res); // struct in modern runtimes
        if (is_struct(m) && m.status == "success") {
            weather.country = string(m.country);
            weather.city    = string(m.city);
            weather.state   = string(m.regionName);
            weather.lat     = m.lat;
            weather.lon     = m.lon;
            weather.last_update = current_time;
			
			// Build Open-Meteo URL and request current weather
			var _url = "https://api.open-meteo.com/v1/forecast"
			        + "?latitude="  + string(weather.lat)
			        + "&longitude=" + string(weather.lon)
			        + "&current_weather=true";

			weather_req_id = http_get(_url);
			//
			
			        } else {
            show_debug_message("IP JSON unexpected: " + string(_res));
        }
    } else {
        show_debug_message("IP request failed: status=" + string(_stat) + " http=" + string(_hstat));
    }
}

// ---- WEATHER RESPONSE ----
if (is_real(weather_req_id) && weather_req_id >= 0 && _id == weather_req_id) {
    if (_ok && is_string(_res)) {
        var w = json_parse(_res); // struct
        if (is_struct(w) && !is_undefined(w.current_weather)) {
            var cw = w.current_weather;
            if (is_struct(cw) && !is_undefined(cw.weathercode)) {
                var code = cw.weathercode;
                weather.wmo        = code;
                weather.mode       = map_wmo_to_mode(code); // uses the helper below
                weather.temp_c     = cw.temperature;        // °C
                weather.wind_kph   = cw.windspeed;          // km/h
                weather.last_update = current_time;
            } else {
                show_debug_message("Weather JSON missing weathercode: " + string(_res));
            }
        } else {
            show_debug_message("Weather JSON missing current_weather: " + string(_res));
        }
    } else {
        show_debug_message("Weather request failed: status=" + string(_stat) + " http=" + string(_hstat));
    }
}

