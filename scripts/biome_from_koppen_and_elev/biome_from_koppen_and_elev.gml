function biome_from_koppen_and_elev(koppen, elev_m) {
    if (!is_string(koppen)) return "unknown";
    var k = string_upper(koppen);

    // --- Desert / Steppe (B*) ---
    if (string_copy(k,1,1) == "B") {
        // Cold semi-arid (BSk) special case → Great Plains
        if (string_pos("BSK", k) == 1) {
            if (is_real(elev_m) && elev_m < 1200) {
                return "plains"; // Kansas, Nebraska, Dakotas, etc.
            } else {
                return "mountain"; // high-elev BSk like Denver
            }
        }

        // Other B (hot desert, etc.)
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        return "desert";
    }

    // --- Tropical (A*) ---
    if (string_copy(k,1,1) == "A") {
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        return "beach";
    }

    // --- Polar / Tundra (E*) ---
    if (string_copy(k,1,1) == "E") {
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        return "tundra";
    }

    // --- Temperate (C*) & Continental (D*) ---
    if (string_copy(k,1,1) == "C" || string_copy(k,1,1) == "D") {
        if (is_real(elev_m) && elev_m < 80) {
            if (string_pos("CSA", k) == 1 || string_pos("CSB", k) == 1 ||
                string_pos("CFA", k) == 1 || string_pos("CFB", k) == 1) {
                return "beach";
            }
        }
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        return "forest";
    }

    return "unknown";
}
