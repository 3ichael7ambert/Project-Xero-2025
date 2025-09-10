// Debug
if (keyboard_check_pressed(ord("D")))    // Press D to enter debug viewer
{
    DebugState = !DebugState;
}

var vw = __view_get(e__VW.WView, view_current);
while (FloorStart < PlayerID.x + vw + FloorBuffer) {
    scr_GenerateFloor_bike(id);
}

// Step (after PlayerID exists)
if (instance_exists(BoundaryID) && instance_exists(PlayerID)) {
    BoundaryID.x = PlayerID.x - (__view_get(e__VW.WView, view_current) * 0.5);
    BoundaryID.y = FloorLast; // or clamp near the current floor’s baseline
}
