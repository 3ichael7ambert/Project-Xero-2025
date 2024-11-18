switch (ControllerID.DebugState)
{
    // Normal play
    case false:
    {
        draw_self();        
        break;
    }
    
    // Debug
    case true:
    {
        break;
    }
}

