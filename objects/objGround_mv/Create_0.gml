/// @desc Create (Ground)
// event_inherited(); // only if you actually have a parent

// --- Tunables ---
tile_step  = 64;      // tile size/progression
reach      = 1024;    // how far in each direction
sprite     = sprSand; // atlas for ground
spriteBG   = sprMtnDist;



// Helper: make symmetric offsets [-reach..+reach] stepping by tile_step, with 0 included.
function __make_offsets(_reach, _step) {
    var arr = [];
    // negative side
    for (var d = -_reach; d <= _reach; d += _step) {
        array_push(arr, d);
    }
    return arr;
}

// 1) Build top row (flat) matrices
dx_list = __make_offsets(reach, tile_step);   // <- we will also expose this to the extractor
var n   = array_length(dx_list);

transform_selections = array_create(n);
for (var i = 0; i < n; i++) {
    // roll=90 makes the sprite plane lie flat
    //transform_selections[i] = build_drawing_matrix(x, y, dx_list[i], 90, 0, 0);
	// was: build_drawing_matrix(x, y, dx, 90, 0, 0)
	transform_selections[i] = build_drawing_matrix_scale(x, y, dx_list[i], 90, 0, 0, -1, 1, 1);

}


// 2) Frames: default 0, override any you like
transform_index = array_create(n, 0);

// 3) Positions: -1 means "use full sprite"
position_update = array_create(n, -1);

// 4) Tell extractor to rebuild
var ex = instance_find(obj_cave_extractor_mv, 0);
if (ex != noone) ex.mesh_dirty = true;
