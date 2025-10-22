/// objInfWorld_sky.Create — skyline chunk manager
tile_size  = 64;
chunk_w    = 16;          // skyline span per chunk (columns)
chunk_h    = 1;           // not used (buildings are vertical)
keep_range = 3;           // chunks on each side
layer_name = "Instances"; // where buildings/chunks live


scene=objControl_sky.scene;

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

pick_front_z_tiles = function(cx) { return irandom_range(0, 1); }; // shallow parallax

if instance_exists(obj_Player1) {
	target=obj_Player1;
} else {
	target=self;
}
if (true) {
//create_parallax_layer(sprDesert_Bike_1,target.x,target.y,0,0,100,c_white,1);
var aa = instance_create(x,y,objParallaxLayer_sky);

aa.spr_or_bg = sprDesert_Bike_1;
aa.x_follow = 0.9;
aa.y_follow = 0.9;
aa.x_speed = -10;
aa.y_speed = 0;
aa.colour = c_white;
aa.alpha = 1;

}