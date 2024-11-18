function move_jet(argument0) {
	//this script is used to move the player left and right (walking)
	//it doesn't make much sense but it works...

	if argument0 = "left"
	{

	for (i=0; i<angleCheck; i+= 1)
	{

	leftAngle = gdir - 90-i
	stepLength = _speed

	xPlus = lengthdir_x(stepLength,leftAngle)
	yPlus = lengthdir_y(stepLength,leftAngle)

	    {
	        x += xPlus 
	        y += yPlus 
	        exit;
	    }

	}

	}
	else if argument0 = "right"
	{

	for (i=0; i<angleCheck; i+= 1)
	{

	leftAngle = gdir + 90+i
	stepLength = _speed

	xPlus = lengthdir_x(stepLength,leftAngle)
	yPlus = lengthdir_y(stepLength,leftAngle)

	    {
	        x += xPlus
	        y += yPlus
	        exit;
	    }

	}

	}



}
