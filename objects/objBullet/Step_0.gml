/// @description Insert description here
// You can write your code in this editor
if (life_limit==true && life_countdown<=0) 
{
	instance_destroy();
}

if (life_countdown>0)
{
	life_countdown--;
}

if (homing==true) {
	

if  instance_exists(target) {
   delta = point_direction(x, y, target.x, target.y) - direction;
   //find shortest turn to target,turning 4degrees per step
   if abs(delta) > 180 { delta = -delta; }
   if abs(delta) > 4 { direction += 4*sign(delta); }
}
	image_angle=direction;
	 instance_create(x, y, objTrail);
}