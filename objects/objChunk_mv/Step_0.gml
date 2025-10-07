/// objChunk_mv.Step
if (init_done) exit;

// Build ONLY the ceiling row (y=0) and the floor row (y=(chunk_h-1)*tile_size)
var s = tile_size;
var w = chunk_w;
var h = chunk_h;

for (var tx = 0; tx < w; tx++) {
    var wx = chunk_left_x + tx * s;

    // Ceiling block
    var c = instance_create_layer(wx, 0, layer_name, block_ceil);
    ds_list_add(blocks, c);

    // Floor block
    var fy = (h - 1) * s;
    var f = instance_create_layer(wx, fy, layer_name, block_floor);
    ds_list_add(blocks, f);
}


// --------- Variant protrusions (ceiling / floor stick-outs) ----------
var s = tile_size;
var w = chunk_w;
var h = chunk_h;

// We’ll scan each column once for ceiling and once for floor.
for (var tx = 0; tx < w; tx++) {
    var wx = chunk_left_x + tx*s;

    // --- Ceiling stalactites (start below solid ceiling at row 1) ---
    // deterministic per-chunk/per-column
    var rC = rand01(911 + tx*3);
    if (rC < ceil_prob) {
        var lenC = ceil_len_lo + irandom_range(0, ceil_len_hi - ceil_len_lo);
        var maxLenC = max(0, (h-2));  // avoid colliding with floor
        lenC = clamp(lenC, 0, maxLenC);

        for (var k = 1; k <= lenC; k++) {
            var cy = k * s; // rows 1..len
            var bc = instance_create_layer(wx, cy, layer_name, block_ceil);
            ds_list_add(blocks, bc);
        }
    }

    // --- Floor stalagmites (start above solid floor at row h-2) ---
    var rF = rand01(1337 + tx*5);
    if (rF < floor_prob) {
        var lenF = floor_len_lo + irandom_range(0, floor_len_hi - floor_len_lo);
        var maxLenF = max(0, (h-2));  // avoid colliding with ceiling
        lenF = clamp(lenF, 0, maxLenF);

        for (var k = 1; k <= lenF; k++) {
            var fy = (h - 1 - k) * s; // rows h-2 downwards
            var bf = instance_create_layer(wx, fy, layer_name, block_floor);
            ds_list_add(blocks, bf);
        }
    }
}



init_done = true;

