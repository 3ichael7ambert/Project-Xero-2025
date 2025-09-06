/*/// objWeatherHUD : Create
visible_gui = true;
dragging = false;

panel = {
    x: 24, y: 24,
    w: 320, h: 140,
    pad: 12,
    shadow: 6,
};

btn_refresh = {
    x: 0, y: 0, w: 96, h: 28,
    hover: false
};

btn_hide = {
    x: 0, y: 0, w: 28, h: 28
};

// convenience
function _has_weather() {
    return (is_undefined(global.WEATHER) == false) && instance_exists(global.WEATHER);
}
