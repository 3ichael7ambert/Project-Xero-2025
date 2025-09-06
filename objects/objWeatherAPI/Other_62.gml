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
			        + "&current_weather=true"
			        + "&hourly=precipitation_probability";


			weather_req_id = http_get(_url);
			
			// API v3
			// --- Köppen climate ---
			var url_k = "https://climate.mapresso.com/api/koeppen/?lat=" 
			          + string(weather.lat) + "&lon=" + string(weather.lon);
			koppen_req_id = http_get(url_k);

			// --- Elevation (meters) ---
			var url_e = "https://api.open-meteo.com/v1/elevation?latitude=" 
			          + string(weather.lat) + "&longitude=" + string(weather.lon);
			elev_req_id = http_get(url_e);

			
			        } else {
            show_debug_message("IP JSON unexpected: " + string(_res));
        }
    } else {
        show_debug_message("IP request failed: status=" + string(_stat) + " http=" + string(_hstat));
    }
}

// ---- WEATHER RESPONSE ----
// ---- WEATHER RESPONSE ----
if (is_real(weather_req_id) && weather_req_id >= 0 && _id == weather_req_id) {
    if (_ok && is_string(_res)) {
        var w = json_parse(_res); // struct

        if (is_struct(w) && !is_undefined(w.current_weather)) {
            var cw = w.current_weather;

            if (is_struct(cw) && !is_undefined(cw.weathercode)) {
                var code = cw.weathercode;

                // Core fields
                weather.wmo         = code;
                weather.mode        = map_wmo_to_mode(code);
                weather.temp_c      = cw.temperature;    // °C
                weather.wind_kph    = cw.windspeed;      // km/h
                weather.last_update = current_time;

                // ---------- NEW: precipitation probability (%) ----------
                // Requires hourly=precipitation_probability in the request URL.
                weather.precip_pct = undefined; // default

                if (!is_undefined(w.hourly) && is_struct(w.hourly)) {
                    var times = w.hourly.time;
                    var pp    = w.hourly.precipitation_probability;

                    if (is_array(times) && is_array(pp) && array_length(pp) > 0) {
                        // Try to align with the current hour reported by current_weather.time
                        var cur_iso = cw.time; // e.g., "2025-09-05T20:00"
                        var idx = -1;

                        // Find matching timestamp index (exact string match)
                        for (var i = 0; i < array_length(times); i++) {
                            if (times[i] == cur_iso) { idx = i; break; }
                        }

                        if (idx == -1) idx = 0; // fallback to first element
                        weather.precip_pct = pp[idx]; // 0..100
                    }
                }
                // -------------------------------------------------------
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




/// API v3 Biomes
// ---- KÖPPEN RESPONSE ----
if (is_real(koppen_req_id) && koppen_req_id >= 0 && _id == koppen_req_id) {
    if (_ok && is_string(_res)) {
        var k = json_parse(_res); // struct
        // Expected: { status:"OK", data:[ { code:"Csa", ... }, ...] }
        if (is_struct(k) && k.status == "OK" && is_array(k.data) && array_length(k.data) > 0) {
            var first = k.data[0];
            if (is_struct(first) && !is_undefined(first.code)) {
                weather.koppen = string(first.code); // e.g., "Am","Csa","BWh"
            }
        } else show_debug_message("Koppen JSON unexpected: " + string(_res));
    } else {
        show_debug_message("Koppen request failed: status=" + string(_stat) + " http=" + string(_hstat));
    }
    // try computing biome if elev already known
    if (!is_undefined(weather.koppen) && !is_undefined(weather.elev_m)) {
        weather.biome = biome_from_koppen_and_elev(weather.koppen, weather.elev_m);
    }
}

// ---- ELEVATION RESPONSE ----
if (is_real(elev_req_id) && elev_req_id >= 0 && _id == elev_req_id) {
    if (_ok && is_string(_res)) {
        var e = json_parse(_res); // expected: { "elevation":[XYZ] }
        if (is_struct(e) && !is_undefined(e.elevation) && is_array(e.elevation) && array_length(e.elevation) > 0) {
            weather.elev_m = e.elevation[0];
        } else show_debug_message("Elevation JSON unexpected: " + string(_res));
    } else {
        show_debug_message("Elevation request failed: status=" + string(_stat) + " http=" + string(_hstat));
    }
    // compute biome if koppen already known
    if (!is_undefined(weather.koppen) && !is_undefined(weather.elev_m)) {
        weather.biome = biome_from_koppen_and_elev(weather.koppen, weather.elev_m);
    }
}

