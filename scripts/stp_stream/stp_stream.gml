/// @description  stp_stream();
function stp_stream() {
	/*-------------------------------
	This script updates the variables
	and allows particles to be
	streamed over time
	---------------------------------/*
	/*----- VARIABLES ----------
	period = 15;
	count = 5;
	radius = 16;
	particle = PARTICLE_ENGINE.pSmack;
	above = true;
	--------------------------*/

	if(count > 0){
	    /// decrement count
	    count--;
	    /// find position inside radius relative to particle position
	    var xx, yy;
	    xx = x+irandom_range(-radius,radius);
	    yy = y+irandom_range(-radius,radius);
	    /// create particles
	    burst_particle(particle,xx,yy,count,above);
	} else {
	    instance_destroy();
	}



}
