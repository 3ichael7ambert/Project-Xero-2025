function player_movement() {
	if jetpack_mode=1 {
	if landed = true {
    
	    //on planet
	    moving = false
	    if keyboard_check(rightKey)
	    && keyboard_check(leftKey) {
	        //stand still
	    }
	    else if keyboard_check(leftKey) {
	        if lastKey = "right" _speed = _speed_0
	        lastKey = "left"
	        moving = true
	    }
	    else if keyboard_check(rightKey) {
	        if lastKey = "left" _speed = _speed_0
	        lastKey = "right"
	        moving = true
	    }
    
	    if moving = true {
	        fix_position()
	        //_speed = _speed_0
	        if _speed < _speed_max {
	            _speed += _speed_add
	        }
	        _slidespeed = _speed
	        move(lastKey)
	        //reset when on rotating planet
	        if global.planet.rotation != 0 {
	            pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	            plen = point_distance(x,y,global.planet.x,global.planet.y)
	        }
	    }
	    else {
	        _speed = _slidespeed
	        move(lastKey)
	        _slidespeed /= 1.15
	        //reset when on rotating planet
	        if global.planet.rotation != 0 {
	            pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	            plen = point_distance(x,y,global.planet.x,global.planet.y)
	        }
	        _speed = _speed_0
	    }
    
	}
	else {
    
	    //in air
	    w = 50
	    if keyboard_check(rightKey)
	    && keyboard_check(leftKey) {
	        //nothing
	    }
	    else if keyboard_check(leftKey) {
	        get_vxvy(8,gdir-90)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "left"
	    }
	    else if keyboard_check(rightKey) {
	        get_vxvy(8,gdir+90)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "right"
	    }
    
	}
	}

	if jetpack_mode=2 {
	if landed = true {
    
	    //on planet
	    moving = false;
	    if keyboard_check(rightKey)
	    && keyboard_check(leftKey) {
	        //stand still
	    }
	    else if keyboard_check(leftKey) {
	        if (lastKey = "right") {_speed = _speed_0;}
	        lastKey = "left";
	        moving = true;
	    }
	    else if keyboard_check(rightKey) {
	        if (lastKey = "left") _speed = _speed_0;
	        lastKey = "right";
	        moving = true;
	    }
    
	    if moving = true {
	        fix_position();
	        //_speed = _speed_0
			
	        if _speed < _speed_max {
	            _speed += _speed_add
	        }
	        _slidespeed = _speed
	        move(lastKey);
	        //reset when on rotating planet
	        if global.planet.rotation != 0 {
	            pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	            plen = point_distance(x,y,global.planet.x,global.planet.y)
	        }
			
	    }
	    else {
	        _speed = _slidespeed
	        move(lastKey)
	        _slidespeed /= 1.01;
	        //reset when on rotating planet
	        if global.planet.rotation != 0 {
	            pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	            plen = point_distance(x,y,global.planet.x,global.planet.y)
	        }
	        _speed = _speed_0
	    }
    
	}
	else {
    
	    //in air
	    w = 50
	    if keyboard_check(rightKey)
	    && keyboard_check(leftKey) {
	        //nothing
	    }
	    else if keyboard_check(leftKey) {
	        get_vxvy(8,gdir-90)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "left"
	    }
	    else if keyboard_check(rightKey) {
	        get_vxvy(8,gdir+90)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "right"
	    }
    
	}
}






	if jetpack_mode=3 {
		
	if landed = true {
    
	    //on planet
	    //moving = false;
	    if keyboard_check(rightKey)
	    && keyboard_check(leftKey) {
	        //stand still
	    }
	    else if keyboard_check(leftKey) {
	        if (lastKey = "right") {_speed = _speed_0;}
	        lastKey = "left";
	        moving = true;
	    }
	    else if keyboard_check(rightKey) {
	        if (lastKey = "left") {_speed = _speed_0;}
	        lastKey = "right";
	        moving = true;
	    }
		    else if keyboard_check(upKey) {
	        if (lastKey = "down") {_speed = _speed_0;}
	        lastKey = "up";
	        moving = true;
	    }
	    else if keyboard_check(downKey) {
	        if (lastKey = "up") {_speed = _speed_0;}
	        lastKey = "down";
	        moving = true;
	    }
    
	    if moving = true {
	        fix_position();
	        //_speed = _speed_0
			
	        if _speed < _speed_max {
	            _speed += _speed_add
	        }
	        _slidespeed = _speed
	        move(lastKey);
	        //reset when on rotating planet
	        if global.planet.rotation != 0 {
	            pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	            plen = point_distance(x,y,global.planet.x,global.planet.y)
	        }
			
	    }
	    else {
	        _speed = _slidespeed
	        move(lastKey)
	        _slidespeed /= 1.01
	        //reset when on rotating planet
	        if global.planet.rotation != 0 {
	            pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	            plen = point_distance(x,y,global.planet.x,global.planet.y)
	        }
	        //_speed = _speed_0
	    }
    
	}
	else {
    
	    //in air
	    w = 1
	    if keyboard_check(rightKey)
	    && keyboard_check(leftKey) {
	        //nothing
	    }
	    else if keyboard_check(leftKey) {
	        get_vxvy(8,gdir-90)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "left"
	    }
	    else if keyboard_check(rightKey) {	
	        get_vxvy(8,gdir+90)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "right"
	    }
		    else if keyboard_check(upKey) {
	        get_vxvy(8,gdir-80)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "up"
	    }
	    else if keyboard_check(downKey) {	
	        get_vxvy(8,gdir+180)
	        vx += _vx/w
	        vy += _vy/w
	        lastKey = "down"
	    }
    
	}
}


}
