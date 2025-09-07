if (!captured && use_capture) {
    // app surface might not exist the same frame we enabled it; retry a few frames
    if (application_surface_is_enabled() && surface_exists(application_surface)) {
        var w = surface_get_width(application_surface);
        var h = surface_get_height(application_surface);

        if (!surface_exists(surf) || surface_get_width(surf) != w || surface_get_height(surf) != h) {
            if (surface_exists(surf)) surface_free(surf);
            surf = surface_create(w, h);
        }
        // Copy the full backbuffer result
        surface_copy(surf, 0, 0, application_surface);
        captured = true;
    } else {
        cap_attempt++;
        if (cap_attempt >= cap_max) {
            // Fallback: proceed without screenshot (pure black fade)
            use_capture = false;
            captured    = true;
        }
    }
}
