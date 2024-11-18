function player_init() {
	//basic variables
	vx = 0
	vy = 1.5 //you start falling downwards, till you hit a planet
	gdir = 270 //gravity direction
	landed = false
	jumping = false
	moving = false

	_speed_0 = 0.1
	_speed_max = 3
	_speed_add = 0.2
	_speed = _speed_0
	_slidespeed = _speed
	maxspeed = 4

	//keys
	upKey = vk_up
	leftKey = vk_left
	rightKey = vk_right
	downKey = vk_down
	lastKey = "none"

	//animation
	image_speed = 0.2
	img_angle = 0
	image_xscale = 1 //you face right at the start

	//some more weird variables
	fixed = false
	airTime = 0
	_x = 0
	_y = 0
	xLength1 = 0
	xLength2 = 0
	yLength1 = 0
	yLength2 = 0
	angleCheck = 50



}
