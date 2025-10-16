/// @desc Create (Ceiling)
// event_inherited();
TILE = 64;

sprite   = sprSand;
spriteBG = sprMtnDist;

// Ceiling: same “top-only” approach, but you can flip/offset as needed.
// Keeping your 90° layflat; if you need underside, you can invert normals in Tile3d or use a -90 roll.
fenceMatrix = build_drawing_matrix_scale(x, y, 256, 0,0,0, 1,1,1);

var dx = [192, 236, 172, 128, 64, 0, -64, -128, -192];
var count = array_length(dx);

var mats = array_create(1 + count);
mats[0] = fenceMatrix;
for (var i = 0; i < count; i++) {
    mats[1 + i] = build_drawing_matrix(x, y+TILE, dx[i], 90, 0, 0);
}

transform_selections = mats;
transform_index      = array_create(array_length(transform_selections), 0);
transform_index[0]   = 6;

position_update      = array_create(array_length(transform_selections), -1);

var ex = instance_find(obj_cave_extractor_mv, 0);
if (ex != noone) ex.mesh_dirty = true;
