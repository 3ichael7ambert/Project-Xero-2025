OnGround = false;   // Collision Event with obj_Floor occurs after which will set to true
                    // This ensures that player cannot jump midair

// Player input
KeyRight = keyboard_check(vk_right);
KeyLeft = -keyboard_check(vk_left);

Move = KeyRight + KeyLeft;

physics_apply_torque(Move * Torque);

// Check zoom state
switch (ZoomState)
{
    // Not progressing or recovering
    case "Null":
    {
        AirTimer--;
        JumpTimer--;
        
        if (AirTimer < 0)                   // If player is in air long enough, begin to zoom out
        {
            ZoomState = "Progress";
        }
        
        break;
    }
    
    // Progressing / Zooming out
    case "Progress":
    {
        if (__view_get( e__VW.WView, view_current ) >= ZoomMax)                    // If max zoom is achieved, don't increase zoom
        {
            __view_set( e__VW.WView, view_current, ZoomMax );
            __view_set( e__VW.HView, view_current, ZoomMax / ViewRatio );
            
            y_ZoomOffset = y_ZoomOffsetMax;
            
            ZoomProgress = ZoomMax;
            ZoomRecovery = ZoomProgress;
            
            break;
        }
        
        var ZoomPercent = (ZoomProgress - ZoomMin) / (ZoomMax - ZoomMin),           // Cubic tweening of camera zoom
            P = median(0, 1, ZoomPercent * ZoomPercent * (3 - (2 * ZoomPercent))),
            a = ZoomMin,
            b = ZoomMax,
            c = round(lerp(a, b, P));
        
        __view_set( e__VW.WView, view_current, c );
        __view_set( e__VW.HView, view_current, c / ViewRatio );
        
        var a = y_ZoomOffsetMin,
            b = y_ZoomOffsetMax;
            
        y_ZoomOffset = round(lerp(a, b, P));                                        // Cubic tweening of player while zooming out
        
        ZoomProgress += ZoomSpeed;
        ZoomRecovery = ZoomProgress;
        
        break;
    }
    
    // Recovering / Zooming in
    case "Recover":
    {
        if (__view_get( e__VW.WView, view_current ) <= ZoomMin)                    // If min zoom is achieved, don't decrease zoom
        {
            __view_set( e__VW.WView, view_current, ZoomMin );
            __view_set( e__VW.HView, view_current, ZoomMin / ViewRatio );
            
            ZoomState = "Null";                                     // Set camera state to Null once fully zoomed in
            
            y_ZoomOffset = y_ZoomOffsetMin;
            
            ZoomRecovery = ZoomMin;
            ZoomProgress = ZoomRecovery;
            
            break;
        }
        
        var ZoomPercent = median(0, 1, (ZoomRecovery - ZoomMin) / ZoomMin),         // Cubic tweening of camera zoom
            P = ZoomPercent * ZoomPercent * (3 - (2 * ZoomPercent)),
            a = ZoomMin,
            b = ZoomMax,
            c = round(lerp(a, b, P));
            
        __view_set( e__VW.WView, view_current, c );
        __view_set( e__VW.HView, view_current, c / ViewRatio );
        
        var a = y_ZoomOffsetMin,                                                    // Cubic tweening of player while zooming in
            b = y_ZoomOffsetMax,
            c = round(lerp(a, b, P));
            
        y_ZoomOffset = round(lerp(a, b, P));
        
        ZoomRecovery -= 4 * ZoomSpeed;                                              // Increase multiplier to zoom in faster
        ZoomProgress = ZoomRecovery;
        
        break;
    }
}

// View follows player
__view_set( e__VW.XView, view_current, max(0, ControllerID.FloorLast, x - (__view_get( e__VW.WView, view_current )) / 4 ));
__view_set( e__VW.YView, view_current, y + y_ZoomOffset - (__view_get( e__VW.HView, view_current ) / 2) );

