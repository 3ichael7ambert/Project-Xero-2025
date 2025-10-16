

// Re-grab the live camera center AFTER the manager moved it
var cam   = view_camera[0];
var vw    = camera_get_view_width(cam);
var vh    = camera_get_view_height(cam);
var cx    = camera_get_view_x(cam) + vw * 0.5;
var cy    = camera_get_view_y(cam) + vh * 0.66;

var viewMat = matrix_build_lookat(cx, cy, camDist,  cx, cy, -100,   0, -1, 0);
var projMat = matrix_build_projection_perspective_fov(camFov, camAsp, 1000, -1000);

camera_set_view_mat(cam, viewMat);
camera_apply(view_camera[0]);
camera_set_proj_mat(cam, projMat);
