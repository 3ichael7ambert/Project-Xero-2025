if (use_fx) {
    exiting = false; // now playing in reverse
    if (layer_exists(temp_layer)) layer_destroy(temp_layer);
    temp_layer = layer_create(-10000);
    layer_set_fx(temp_layer, filter);
    fx_set_parameter(filter, param_name, param_value);
}
