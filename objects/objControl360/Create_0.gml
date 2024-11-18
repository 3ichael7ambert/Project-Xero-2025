global.planet = noone
global.gamespeed = 1
global.debug = false

if instance_exists(objPlayer360) {
	target=objPlayer360;
}
else if instance_exists(obj_Player1) {
	target=obj_Player1;
}
else 
{
	target=self;
}
instance_create(target.x,target.y,objCamera360) //create the camera

