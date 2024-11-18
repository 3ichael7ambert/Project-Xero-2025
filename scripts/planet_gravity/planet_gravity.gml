function planet_gravity() {

	draw_set_color(c_green);
	pointDist = 8;//10
/*
if (jetpack_mode==1) || (jetpack_mode==2) {
	pointDist = 8;//10
} else if (jetpack_mode=3) {
		pointDist = 1;//10
}
*/

	xDist1 = x+lengthdir_x(pointDist,gdir-90)
	yDist1 = y+lengthdir_y(pointDist,gdir-90)
	if global.debug = true draw_circle(xDist1,yDist1,3,0)

	xDist2 = x+lengthdir_x(pointDist,gdir+90)
	yDist2 = y+lengthdir_y(pointDist,gdir+90)
	if global.debug = true draw_circle(xDist2,yDist2,3,0)

	legLength = 50

	for (i[0]=0; i[0]<legLength; i[0]+=1){

	xLength1 = xDist1+lengthdir_x(i[0],gdir)
	yLength1 = yDist1+lengthdir_y(i[0],gdir)

	if collision_point(xLength1,yLength1,par_planet,1,1) break;
	if global.debug = true draw_line(xDist1,yDist1,xLength1,yLength1)
	}

	for(i[1]=0; i[1]<legLength; i[1]+=1){

	xLength2 = xDist2+lengthdir_x(i[1],gdir)
	yLength2 = yDist2+lengthdir_y(i[1],gdir)

	if collision_point(xLength2,yLength2,par_planet,1,1) break;
	if global.debug = true draw_line(xDist2,yDist2,xLength2,yLength2)
	}

	if global.debug = true {
	draw_set_color(c_red)
	draw_circle(xLength1,yLength1,3,0)
	draw_circle(xLength2,yLength2,3,0)

	draw_set_color(c_blue)
	draw_line(xLength1,yLength1,xLength2,yLength2)
	}

	//set gdir
	gdir = point_direction(xLength1,yLength1,xLength2,yLength2)-90

	if fixed = false {
	    fix_position()
	    fixed = true
	}



}
