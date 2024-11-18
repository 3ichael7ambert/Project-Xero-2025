function planet_step_swing() {
	k = k0 * global.gamespeed

	ax = (endX-x)*k
	ay = (endY-y)*k
	vx += ax
	vy += ay
	vx *= damp
	vy *= damp



}
