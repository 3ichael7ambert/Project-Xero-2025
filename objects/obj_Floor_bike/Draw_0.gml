switch (ControllerID.DebugState)
{
    // Normal play
    case false:
    {
        if (surface_exists(SurfaceID))
        {
            draw_surface(SurfaceID, x, y - FloorOffset);
        }        
        break;
    }
    
    // Debug
    case true:
    {
        break;
    }
}

