// Draw End (capture)
if (!captured && application_surface_is_enabled() && surface_exists(application_surface)) {
    cap_w = surface_get_width(application_surface);
    cap_h = surface_get_height(application_surface);

    if (!surface_exists(surf) || surface_get_width(surf)!=cap_w || surface_get_height(surf)!=cap_h) {
        if (surface_exists(surf)) surface_free(surf);
        surf = surface_create(cap_w, cap_h);
    }
    surface_copy(surf, 0, 0, application_surface);
    captured = true;
}
 else {
        cap_attempt++;
        if (cap_attempt >= cap_max) {
            // Fallback: proceed without screenshot (pure black fade)
            use_capture = false;
            captured    = true;
        }
    }

