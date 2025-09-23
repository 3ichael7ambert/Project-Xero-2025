if (!captured) exit;

if (use_fx) {
    var sp = exiting ? param_speed : -param_speed;
    param_value += sp;

    if (exiting && param_value >= param_max_value) {
        room_goto(_rm);
    } else if (!exiting && param_value <= param_min_value) {
        // end
        if (layer_exists(temp_layer)) layer_destroy(temp_layer);
        instance_destroy();
    }

    fx_set_parameter(filter, param_name, param_value);
    exit; // skip screenshot path if FX is active
}


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

