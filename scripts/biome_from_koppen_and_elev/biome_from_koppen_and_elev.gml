function biome_from_koppen_and_elev(koppen, elev_m) {
    // Normalize (e.g., "Csa" -> upper)
    if (!is_string(koppen)) return "unknown";
    var k = string_upper(koppen);

    // --- Desert / steppe ---
    if (string_copy(k,1,1) == "B") {
        // BW* (desert) or BS* (steppe) -> "desert"
        return "desert";
    }

    // --- Tropical (A*) ---
    if (string_copy(k,1,1) == "A") {
        // Tropical climates: call this "beach" per your spec
        // but if elevation is very high, override to mountain
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        return "beach";
    }

    // --- Polar / Tundra (E*) ---
    if (string_copy(k,1,1) == "E") {
        // If high and cold, you might prefer "mountain"; else "forest"/"tundra".
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        return "forest"; // or "tundra" if you want a separate bucket
    }

    // --- Temperate (C*) & Cold/Boreal (D*) ---
    if (string_copy(k,1,1) == "C" || string_copy(k,1,1) == "D") {
        // Warm coastal "beach": low elevation + warm subtypes
        if (is_real(elev_m) && elev_m < 80) {
            // Typical warm coastal: Csa/Csb (Mediterranean), Cfa/Cfb (humid subtropic/oceanic)
            if (string_pos("CSA", k) == 1 || string_pos("CSB", k) == 1 ||
                string_pos("CFA", k) == 1 || string_pos("CFB", k) == 1) {
                return "beach"; // matches LA/Miami vibe
            }
        }
        // Mountains by elevation
        if (is_real(elev_m) && elev_m >= 1200) return "mountain";
        // Otherwise foresty
        return "forest";
    }

    return "unknown";
}
