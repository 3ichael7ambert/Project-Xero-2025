/// Create
weather = {
    mode: "clear",
    country: "",
    city: "", state: "",
    lat: 0, lon: 0,
    temp_c: undefined, wind_kph: undefined,
    wmo: undefined,
    precip_pct: undefined,   // <-- add this
    last_update: -1
};


show_panel = true;
scroll_y   = 0;
line_h     = 18;
pad        = 12;

ip_req_id      = -1;
weather_req_id = -1;

// Kick off IP lookup (HTTPS)
ip_req_id = http_get("http://ip-api.com/json/");

// Refresh every 30 minutes
update_interval_ms = 30 * 60 * 1000;
alarm[0] = room_speed * 10; // first retry in ~10s



/// API 3
koppen_req_id   = -1;
elev_req_id     = -1;

weather.biome   = "unknown"; // result we'll compute
weather.koppen  = undefined; // e.g., "Csa"
weather.elev_m  = undefined; // meters
