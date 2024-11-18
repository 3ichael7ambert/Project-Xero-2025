/// @description Insert description here
/// @description Insert description here
// Example of camera rotation


var _viewMat = matrix_build_lookat(_camX + 100, _camY + 50, camDist, _camX, _camY, 0, 0, 1, 0);


camDist = -500;



global.CameraManager.update();

//cam_update();
//infinitydog_wrap_room_CM();

//cam_wrapper.update(camDist, camFov, camAsp);