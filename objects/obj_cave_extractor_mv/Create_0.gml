/// @description wait

alarm[0] = 1;

builder = new Tile3d();

mesh_dirty  = false;   // set this to true any time sidewalks/buildings change
default_w   = 64;     // fallback width for sidewalk rects
default_h   = 64;     // fallback height for sidewalk rects


mesh_dirty = false;
building_now = false;

light_target_x=camera_get_view_x(0);
light_target_y=camera_get_view_y(0);