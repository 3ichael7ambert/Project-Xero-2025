function draw_all_lights(light_objects, daylight_tint, intensity=1.0){
    var _point_lights = [];

    with(light_objects){
        var _color = variable_instance_exists(id, "color") ? variable_instance_get(id, "color") : c_white;
        var _radius = variable_instance_exists(id, "radius") ? variable_instance_get(id, "radius") : 32;
		var _intensity = variable_instance_exists(id, "brightness") ? variable_instance_get(id, "brightness") : 0.5;
        var _light = light_from_object(id, _radius, _color, _intensity);
        if(is_array(_light) && array_length(_point_lights) <= 15){
            array_push(_point_lights, _light);
        }
    }
    
    apply_lighting(_point_lights, daylight_tint, intensity);
}
