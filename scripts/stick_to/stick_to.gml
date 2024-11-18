/// @description stick_to(object, include_angle?)
/// @param object
/// @param  include_angle?
function stick_to(argument0, argument1) {
	var obj = argument0;
	var ang = argument1;

	if (instance_exists(obj))
	{
	    x = obj.x;
	    y = obj.y;
	    if (ang)
	    {
	        image_angle = obj.image_angle;
	    }
	}




}
