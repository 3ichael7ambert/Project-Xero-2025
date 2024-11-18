function planet_hit() {
	if hit = true {
	    dir = point_direction(objPlayer360.x,objPlayer360.y,x,y)
	    get_vxvy((impact/10)*impactf,dir)
	    vx += _vx
	    vy += _vy
	    hit = false
	}



}
