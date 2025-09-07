/// End Step — push live weather → FX object (objWeatherCity / objCityWeather)

// pick the destination instance (prefer objWeatherCity if it exists)
var _dest = noone;
if (instance_exists(objCityWeather))    _dest = objCityWeather;

if (_dest == noone) exit;

// --- collect safe values from parsed API data ---
var _mode        = is_string(weather.mode) ? weather.mode : "clear";
var _wmo         = is_real(weather.wmo) ? weather.wmo : 0;
var _temp_c      = weather.temp_c;
var _precip_pct  = is_real(weather.precip_pct) ? weather.precip_pct : 0;
var _wind_kph    = is_real(weather.wind_kph) ? weather.wind_kph : 0;
//var _wind_from   = is_real(weather.wind_deg_from) ? weather.wind_deg_from : 180;
var _lat         = weather.lat;
var _lon         = weather.lon;
var _city        = weather.city;
var _state       = weather.state;
var _country     = weather.country;
var _koppen      = weather.koppen;
var _elev_m      = weather.elev_m;
var _biome       = weather.biome;

// derived
//var _wind_dir_game = meteo_to_game_dir(_wind_from);    // helper from earlier
var _wind_power    = clamp(_wind_kph / 50, 0, 1);      // tweak divisor to taste

//var _preset_info   = mode_to_particle_preset(_mode);   // {preset, base_intensity, fog}
//var _intensity     = clamp(_preset_info.base_intensity + (_precip_pct/100)*0.5, 0, 1);
//var _fog_density   = clamp(_preset_info.fog + (_precip_pct/100)*0.2, 0, 0.85);

//var _cloudy_pct    = cloudiness_from_wmo(_wmo, _precip_pct); // 0..1
//var _is_cloudy     = (_cloudy_pct >= 0.35) || (_mode == "cloudy");

// optional: slush near freezing
if (is_real(_temp_c) && _temp_c > -1 && _temp_c <= 2 && (_mode == "snow" || _mode == "rain")) {
    _preset_info.preset = "Slush";
}

// --- push into the FX object instance ---
with (_dest) {
    // core mode/particles
    if (!variable_instance_exists(id, "mode")) mode = "clear";
    mode              = _mode;                 // keep a copy if you use it
  //  part_state_player = _preset_info.preset;   // "Rain"/"Snow"/"Slush"/"None"
  //  part_spawn_count  = clamp(round(200 * _intensity), 25, 500);

    // wind & effects used by your particle logic
    //wind_dir    = _wind_dir_game;   // 0=right, 90=up
    wind_power  = _wind_power;      // 0..1
   // intensity   = _intensity;       // if your scripts read this
   // fog_density = _fog_density;

    // sky background hook (for your scr_timeofday_background_init)
 //   cloudy          = _is_cloudy;
  //  cloudy_percent  = _cloudy_pct;

    // useful readouts / debugging
    wmo         = _wmo;
    temp_c      = _temp_c;
    precip_pct  = _precip_pct;
    wind_kph    = _wind_kph;
  //  wind_from   = _wind_from;

    // location & biome info
    lat   = _lat;
    lon   = _lon;
    city  = _city;
    state = _state;
    country = _country;
    koppen  = _koppen;
    elev_m  = _elev_m;
    biome   = _biome;
}

// (optional) if you call the sky blend here:
//scr_timeofday_background_init(_is_cloudy, _cloudy_pct);

scr_timeofday_background_init();
