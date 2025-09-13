if (variable_instance_exists(self, "threat_map") && !is_undefined(threat_map) && ds_exists(threat_map, ds_type_map)) {
    ds_map_destroy(threat_map);
}
