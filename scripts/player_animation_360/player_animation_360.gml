function player_animation_360() {
	if lastKey = "left" {
	    image_xscale = -1
	}
	else if lastKey = "right" {
	    image_xscale = 1
	}

	//below, I removed or commented out most animation code
	//since those sprites are not included

	if landed = true {

	    //sprite
	    if moving = true {
	        //sprite_index = sprWalk
	    }
	    else {
	        //sprite_index = sprStand
	    }
    
	    //image angle
	    img_angle += angle_difference(gdir+90,img_angle)/2
    
	    airTime = 0
    
	}
	else {

	    //sprite
	    //sprite_index = sprStand
    
	    //image angle
	    img_angle += angle_difference(gdir+90,img_angle)/10
	}



}
