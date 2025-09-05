/// try refresh (skip if we don’t have coords yet)
if (weather.lat != 0 || weather.lon != 0) {
    var url = "https://api.open-meteo.com/v1/forecast"
              + "?latitude=" + string(weather.lat)
              + "&longitude=" + string(weather.lon)
              + "&current_weather=true";
    weather_req_id = http_request(url, "GET", "", "");
} else {
    // re-request IP (first run may have failed)
    ip_req_id = http_request("http://ip-api.com/json/", "GET", "", "");
}
