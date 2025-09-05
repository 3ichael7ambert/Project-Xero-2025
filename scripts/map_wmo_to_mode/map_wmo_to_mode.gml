function map_wmo_to_mode(code) {
    // Open-Meteo uses WMO codes. This is a compact mapping.
    // Clear / mainly clear
    if (code == 0)  return "clear";
    if (code == 1 || code == 2) return "clear";   // mostly/partly clear
    if (code == 3)  return "cloudy";              // overcast

    // Fog / depositing rime
    if (code == 45 || code == 48) return "fog";

    // Drizzle (51,53,55) or freezing drizzle (56,57) → light rain
    if (code >= 51 && code <= 57) return "rain";

    // Rain (61,63,65) or freezing rain (66,67)
    if (code >= 61 && code <= 67) return (code >= 66) ? "storm" : "rain";

    // Snow (71,73,75), snow grains (77)
    if (code == 71 || code == 73 || code == 75 || code == 77) return "snow";

    // Showers (80,81,82)
    if (code >= 80 && code <= 82) return "rain";

    // Thunderstorm (95), with hail (96,99)
    if (code == 95 || code == 96 || code == 99) return "storm";

    return "clear";
}
