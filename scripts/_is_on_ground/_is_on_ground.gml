// Helper
function _is_on_ground(ground){
    var yy = y + 2;
    return instance_place(x, yy, ground) != noone;
}