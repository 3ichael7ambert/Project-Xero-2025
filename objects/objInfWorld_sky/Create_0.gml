/// objInfWorld_sky.Create — skyline chunk manager
tile_size  = 64;
chunk_w    = 16;          // skyline span per chunk (columns)
chunk_h    = 1;           // not used (buildings are vertical)
keep_range = 3;           // chunks on each side
layer_name = "Instances"; // where buildings/chunks live

// where rooftops sit in world Y (the “platform line”)
roofline_y = 2048;        // tune for your camera

// which object represents “player”
player = obj_Player1;

// runtime
chunks   = ds_map_create();
_last_cx = undefined;

// helpers
world_to_chunk_x = function(px) { return floor(px / (chunk_w * tile_size)); };
chunk_x_to_world = function(cx) { return cx * chunk_w * tile_size; };

// deterministic variety
hashf = function(n) { return frac(sin(n*12.9898 + 78.233) * 43758.5453); };
pick_style = function(cx) {
    var t = hashf(cx);
    if (t < 0.33) {
        return 1;
    } else if (t < 0.66) {
        return 2;
    } else {
        return 3;
    }
};

pick_front_z_tiles = function(cx) { return irandom_range(6, 14); }; // shallow parallax
