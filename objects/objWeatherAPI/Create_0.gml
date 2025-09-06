
/// API - Weather ///
/// WeatherController: Create
/// WeatherController: Create
weather = {
    mode: "clear",
    city: "", state: "",
    lat: 0, lon: 0,
    temp_c: undefined, wind_kph: undefined,
    wmo: undefined,
    last_update: -1
};

global.WEATHER = id;

// Kick off IP → city/state/coords
ip_req_id = http_get("http://ip-api.com/json/");
// Don't fetch weather yet — wait for the IP response.

// refresh cadence
update_interval_ms = 30 * 60 * 1000;
alarm[0] = room_speed * 5; // first retry window
