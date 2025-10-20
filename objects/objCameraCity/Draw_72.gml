/// DRAW BEGIN (or a world draw script) — set view/projection once
var camera = view_camera[0];
var vw = camera_get_view_width(camera);
var vh = camera_get_view_height(camera);
var cx = camera_get_view_x(camera) + vw * 0.5;
var cy = camera_get_view_y(camera) + vh * 0.5;

// Your 3D camera (eye) uses the *wrapped* center (cx, cy)
var camDist = -1500;    // your values
var camFov  = 80;
var camAsp  = vw / vh;

var viewMat = matrix_build_lookat(cx, cy, camDist, cx, cy, 0, 0, 1, 0);
var projMat = matrix_build_projection_perspective_fov(camFov, camAsp, 3, 3000);

camera_set_view_mat(camera, viewMat);
camera_set_proj_mat(camera, projMat);
// DO NOT call camera_apply() when using views; the engine uses the camera automatically.
 