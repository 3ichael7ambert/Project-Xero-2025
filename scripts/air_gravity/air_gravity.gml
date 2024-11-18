function air_gravity() {
	found1 = false
	found2 = false
	startdir = gdir

	airTime += 1

	//first use a circle
	for(i=1; i<=50; i+=1) {
	    len = i*10//14
	    if collision_circle(x,y,len,par_planet,true,false) {
	        found1 = true
	        //draw
	        if global.debug = true {
	            draw_set_color(c_red)
	            draw_circle(x,y,len,true)
	        }
	        break
	    }
	}

	mode = 1
	//then find the angle
	if found1 = true {
	    for(i=0; i<=36; i+=1) {
	        if mode = 1 {
	            dir = startdir + ((i*(360/36))/2)
	            mode = 2
	        }
	        else {
	            dir = startdir - ((i*(360/36))/2)
	            mode = 1
	        }
	        _x = x+lengthdir_x(len+1,dir)
	        _y = y+lengthdir_y(len+1,dir)
        
	        if global.debug = true {
	            draw_set_color(c_purple)
	            draw_line(x,y,_x,_y)
	        }
        
	        if collision_point(_x,_y,par_planet,true,false) {
	            found2 = true
	            //draw
	            if global.debug = true {
	                draw_set_color(c_red)
	                draw_circle(_x,_y,3,false)
	            }
	            break
	        }
        
	    }
	}

	if found2 = true {
	    gx += _x-x
	    gy += _y-y
		
		if (jetpack_mode==1) || (jetpack_mode==2) {
	    strength = 0.25 //strength of the gravity of planets
		} else if (jetpack_mode==3) {
			strength=.1;
		}
	    vx += (gx*strength)/250
	    vy += (gy*strength)/250
    
	    gdir = point_direction(x,y,_x,_y)
    
	    //airtime
	    //the longer you are flying through the air the harder the gravity pulls you
	    //this was done to make players stop floating too much
		if (jetpack_mode==1) || (jetpack_mode==2) {
	    if 20-airTime < 0 {
	        get_vxvy(airTime,gdir)
	        vx += _vx/100
	        vy += _vy/100
	    }
		}
    
	}



}
