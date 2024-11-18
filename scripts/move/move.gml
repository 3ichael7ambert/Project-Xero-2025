function move(str_dir) {
	//this script is used to move the player left and right (walking)
	//it doesn't make much sense but it works...

	if str_dir = "left"
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
	else if str_dir = "right"
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
		else if str_dir = "up"
	{

	for (i=0; i<angleCheck; i+= 1)
	{

	leftAngle = gdir - 180+i
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
		else if str_dir = "down"
	{

	for (i=0; i<angleCheck; i+= 1)
	{

	leftAngle = gdir + 180+i
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
