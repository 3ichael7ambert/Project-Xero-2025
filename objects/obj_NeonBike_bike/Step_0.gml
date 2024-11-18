OnGround = false;   // Collision Event with obj_Floor occurs after which will set to true
                    // This ensures that player cannot jump midair

// Player input
KeyUp = keyboard_check(vk_up);
KeyDown = -keyboard_check(vk_down);

Move = KeyUp + KeyDown;

physics_apply_torque(Move * Torque);

// Surface
if (surface_exists(SurfaceID))
{
    dx = RearTireID.phy_position_x - RearTireID.phy_position_xprevious;
    dy = RearTireID.phy_position_y - RearTireID.phy_position_yprevious;
    
    surface_set_target(SurfaceID);
    
    draw_set_alpha(1);
    draw_set_colour(c_white);
    
    draw_surface(SurfaceID, -dx, -dy);
    
    draw_primitive_begin_texture(pr_trianglestrip, TrailTexture);
    draw_vertex_texture(surface_get_width(SurfaceID) - dx, -TrailTextureHeight/2 - dy + surface_get_height(SurfaceID)/2, 0, 1);
    draw_vertex_texture(surface_get_width(SurfaceID), -TrailTextureHeight/2 + surface_get_height(SurfaceID)/2, 1, 1);
    draw_vertex_texture(surface_get_width(SurfaceID) - dx, TrailTextureHeight/2 - dy + surface_get_height(SurfaceID)/2, 0, 0);
    draw_vertex_texture(surface_get_width(SurfaceID), TrailTextureHeight/2 + surface_get_height(SurfaceID)/2, 1, 0);
    draw_primitive_end();
    
    // Top half of mask
    draw_primitive_begin_texture(pr_trianglestrip, VoidTexture);
    draw_vertex_texture(surface_get_width(SurfaceID) - dx, 0, 0, 1);
    draw_vertex_texture(surface_get_width(SurfaceID), 0, 1, 1);
    draw_vertex_texture(surface_get_width(SurfaceID) - dx, -TrailTextureHeight/2 - dy + surface_get_height(SurfaceID)/2, 0, 0);
    draw_vertex_texture(surface_get_width(SurfaceID), -TrailTextureHeight/2 + surface_get_height(SurfaceID)/2, 1, 0);
    draw_primitive_end();
    
    // Bottom half of mask
    draw_primitive_begin_texture(pr_trianglestrip, VoidTexture);
    draw_vertex_texture(surface_get_width(SurfaceID) - dx, TrailTextureHeight/2 - dy + surface_get_height(SurfaceID)/2, 0, 1);
    draw_vertex_texture(surface_get_width(SurfaceID), TrailTextureHeight/2 + surface_get_height(SurfaceID)/2, 1, 1);
    draw_vertex_texture(surface_get_width(SurfaceID) - dx, surface_get_height(SurfaceID), 0, 0);
    draw_vertex_texture(surface_get_width(SurfaceID), surface_get_height(SurfaceID), 1, 0);
    draw_primitive_end();
    
    surface_reset_target();
}

// Check zoom state
switch (ZoomState)
{
    // Not progressing or recovering
    case "Null":
    {
        AirTimer--;
        
        if (AirTimer < 0)
        {
            ZoomState = "Progress";
        }
        
        break;
    }
    
    // Progressing / Zooming out
    case "Progress":
    {
        if (__view_get( e__VW.WView, view_current ) >= ZoomMax)
        {
            __view_set( e__VW.WView, view_current, ZoomMax );
            __view_set( e__VW.HView, view_current, ZoomMax / ViewRatio );
            
            y_ZoomOffset = y_ZoomOffsetMax;
            
            ZoomProgress = ZoomMax;
            ZoomRecovery = ZoomProgress;
            
            break;
        }
        
        var ZoomPercent = (ZoomProgress - ZoomMin) / (ZoomMax - ZoomMin),
            P = median(0, 1, ZoomPercent * ZoomPercent * (3 - (2 * ZoomPercent))),
            a = ZoomMin,
            b = ZoomMax,
            c = round(lerp(a, b, P));
        
        __view_set( e__VW.WView, view_current, c );
        __view_set( e__VW.HView, view_current, c / ViewRatio );
        
        var a = y_ZoomOffsetMin,
            b = y_ZoomOffsetMax;
            
        y_ZoomOffset = round(lerp(a, b, P));
        
        ZoomProgress += ZoomSpeed;
        ZoomRecovery = ZoomProgress;
        
        break;
    }
    
    // Recovering / Zooming in
    case "Recover":
    {
        if (__view_get( e__VW.WView, view_current ) <= ZoomMin)
        {
            __view_set( e__VW.WView, view_current, ZoomMin );
            __view_set( e__VW.HView, view_current, ZoomMin / ViewRatio );
            
            ZoomState = "Null";
            
            y_ZoomOffset = y_ZoomOffsetMin;
            
            ZoomRecovery = ZoomMin;
            ZoomProgress = ZoomRecovery;
            
            break;
        }
        
        var ZoomPercent = median(0, 1, (ZoomRecovery - ZoomMin) / ZoomMin),
            P = ZoomPercent * ZoomPercent * (3 - (2 * ZoomPercent)),
            a = ZoomMin,
            b = ZoomMax,
            c = round(lerp(a, b, P));
            
        __view_set( e__VW.WView, view_current, c );
        __view_set( e__VW.HView, view_current, c / ViewRatio );
        
        var a = y_ZoomOffsetMin,
            b = y_ZoomOffsetMax,
            c = round(lerp(a, b, P));
            
        y_ZoomOffset = round(lerp(a, b, P));
        
        ZoomRecovery -= 4 * ZoomSpeed;
        ZoomProgress = ZoomRecovery;
        
        break;
    }
}

// View follows player
__view_set( e__VW.XView, view_current, max(0, ControllerID.FloorLast, x - (__view_get( e__VW.WView, view_current )) / 4 ));
__view_set( e__VW.YView, view_current, y + y_ZoomOffset - (__view_get( e__VW.HView, view_current ) / 2) );

