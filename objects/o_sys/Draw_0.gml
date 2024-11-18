surface_set_target(surf_final);
draw_clear_alpha(0,0);
gpu_set_fog(1,0,0,99);
var count = 10;
var thickness = 2;
for (var i = 0; i < count; ++i) {
    draw_surface(global.surf_outline,lengthdir_x(thickness, 360/count*i),lengthdir_y(thickness, 360/count*i));
};
gpu_set_fog(0,0,0,0);
draw_surface(global.surf_outline,0,0);
surface_reset_target();

var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
draw_surface_part(surf_final, cx, cy, view_wport[0], view_hport[0], cx, cy);

surface_set_target(global.surf_outline);
draw_clear_alpha(0,0);
surface_reset_target();