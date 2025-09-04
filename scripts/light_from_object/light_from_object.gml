function light_from_object(_targetObject, _radius, _color, _intensity=0.5){
    if(_targetObject < -1 || !instance_exists(_targetObject)){
        return -1;
    }
    
    var _cam = view_camera[0];
    var _x = _targetObject.x - camera_get_view_x(_cam);
    var _y = _targetObject.y - camera_get_view_y(_cam);
    var _w = camera_get_view_width(_cam);
    var _h = camera_get_view_height(_cam);
    
    if(!point_in_rectangle(_x, _y, -_radius, -_radius, _w+_radius, _h+_radius)){
        return -1;
    }
    
    return [_x, _y, _radius, _intensity, _color];
}
