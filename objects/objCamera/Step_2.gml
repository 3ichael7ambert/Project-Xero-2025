/// @description Follow target
if (target != noone)
if (instance_exists(target))
{
    __view_set( e__VW.XView, 0, target.x-half_wview );
    __view_set( e__VW.YView, 0, target.y-half_hview );
}


