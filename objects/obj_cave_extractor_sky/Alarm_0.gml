/// obj_cave_extractor_sky.Alarm[0] — (re)build the skyline mesh once at spawn
if (!mesh_dirty) exit;
mesh_dirty = false;
_rebuild_mesh_sky();