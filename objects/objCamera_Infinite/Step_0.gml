/// @description Insert description here
// Example of camera rotation
var _viewMat = matrix_build_lookat(_camX + 100, _camY + 50, camDist, _camX, _camY, 0, 0, 1, 0);

// Example of focusing on a character
camDist = -200; // Adjust the distance as needed


global.CameraManager.update();


if instance_exists(obj_Player1){
x=obj_Player1.x;
y=obj_Player1.y;
}