/// objChunk_mv.Create
// Expect the world to set: chunk_x, tile_size, chunk_w, chunk_h, layer_name, block_ceil, block_floor


// Safe fallbacks (still no globals/macros)
if (!variable_instance_exists(self,"tile_size"))  tile_size  = 64;
if (!variable_instance_exists(self,"chunk_w"))    chunk_w    = 20;
if (!variable_instance_exists(self,"chunk_h"))    chunk_h    = 12;
if (!variable_instance_exists(self,"layer_name")) layer_name = "Instances";
if (!variable_instance_exists(self,"block_ceil")) block_ceil = objCeil_mv;
if (!variable_instance_exists(self,"block_floor"))block_floor= objGround_mv;


if (!variable_instance_exists(self,"variant_id")) variant_id = 0;

// Per-variant protrusion settings
// (probabilities per column; lengths in tiles)
if (variant_id == 0) {
    ceil_prob   = 0.06;  // 6% columns get a stalactite
    ceil_len_lo = 1;     // 1..2 tiles long
    ceil_len_hi = 2;

    floor_prob   = 0.08; // 8% columns get a stalagmite
    floor_len_lo = 1;    // 1..2
    floor_len_hi = 2;
}
else if (variant_id == 1) {
    ceil_prob   = 0.14;  ceil_len_lo = 1; ceil_len_hi = 3;
    floor_prob  = 0.18;  floor_len_lo = 1; floor_len_hi = 3;
}
else { // variant_id == 2 (heavy underground)
    ceil_prob   = 0.24;  ceil_len_lo = 2; ceil_len_hi = 4;
    floor_prob  = 0.28;  floor_len_lo = 2; floor_len_hi = 4;
}

// local RNG helper (no globals)
rand01 = function(seed_offset) {
    var v = (chunk_x*131 + seed_offset) * 12.9898 + 78.233;
    return frac(sin(v) * 43758.5453);
};


// Generation state
init_done = false;
blocks    = ds_list_create();  // track for cleanup

// If manager hasn’t set chunk_x yet, derive it from our x
if (!variable_instance_exists(self,"chunk_x")) {
    chunk_x = floor(x / (chunk_w * tile_size));
}

// Left pixel of this chunk
chunk_left_x = chunk_x * chunk_w * tile_size;

with (obj_cave_extractor_mv) {
	//_rebuild_mesh_mv();
	alarm[0]=10;
}