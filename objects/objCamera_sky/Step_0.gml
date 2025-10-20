//global.CameraManager.update();

var cam = view_get_camera(0);
if (camera_get_view_x(cam) > last_cam_x) {
	last_cam_x=camera_get_view_x(cam);
}

global.CameraManager.setBounds(last_cam_x, 0, last_cam_x+10000, room_height+10000);

if (instance_exists(obj_Player1)) {
	if (obj_Player1.x <= last_cam_x) {
		obj_Player1.x = last_cam_x;
	}
}

/// @description Insert description here
/// @description Insert description here
// Example of camera rotation


//var _viewMat = matrix_build_lookat(_camX + 100, _camY + 50, camDist, _camX, _camY, 0, 0, 1, 0);


//camDist = -1500;



global.CameraManager.update();

//cam_update();
//infinitydog_wrap_room_CM();

//cam_wrapper.update(camDist, camFov, camAsp);

with (objBuilding_sky) {
	if x 
	//+ (objBuilding_sky.TILE*objBuilding_sky.building_width)) 
	< objCamera_sky.last_cam_x 
	{
		instance_destroy();
	}
}