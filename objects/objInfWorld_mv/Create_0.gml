/// objInfWorld_mv.Create
// Local config (only lives on this instance)
tile_size   = 64;         // size of your blocks
chunk_w     = 20;         // tiles per chunk (width)
chunk_h     = 12;         // tiles per chunk (height)
keep_range  = 3;          // how many chunks to keep on each side
layer_name  = "Instances"; // layer to place blocks on

// Your player object (change if needed)
player = instance_find(objPlayer_mv, 0);

// Runtime state
chunks   = ds_map_create();   // key: string(chunk_x) -> value: chunk instance id
_last_cx = undefined;

// Tiny helpers scoped to this object
world_to_chunk_x = function(px) {
    return floor(px / (chunk_w * tile_size));
};
chunk_x_to_world = function(cx) {
    return cx * chunk_w * tile_size;
};

// Pick a chunk "variant" deterministically from chunk_x
hashf = function(n) {
    // stable 0..1
    return frac(sin(n*12.9898 + 78.233) * 43758.5453);
};
  function pick_variant_for_cx(cx) {
    var t = hashf(cx);         // 0..1
    if (t < 0.35) return 0;    // normal
    if (t < 0.70) return 1;    // underground (light)
    return 2;                  // underground (heavy)
};