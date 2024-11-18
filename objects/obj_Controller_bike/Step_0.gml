// Debug
if (keyboard_check_pressed(ord("D")))    // Press D to enter debug viewer
{
    DebugState = !DebugState;
}

if (FloorStart - PlayerID.x - __view_get( e__VW.WView, view_current ) < FloorBuffer)       // Generate next segment of floor that is beyon player's view
{
    scr_GenerateFloor_bike(id);
}

