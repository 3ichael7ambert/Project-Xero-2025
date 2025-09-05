if (!captured) {
    if (application_surface_is_enabled() && surface_exists(application_surface)) {
        var w = surface_get_width(application_surface);
        var h = surface_get_height(application_surface);

        // (Re)create our buffer surface if needed/mismatched
        if (!surface_exists(surf) || surface_get_width(surf) != w || surface_get_height(surf) != h) {
            if (surface_exists(surf)) surface_free(surf);
            surf = surface_create(w, h);
        }

        surface_set_target(surf);
        draw_clear_alpha(c_black, 0);
        draw_surface(application_surface, 0, 0);
        surface_reset_target();

        captured = true;
    }
    // If app surface still doesn’t exist (very first frame, device lost, etc.),
    // we’ll try again next Draw. Don’t error out; just skip.
}
