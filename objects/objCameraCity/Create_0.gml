/// @description Camera properties

init_sys_camera();

//////
cam_reset(1920, 1080, 1, obj_Player1);
cam_wrapper = new CamWrap(global.CameraManager.w, global.CameraManager.h);
	
	
camera = view_camera[0];
camDist = -3000; // Adjust as needed
camFov = 90;    // Adjust field of view as needed
camAsp = camera_get_view_width(camera) / camera_get_view_height(camera);


_camW = camera_get_view_width(camera);
_camH = camera_get_view_height(camera);
_camX = camera_get_view_x(camera) + _camW / 2;
_camY = camera_get_view_y(camera) + _camH / 2;

cam_min=-300;
cam_max=-3000;
speed=3;

global.CameraManager.target = obj_Player1;

