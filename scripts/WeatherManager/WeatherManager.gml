// API helpers
function weather_set_mode(_m){ mode = _m; }

function weather_set_wind(_dir_deg, _power){ wind_dir = _dir_deg; wind_power = clamp(_power, 0, 1); }

function weather_set_fog(_dens, _col){ fog_density = clamp(_dens, 0, 1); fog_col = _col; }

function weather_set_intensity(_i){ intensity = clamp(_i, 0, 1); }

// helper for camera size
function __get_view() {
    var cam = view_camera[0];
    var vx = camera_get_view_x(cam);
    var vy = camera_get_view_y(cam);
    var vw = camera_get_view_width(cam);
    var vh = camera_get_view_height(cam);
    return [cam, vx, vy, vw, vh];
}