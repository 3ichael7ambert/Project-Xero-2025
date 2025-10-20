/// objInfWorld_sky.Step — load/unload skyline chunks around player
if (!instance_exists(player)) exit;

var cx = world_to_chunk_x(player.x);
if (cx == _last_cx) exit;
_last_cx = cx;

// ensure needed chunks
for (var dx = -keep_range; dx <= keep_range; dx++) {
    var need = cx + dx, key = string(need);
    if (!ds_map_exists(chunks, key)) {
        var left_x = chunk_x_to_world(need);
        var C = instance_create_layer(left_x, 0, layer_name, objChunk_sky);
        with (C) {
            chunk_x     = need;
            tile_size   = other.tile_size;
            chunk_w     = other.chunk_w;
            layer_name  = other.layer_name;
            roofline_y  = other.roofline_y;

            // skyline flavor
            build_style = other.pick_style(need);
            building_z  = other.pick_front_z_tiles(need); // in “tile units” (we’ll use as-is)
        }
        ds_map_set(chunks, key, C);
    }
}

// unload far chunks
var to_del = ds_list_create();
var k = ds_map_find_first(chunks);
while (k != undefined) {
    var v = ds_map_find_value(chunks, k);
    if (abs(real(k) - cx) > keep_range) {
        ds_list_add(to_del, k);
        if (instance_exists(v)) with (v) instance_destroy();
    }
    k = ds_map_find_next(chunks, k);
}
for (var i = 0; i < ds_list_size(to_del); i++) ds_map_delete(chunks, to_del[| i]);
ds_list_destroy(to_del);
