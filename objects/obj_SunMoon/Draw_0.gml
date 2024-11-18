/// @description Insert description here
// You can write your code in this editor



gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

//sun
if current_hour>=6 and current_hour<=18{
draw_sprite_3d(sprSunMoon,0,xSun,ySun,zSun,0,0,0);




for (var i = 0; i < flareCount; i++) {
	

	
	var viewCenterX = view_xview + view_wview / 2;
	var viewCenterY = view_yview + view_hview / 2;
	
		 // Randomize distance from the sun
    //var distance = point_distance(xSun,ySun,(viewCenterX+target.x)/2,(viewCenterY+target.y)/2)/80;
	var distance = point_distance(xSun,ySun,target.x,target.y);
	
	var distanceZ = point_distance_3d(xSun,ySun,zSun,(viewCenterX+target.x)/2,(viewCenterY+target.y)/2,0)/80;
	
	var dirToPlayer = point_distance(xSun,ySun,target.x,target.y);
   // Calculate offsets using lengthdir
    var offsetx = lengthdir_x(distance, dirToPlayer);
    var offsety = lengthdir_y(distance, dirToPlayer);

    // Calculate position based on flare offsets
    var xFlare = xSun + offsetx;
    var yFlare = ySun + offsety;

    // Draw lens flare with random sprite index
    draw_sprite_3d(sprSunMoon, randImg[i], xFlare*i,yFlare*i, zSun-distanceZ*i, 0, 0, 0);
}


}

//moon
if current_hour<=6 and current_hour>=18{
draw_sprite_3d(sprSunMoon,1,xMoon,yMoon,zMoon,0,0,0);
}
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);













