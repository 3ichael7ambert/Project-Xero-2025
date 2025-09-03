/// @description  stream_particles(str-obj,x,y,time,count,radius,particle,above,friction,gravity,speed);
/// @param str-obj
/// @param x
/// @param y
/// @param time
/// @param count
/// @param radius
/// @param particle
/// @param above
/// @param friction
/// @param gravity
/// @param speed
function stream_particles() {
	/*---------------------------------
	Set all the variables in stream object
	to create a dynamic particle effect(s)
	-----------------------------------*/
	///----------- VARIABLES
	var _arr = array(_stream,0,0,0.25,5,16,PARTICLE_ENGINE.pSmack,true,0.5,0,array(0,0));


	/// grab from arguments
	for(var i = 0; i < argument_count; i++){
	    /// if first argument contains all array data
	    /// just use the argument0 data and continue
	    if(i == 0){
	        if(is_array(argument[i])){
	            _arr = argument[i];
	            break;
	        }
	    }
	    _arr[i] = argument[i];
	}

	/// create streaming object
	var _obj = instance_create_depth(_arr[1],_arr[2],0,_arr[0]);

	//--------- Set Stream Object Properties
	_obj.period = _arr[3];
	_obj.count = _arr[4];
	_obj.radius = _arr[5];
	_obj.particle = _arr[6];
	_obj.above = _arr[7];

	/// set movement properties
	_obj.friction = _arr[8];
	_obj.gravity_direction = 270;
	_obj.gravity = _arr[9];
	var _spd = _arr[10];
	_obj.hspeed = _spd[0];
	_obj.vspeed = _spd[1];




}
