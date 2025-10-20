global.CameraManager.update();

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