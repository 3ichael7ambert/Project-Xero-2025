function planet_collision() {
	global.planet = other.id

	if landed = false {
    
	    //swing
	    with(global.planet) {
	        if _type = "swing" {
	            impact = abs(objPlayer360.vx)+abs(objPlayer360.vy)
	            hit = true
	        }
	    }
    
	    //push
	    if global.planet._type = "push" {
	        if jumping = false {
	            with(global.planet) {
	                hitangle = point_direction(objPlayer360.x,objPlayer360.y,x,y)
	                playerangle = objPlayer360.gdir
	                forceangle = angle_difference(hitangle,playerangle)
	                rotation = (forceangle/8)*pushf
	                if rotation >  maxpush rotation =  maxpush
	                if rotation < -maxpush rotation = -maxpush
	            }
	        }
	        else {
	            with(global.planet) {
	                hitangle = point_direction(objPlayer360.x,objPlayer360.y,x,y) - 180
	                playerangle = objPlayer360.gdir - 180
	                forceangle = angle_difference(hitangle,playerangle)
	                rotation = (forceangle/12)*pushf
	            }
	        }
	    }
    
	    pdir = point_direction(x,y,global.planet.x,global.planet.y)-180
	    plen = point_distance(x,y,global.planet.x,global.planet.y)
    
	    fixed = false
    
	}

	if jumping = false {
	    if landed = false {
	        landed = true
	        vx = 0
	        vy = 0
	    }
	}



}
