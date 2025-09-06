/// Create
// Initialize BEFORE any async/alarms touch it
weather = {
    mode: "clear",
    country: "",          // <-- add this
    city: "", state: "",
    lat: 0, lon: 0,
    temp_c: undefined, wind_kph: undefined,
    wmo: undefined,
    last_update: -1
};


ip_req_id      = -1;
weather_req_id = -1;      // reserved for later when you add Open-Meteo

// Kick off IP lookup (use HTTPS)
ip_req_id = http_get("http://ip-api.com/json/");

// optional cadence
update_interval_ms = 30 * 60 * 1000;
alarm[0] = room_speed * 10;   // schedule a refresh/retry
