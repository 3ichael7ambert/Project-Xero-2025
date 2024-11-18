switch (ControllerID.DebugState)
{
    // Normal play
    case false:
    {
        if (surface_exists(SurfaceID))
        {
            // Draw trail
            draw_set_blend_mode(bm_add);
          //  draw_surface(SurfaceID, RearTireID.phy_position_x - surface_get_width(SurfaceID), RearTireID.phy_position_y - surface_get_height(SurfaceID)/2);
            draw_set_blend_mode(bm_normal);
        }
        draw_self();        
        break;
    }
    
    // Debug
    case true:
    {
        break;
    }
}

draw_self();
//draw_sprite_ext(spr_wheel,0,)