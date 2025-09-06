/// Async - HTTP
var _id    = async_load[? "id"];
var _res   = async_load[? "result"];
var _stat  = async_load[? "status"];       // 0 ok (runner)
var _hstat = async_load[? "http_status"];  // 200 ok (http)
var _ok    = (is_real(_stat) && _stat == 0) || (is_real(_hstat) && _hstat == 200);

// ---- IP ONLY ----
if (_id == ip_req_id) {
    if (_ok && is_string(_res)) {
        var m = json_parse(_res); // struct in modern runtimes
        if (is_struct(m) && m.status == "success") {
            weather.country = string(m.country);     // <-- add this
            weather.city    = string(m.city);
            weather.state   = string(m.regionName);
            weather.lat     = m.lat;
            weather.lon     = m.lon;
            weather.last_update = current_time;
        } else {
            show_debug_message("IP JSON unexpected: " + string(_res));
        }
    } else {
        show_debug_message("IP request failed: status=" + string(_stat) + " http=" + string(_hstat));
    }
}
