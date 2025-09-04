switch (state) {
    case "out":
        t++;
        k += 0.08; // for distort wobble
        if (t >= dur_out) {
            // swap rooms but keep this object alive
            room_goto(_rm);
            // after swap, continue with fade-in
            state = "in";
            t = 0;
        }
        break;

    case "in":
        t++;
        if (t >= dur_in) {
            // cleanup
            if (surface_exists(surf)) surface_free(surf);
            instance_destroy();
        }
        break;
}
