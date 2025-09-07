if (!captured) exit;

switch (state) {
    case "out":
        t++; k += 0.08;
        if (t >= dur_out) {
            room_goto(_rm);
            state = "in";
            t = 0;
        }
    break;

    case "in":
        t++;
        if (t >= dur_in) {
            if (surface_exists(surf)) surface_free(surf);
            instance_destroy();
        }
    break;
}
