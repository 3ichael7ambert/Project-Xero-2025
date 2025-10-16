/// @desc Create (Ground)
/// Only call event_inherited() if you really have a parent that sets state.
// event_inherited();

sprite   = sprSand;
spriteBG = sprMtnDist;

/// --- TOP-ONLY ROW (extend by adding more matrices) ---
fenceMatrix = build_drawing_matrix_scale(x, y, 256, 0,0,0, 1,1,1);

var dx = [192, 236, 172, 128, 64, 0, -64, -128, -192]; // “about 10 forward/back” style
var count = array_length(dx);

var mats = array_create(1 + count);
mats[0] = fenceMatrix;
for (var i = 0; i < count; i++) {
    mats[1 + i] = build_drawing_matrix(x, y, dx[i], 90, 0, 0);
}

// Provide to extractor
transform_selections = mats;

// One frame per matrix (default 0), override particular indices as needed
transform_index = array_create(array_length(transform_selections), 0);
transform_index[0] = 6;   // fence frame
// transform_index[last] = 12; // example if you want a street tile on the last one

// Default: draw full quad from sprite unless overridden
position_update = array_create(array_length(transform_selections), -1);

// Example of a custom 8-point quad for one slot (optional):
// var k = array_length(position_update) - 1; // last
// position_update[k] = [0,0, 64,0, 64,8, 0,8];

var ex = instance_find(obj_cave_extractor_mv, 0);
if (ex != noone) ex.mesh_dirty = true;
