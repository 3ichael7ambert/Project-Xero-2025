/// obj_cave_extractor_sky.Draw (or End Step in your render order)

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);



// fog optional
var tod = scr_timeofday_color();
var date_time_of_day_color = tod;

draw_light_define_ambient(tod);
gpu_set_fog(true, tod, 100, 1500);





 var cam = view_camera[0]; // Get the camera ID for view 0
if instance_exists(obj_Player1) {
var vw = (camera_get_view_width(cam)/2)+camera_get_view_x(cam);
var vh = obj_Player1.y;//camera_get_view_height(cam);
light_target_x += vw * 0.5;
light_target_y += vh * 0.5;



	light_target_x = obj_Player1.x;//(cam);
    light_target_y = obj_Player1.y;//(cam);
} else
if (view_enabled)
{
   
    light_target_x = camera_get_view_x(cam);
    light_target_y = camera_get_view_y(cam);
	var vw = (camera_get_view_width(cam)/2)+camera_get_view_x(cam);
	var vh = camera_get_view_height(cam);
}
else
{
    // Fallback if views are disabled (uses default camera position)
    light_target_x = camera_get_view_x(view_camera[0]);
    light_target_y = camera_get_view_y(view_camera[0]);
	var vw = (camera_get_view_width(cam)/2)+camera_get_view_x(cam);
	var vh = camera_get_view_height(cam);
}


	draw_set_lighting(true);
	draw_light_define_ambient(date_time_of_day_color);
	draw_light_get_ambient();
	//draw_light_define_point(0, light_target_x, light_target_y, 50, 2000, c_white);
	//draw_light_define_direction(2, vw, vh, 0, c_white);
	draw_light_define_point(1, vw, vh, -300, 500, c_white);
	//draw_light_define_point(1, 200, 123, 50, 2000, c_white);
	draw_light_enable(1, true);
	draw_light_enable(2, true);
	
	
	
builder.submit();

//gpu_set_fog(false, tod, 500, 1000);
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
