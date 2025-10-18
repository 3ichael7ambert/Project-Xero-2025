/// objEnemyBullet_mv.Step
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
life--;
if (life <= 0) instance_destroy();

// destroy off-screen
var cam = view_get_camera(0);
var vx  = camera_get_view_x(cam), vy = camera_get_view_y(cam);
var vw  = camera_get_view_width(cam), vh = camera_get_view_height(cam);
if (x < vx-64 || x > vx+vw+64 || y < vy-64 || y > vy+vh+64) instance_destroy();

// TODO: handle collision with world / player here
