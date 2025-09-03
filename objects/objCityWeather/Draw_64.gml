// Camera/view rect
var cam  = view_camera[0];
var vx   = camera_get_view_x(cam);
var vy   = camera_get_view_y(cam);
var vw   = camera_get_view_width(cam);
var vh   = camera_get_view_height(cam);

// Make the fog surface match the VIEW (not GUI)
if (!surface_exists(surf_fog) || surface_get_width(surf_fog)!=vw || surface_get_height(surf_fog)!=vh) {
    if (surface_exists(surf_fog)) surface_free(surf_fog);
    surf_fog = surface_create(vw, vh);
}

// Draw into the fog surface in view coordinates
surface_set_target(surf_fog);
draw_clear_alpha(c_black, 0);

// Fog fill
draw_set_color(fog_col);
draw_set_alpha(fog_density * 0.55);
draw_rectangle(0, 0, vw, vh, false);

// Bottom-heavy gradient (optional)
draw_set_alpha(fog_density * 0.35);
draw_rectangle_colour(0, vh*0.5, vw, vh, c_white, c_white, c_white, c_white, false);

draw_set_alpha(1);
surface_reset_target();

// Blit the fog surface at the camera’s top-left
draw_surface(surf_fog, vx, vy);

// SPLATS: make sure s.x/s.y are in WORLD coords; if they’re GUI coords, convert or draw in GUI.
/// Draw GUI of objCityWeather

// Splats (GUI space)
for (var ii = 0; ii < ds_list_size(splats); ii++) {
    var s = splats[| ii];
    draw_set_alpha(s.a);
    draw_set_color(c_white);
    draw_circle(s.x, s.y, s.r, false);
    draw_set_alpha(s.a * 0.4);
    draw_circle(s.x, s.y, s.r * 1.5, false);
}
draw_set_alpha(1);
draw_set_color(c_white);


draw_set_alpha(1);
draw_set_color(c_white);
