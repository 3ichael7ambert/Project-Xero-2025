/// objControl_sky.Create — skyline platformer bootstrap

randomize();
depth = -10000;

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
