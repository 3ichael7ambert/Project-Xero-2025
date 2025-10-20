/// objInfWorld_mv.Step


if (!instance_exists(player)) exit;




var cx = world_to_chunk_x(player.x);
if (cx == _last_cx) exit;
_last_cx = cx;




// 1) Ensure needed chunks exist around the player
// Ensure needed chunks exist
for (var dx = -keep_range; dx <= keep_range; dx++) {
    var need  = cx + dx;
var key   = string(need);
if (!ds_map_exists(chunks, key)) {
    var left_x = chunk_x_to_world(need);
    var c = instance_create_layer(left_x, 0, layer_name, objChunk_mv);

    // existing config …
    c.chunk_x     = need;
    c.tile_size   = tile_size;
    c.chunk_w     = chunk_w;
    c.chunk_h     = chunk_h;
    c.layer_name  = layer_name;
    c.block_ceil  = objCeil_mv;
    c.block_floor = objGround_mv;

    // NEW: variant
    c.variant_id  = pick_variant_for_cx(need);

    ds_map_set(chunks, key, c);
}

}



// 2) Unload far chunks
// --- Unload far chunks (no ds_map_keys) ---
var to_delete = ds_list_create();

var k = ds_map_find_first(chunks);          // first key (string) or undefined
while (k != undefined) {
    var cx_key = real(k);
    if (abs(cx_key - cx) > keep_range) {
        ds_list_add(to_delete, k);          // collect key; don't delete during iteration
    }
    k = ds_map_find_next(chunks, k);        // advance
}

// now delete the collected ones
for (var i = 0; i < ds_list_size(to_delete); i++) {
    var del_key = to_delete[| i];
    var inst    = ds_map_find_value(chunks, del_key);
    if (instance_exists(inst)) with (inst) instance_destroy();
    ds_map_delete(chunks, del_key);
}
ds_list_destroy(to_delete);



