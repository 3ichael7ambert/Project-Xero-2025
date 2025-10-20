/// objControl_sky.Step — keep player in MV rules + start game
fpsreal = fps_real;

if (instance_exists(obj_Player1)) {
    with (obj_Player1) {
        jetpack_mode        = 2;
        can_switch_jetpack  = false;
       // game_style          = "mv";
        can_switch_weapons  = false;
        weapon              = 1;
    }
    game_start = true;
}

// enemy director (shares your MV script)
scr_Director_Update_mv();
