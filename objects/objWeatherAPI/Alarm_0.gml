/// Alarm 0  (IP-only refresh/retry)
if (!is_struct(weather)) {
    // Safety: recreate if something nuked it
    weather = { mode:"clear", city:"", state:"", lat:0, lon:0, temp_c:undefined, wind_kph:undefined, wmo:undefined, last_update:-1 };
}

// Re-do IP lookup occasionally (or after failures)
ip_req_id = http_get("https://ip-api.com/json/");

// schedule next check
alarm[0] = ceil(update_interval_ms / 1000) * room_speed;
