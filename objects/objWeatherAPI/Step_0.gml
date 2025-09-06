
/// API - Weather
switch (weather.mode) {
    case "clear":  mode = "clear";  intensity = 0.0; break;
    case "cloudy": mode = "clear";  intensity = 0.0; /* but darker sky */ break;
    case "fog":    mode = "fog";    fog_density = 0.5; break;
    case "rain":   mode = "rain";   intensity = 0.6; wind_power = 0.4; break;
    case "snow":   mode = "snow";   intensity = 0.5; wind_power = 0.2; break;
    case "storm":  mode = "rain";   intensity = 1.0; wind_power = 0.7; /* add lightning */ break;
}
