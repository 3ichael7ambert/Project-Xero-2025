function control_endstep() {
	with(par_planet) {
	    //update all planets
	    x += vx * global.gamespeed
	    y += vy * global.gamespeed
	    image_angle += rotation * global.gamespeed
    
	    if global.planet = id {
	        //update player if on planet
	        with(objPlayer360) {
	            if landed = true {
            
	                planet = global.planet
                
	                //take over planet's speed
	                x += planet.vx * global.gamespeed
	                y += planet.vy * global.gamespeed
                
	                //take over planet's rotation
	                if planet.rotation != 0 {
	                    pdir += planet.rotation * global.gamespeed
	                    x = planet.x+lengthdir_x(plen,pdir)
	                    y = planet.y+lengthdir_y(plen,pdir)
	                    //image angle
	                    image_angle += planet.rotation * global.gamespeed
	                }
	            }
            
	        }
	    }
	}



}
