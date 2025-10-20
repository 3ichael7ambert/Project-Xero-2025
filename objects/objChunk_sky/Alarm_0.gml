/// objChunk_sky.Alarm[0]
if (is_undefined(tile_size)) tile_size = 64; // fallback, just in case
if (is_undefined(chunk_w))   chunk_w   = 16;
if (is_undefined(layer_name)) layer_name = "Instances";
if (is_undefined(roofline_y)) roofline_y = y;

build_now();
