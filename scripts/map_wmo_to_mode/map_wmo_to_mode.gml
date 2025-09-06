function map_wmo_to_mode(code) {
    if (code == 0)  return "clear";
    if (code == 1 || code == 2) return "clear";
    if (code == 3)  return "cloudy";
    if (code == 45 || code == 48) return "fog";
    if (code >= 51 && code <= 57) return "rain";                // drizzle/freezing drizzle
    if (code >= 61 && code <= 67) return (code >= 66) ? "storm" : "rain"; // rain/freezing rain
    if (code == 71 || code == 73 || code == 75 || code == 77) return "snow";
    if (code >= 80 && code <= 82) return "rain";                // showers
    if (code == 95 || code == 96 || code == 99) return "storm"; // thunder/hail
    return "clear";
}
