/// @param dir-start
/// @param dir-end
/// @param rotate-spd
function rotate_smooth(dir,dest,spd){
	/*
	speed = degrees per frame
	*/
	/// wrap direction around 360 degree increments
	var da = angle_difference(dest, dir);
	var rot = da != 0 ? min(abs(da), spd) * sign(da) : 0;
	//Smoothly rotates dir towards dest in the quickest direction...
	return(dir+rot);
}