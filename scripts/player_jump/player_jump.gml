function player_jump() {
	if (jetpack_mode==1) {
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
	
	
	if (jetpack_mode==2) {
	if keyboard_check_pressed(upKey)
	&& landed = true && jumping = false {

	    get_vxvy(4,gdir-180)
	    vx = _vx
	    vy = _vy
	    landed = false
	    jumping = true
	    alarm[0] = 5
    
	    _slidespeed /= 1.01
	   // _speed = _speed_0
	}

	}
	
	if jetpack_mode=3 {
		
		if keyboard_check(upKey)
	 {

	    get_vxvy(8,gdir-180)
	    vx += _vx
	    vy += _vy
	   // landed = false
	  //  jumping = true
	   // alarm[0] = 5
    
	    _slidespeed /= 1.01
	   // _speed = _speed_0
	}


	if keyboard_check(downKey)
	&& landed = false  {

	    get_vxvy(8,gdir)
	    vx += _vx
	    vy += _vy
	    //landed = false
	   // jumping = true
	    //alarm[0] = 5
    
	    _slidespeed /= 1.01
	    //_speed = _speed_0
	}


	}

}
