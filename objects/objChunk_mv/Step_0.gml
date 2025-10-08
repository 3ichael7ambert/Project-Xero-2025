/// objChunk_mv.Step
if (init_done) exit;

// -------------------------------------------------------------------------
// Local references
var s = tile_size;
var w = chunk_w;
var h = chunk_h;

// Ensure the layer variables exist (defensive)
if (!variable_instance_exists(self, "layer_blocks")) layer_blocks = "Instances";
if (!variable_instance_exists(self, "layer_enemies")) layer_enemies = "Instances";

// -------------------------------------------------------------------------
// Build the solid ceiling and floor rows
for (var tx = 0; tx < w; tx++) {
    var wx = chunk_left_x + tx * s;

    // Ceiling block
    var c = instance_create_layer(wx, 0, layer_blocks, block_ceil);
    ds_list_add(blocks, c);

    // Floor block
    var fy = (h - 1) * s;
    var f = instance_create_layer(wx, fy, layer_blocks, block_floor);
    ds_list_add(blocks, f);
}

// -------------------------------------------------------------------------
// Variant-based protrusions (longer, mountain-like runs)
// -------------------------------------------------------------------------
var ts = tile_size;

// deterministic 0..1 generator
var rand01 = function(seed_offset) {
    var v = (chunk_x * 131 + seed_offset) * 12.9898 + 78.233;
    return frac(sin(v) * 43758.5453);
};

// smooth “hump” curve for runs
var taper = function(t) { return 0.5 - 0.5 * cos(pi * t); };

// per-variant parameters
var ceil_runs, ceil_run_min, ceil_run_max, ceil_height_lo, ceil_height_hi;
var floor_runs, floor_run_min, floor_run_max, floor_height_lo, floor_height_hi;

if (variant_id == 0) {
    ceil_runs = 1; ceil_run_min = 2; ceil_run_max = 3; ceil_height_lo = 1; ceil_height_hi = 2;
    floor_runs = 1; floor_run_min = 2; floor_run_max = 3; floor_height_lo = 1; floor_height_hi = 2;
} else if (variant_id == 1) {
    ceil_runs = 2; ceil_run_min = 3; ceil_run_max = 5; ceil_height_lo = 1; ceil_height_hi = 3;
    floor_runs = 2; floor_run_min = 3; floor_run_max = 6; floor_height_lo = 1; floor_height_hi = 3;
} else {
    ceil_runs = 3; ceil_run_min = 4; ceil_run_max = 8; ceil_height_lo = 2; ceil_height_hi = 4;
    floor_runs = 3; floor_run_min = 4; floor_run_max = 9; floor_height_lo = 2; floor_height_hi = 4;
}

// -------------------------------------------------------------------------
// Ceiling runs
for (var r = 0; r < ceil_runs; r++) {
    var baseSeed = 500 + r * 31;
    var start = 1 + floor(rand01(baseSeed + 7) * (w - 2));
    var span  = ceil_run_min + floor(rand01(baseSeed + 11) * (ceil_run_max - ceil_run_min + 1));
    var endx  = clamp(start + span - 1, 1, w - 2);
    var baseH = ceil_height_lo + floor(rand01(baseSeed + 19) * (ceil_height_hi - ceil_height_lo + 1));

    var L = max(1, endx - start + 1);
    for (var i = 0; i < L; i++) {
        var tx = start + i;
        var t  = (L <= 1) ? 0.5 : (i / (L - 1));
        var add = round(taper(t) * baseH);
        if (add <= 0) continue;

        var wx = chunk_left_x + tx * ts;
        var maxLen = max(0, h - 2);
        var len = clamp(add, 0, maxLen);

        for (var k = 1; k <= len; k++) {
            var cy = k * ts;
            var bc = instance_create_layer(wx, cy, layer_blocks, block_ceil);
            ds_list_add(blocks, bc);
        }
    }
}

// -------------------------------------------------------------------------
// Floor runs
for (var r = 0; r < floor_runs; r++) {
    var baseSeed = 900 + r * 37;
    var start = 1 + floor(rand01(baseSeed + 7) * (w - 2));
    var span  = floor_run_min + floor(rand01(baseSeed + 11) * (floor_run_max - floor_run_min + 1));
    var endx  = clamp(start + span - 1, 1, w - 2);
    var baseH = floor_height_lo + floor(rand01(baseSeed + 19) * (floor_height_hi - floor_height_lo + 1));

    var L = max(1, endx - start + 1);
    for (var i = 0; i < L; i++) {
        var tx = start + i;
        var t  = (L <= 1) ? 0.5 : (i / (L - 1));
        var add = round(taper(t) * baseH);
        if (add <= 0) continue;

        var wx = chunk_left_x + tx * ts;
        var maxLen = max(0, h - 2);
        var len = clamp(add, 0, maxLen);

        for (var k = 1; k <= len; k++) {
            var fy = (h - 1 - k) * ts;
            var bf = instance_create_layer(wx, fy, layer_blocks, block_floor);
            ds_list_add(blocks, bf);
        }
    }
}

// -------------------------------------------------------------------------
init_done = true;
