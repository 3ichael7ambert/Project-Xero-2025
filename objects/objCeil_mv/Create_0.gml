/// @desc Create (Ceiling)
// event_inherited();

tile_step  = 64;
reach      = 1024;
sprite     = sprSand;
spriteBG   = sprMtnDist;

function __make_offsets(_reach, _step) {
    var arr = [];
    for (var d = -_reach; d <= _reach; d += _step) array_push(arr, d);
    return arr;
}

dx_list = __make_offsets(reach, tile_step);
var n   = array_length(dx_list);

transform_selections = array_create(n);
for (var i = 0; i < n; i++) {
    transform_selections[i] = build_drawing_matrix(x, y, dx_list[i], 90, 0, 0); // flat
}

transform_index = array_create(n, 0);
position_update = array_create(n, -1);

var ex = instance_find(obj_cave_extractor_mv, 0);
if (ex != noone) ex.mesh_dirty = true;
