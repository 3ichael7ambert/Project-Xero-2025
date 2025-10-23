/// objControl_sky.Create — skyline platformer bootstrap

randomize();
depth = -10000;

scene="train";

scene_skin=choose(
				"desert",
				"forest",
				"skyline",
				"mountain",
				"dillingham_inside",
				"dillingham_outside",
				"raiders_capital",
				"raiders_rhs",
				"raiders_den",
				"raiders_lew",
				"raiders_rmcad",
				"raiders_towncenter"
				);

// "train", "bus", "rooftops"

game_start = false;
grav_dir   = "down";
global.gameReady = false;

// systems
instance_create_layer(x, y, "Instances", oGameSystem);

// players
if (!variable_global_exists("players")) global.players = 1;

// director tuning (enemies)
kill_counter        = 0;
enemy_count_robot   = 0;
spawn_interval_base = 75;
kills_per_tier      = 10;
max_alive_base      = 3;
max_alive_cap       = 30;
spawn_batch_cap     = 4;
enemy_spawn_radius  = 640;
elite_every_n_tiers = 3;

// world: spawn skyline manager (chunks of downward buildings)
if (!instance_exists(objInfWorld_sky)) {
    instance_create_layer(0, 0, "Instances", objInfWorld_sky);
}

// visual toggles
rain=false; snow=false; fireworks=false;
night=false; fog=true;  apocalypse=false;
cloudy=false; wind=true;

fpsreal = fps_real;
alarm[2] = 30;


scr_timeofday_background_init();

/*
create_parallax_layer(backStarsLayer1, 0.2, 0.2, 0.2, 0, -1000, c_white, 1);
create_parallax_layer(backStarsLayer2, 0.4, 0.4, 0.1, 0, -1010, c_white, 1);
create_parallax_layer(backStarsLayer3, 0.6, 0.6, 0.05, 0, -1020, c_white, 1);
*/