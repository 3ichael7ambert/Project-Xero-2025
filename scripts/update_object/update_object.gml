function update_object(argument0) {
	obj = argument0

	with(obj) {
	    //take over planet position
	    x += planet.vx * global.gamespeed
	    y += planet.vy * global.gamespeed
    
	    //take over planet's rotation
	    if planet.rotation != 0 {
	        dir = angle + planet.image_angle - 180
	        x = planet.x+lengthdir_x(plen,dir)
	        y = planet.y+lengthdir_y(plen,dir)
	        //image angle
	        image_angle += planet.rotation * global.gamespeed
	    }
	}



}
