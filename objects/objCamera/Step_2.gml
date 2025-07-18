/// @description Follow target
/*
if (target != noone)
if (instance_exists(target))
{
    __view_set( e__VW.XView, 0, target.x-half_wview );
    __view_set( e__VW.YView, 0, target.y-half_hview );
}


*/

var total_x = 0;
var total_y = 0;
var count = array_length(global.players_array);

if (count > 0) {
    for (var i = 0; i < count; i++) {
        total_x += global.players_array[i].x;
        total_y += global.players_array[i].y;
    }

    var target_x = total_x / count;
    var target_y = total_y / count;

      __view_set( e__VW.XView, 0, target_x-half_wview );
    __view_set( e__VW.YView, 0, target_y-half_hview );
}
