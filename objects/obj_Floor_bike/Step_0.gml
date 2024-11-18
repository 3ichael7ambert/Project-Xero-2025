// Delete obj_Floor when player advances
if (x - PlayerID.x < -(2 * __view_get( e__VW.WView, view_current )))   // If player moves past by certain length, delete floor and set boundary to end of segment
{
    ControllerID.FloorLast = x + FloorLength;
    BoundaryID.phy_position_x = x + FloorLength;
    BoundaryID.phy_position_y = FloorHeight;
    
    instance_destroy();
}

