function player_jump_360() {
	if keyboard_check_pressed(upKey)
	&& landed = true && jumping = false {

	    get_vxvy(4,gdir-180)
	    vx = _vx
	    vy = _vy
	    landed = false
	    jumping = true
	    alarm[0] = 5
    
	    _slidespeed /= 2
	    _speed = _speed_0
	}



}
