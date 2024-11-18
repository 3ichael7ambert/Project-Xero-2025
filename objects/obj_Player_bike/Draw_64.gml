switch (ControllerID.DebugState)
{
    // Normal play
    case false:
    {
        break;
    }
    
    // Debug
    case true:
    {
        draw_set_font(fnt_Debug_s14_bike);
        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_text(display_get_gui_width() - 8, 8, string_hash_to_newline("ZoomState: " + ZoomState));
        
        break;
    }
}

