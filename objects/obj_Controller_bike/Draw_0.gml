// Debug view
switch (DebugState)
{
    // Debug disabled
    case false:
    {
        break;
    }
    
    // Debug enabled
    case true:
    {
        physics_world_draw_debug(Flags);        // draw debug flags
        break;
    }
}

