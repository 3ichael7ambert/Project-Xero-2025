function planet_step_circular() {
	cangle += ( (360*cspeed) / (2*(pi*cradius)) )*global.gamespeed
	if cangle > 360 cangle = 0
	sx = lengthdir_x(cradius,cangle)+(xstart-(cx-xstart))
	sy = lengthdir_y(cradius,cangle)+(ystart-(cy-ystart))
	vx = sx-xprevious
	vy = sy-yprevious



}
