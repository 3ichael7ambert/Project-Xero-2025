/// @description Creates an instance of a given object at a given position.
/// @param x The x position the object will be created at.
/// @param y The y position the object will be created at.
/// @param obj The object to create an instance of.
function instance_create(xx, yy, obj) {
	var myDepth = object_get_depth( obj );
	return instance_create_depth( xx, yy, myDepth, obj );



}