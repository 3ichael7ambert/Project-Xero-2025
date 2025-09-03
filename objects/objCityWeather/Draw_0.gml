// Draw particles in world space (they were spawned in view coords already)
part_system_drawit(ps);


// Draw (world)
part_system_drawit(ps);

// View rect
var cam = view_camera[0];
var vx  = camera_get_view_x(cam);
var vy  = camera_get_view_y(cam);
var vw  = camera_get_view_width(cam);
var vh  = camera_get_view_height(cam);

// Fog surface sized to VIEW
if (!surface_exists(surf_fog) || surface_get_width(surf_fog)!=vw || surface_get_height(surf_fog)!=vh) {
    if (surface_exists(surf_fog)) surface_free(surf_fog);
    surf_fog = surface_create(vw, vh);
}

surface_set_target(surf_fog);
draw_clear_alpha(c_black, 0);

draw_set_color(fog_col);
draw_set_alpha(fog_density * 0.55);
draw_rectangle(0, 0, vw, vh, false);

// bottom-heavy gradient
draw_set_alpha(fog_density * 0.35);
draw_rectangle_colour(0, vh*0.5, vw, vh, c_white, c_white, c_white, c_white, false);

draw_set_alpha(1);
surface_reset_target();

// draw aligned to view origin
draw_surface(surf_fog, vx, vy);
