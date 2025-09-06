function map_wmo_to_label(code) {
    if (code == 0) return "Clear";
    if (code == 1) return "Mostly clear";
    if (code == 2) return "Partly cloudy";
    if (code == 3) return "Overcast";
    if (code == 45 || code == 48) return "Fog";
    if (code >= 51 && code <= 57) return "Drizzle";
    if (code >= 61 && code <= 67) return (code >= 66) ? "Freezing rain" : "Rain";
    if (code == 71 || code == 73 || code == 75) return "Snow";
    if (code == 77) return "Snow grains";
    if (code >= 80 && code <= 82) return "Showers";
    if (code == 95) return "Thunderstorm";
    if (code == 96 || code == 99) return "Thunderstorm (hail)";
    return "Unknown";
}
