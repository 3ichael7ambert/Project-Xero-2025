/// @description Create enemies
alarm[0] = room_speed*4;
if (instance_number(objEnemy) < 5)
{
    var xx = choose(__view_get( e__VW.XView, 0 )-64, __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )+64);
    var yy = choose(__view_get( e__VW.YView, 0 )-64, __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )+64);
    instance_create(xx, yy, objEnemyPlane);
}




if (instance_number(o_satellite) < 1) & level=5 
{
    var xx = choose(__view_get( e__VW.XView, 0 )-64, __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )+64);
    var yy = choose(__view_get( e__VW.YView, 0 )-64, __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )+64);
    instance_create(xx, yy, o_satellite);
}

if (instance_number(o_asteroids) < 100) & level=1
{
    var xx = choose(__view_get( e__VW.XView, 0 )-64, __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )+64);
    var yy = choose(__view_get( e__VW.YView, 0 )-64, __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )+64);
    instance_create(xx, yy, o_asteroids);
}


