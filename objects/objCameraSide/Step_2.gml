/// @description Follow target
if (target != noone)
if (instance_exists(target))
{
    __view_set( e__VW.XView, 0, target.x-half_wview );
    __view_set( e__VW.YView, 0, target.y-half_hview );
}


if (target != noone && instance_exists(target)) {
    var targetY = clamp(target.y, minY, maxY); // Set minY and maxY to your desired values
    
    __view_set(e__VW.XView, 0, target.x - half_wview);
    __view_set(e__VW.YView, 0, targetY - half_hview);
}


