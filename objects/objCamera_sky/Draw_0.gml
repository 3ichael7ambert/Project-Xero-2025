/// @description Insert description here
// Update 3D camera
/*

_camW = camera_get_view_width(camera);
_camH = camera_get_view_height(camera);
_camX = camera_get_view_x(camera) + _camW / 2;
 _camY = camera_get_view_y(camera) + _camH / 2;

var _viewMat = matrix_build_lookat(_camX, _camY, camDist, _camX, _camY, 0, 0, 0, 0);
var _projMat = matrix_build_projection_perspective_fov(camFov, camAsp, 3, 3000);


camera_set_view_mat(camera, _viewMat);
camera_set_proj_mat(camera, _projMat);

camera_apply(camera);

//cam_wrapper.update(camDist, camFov, camAsp);
//camera_apply(cam_wrapper);












