/// objUFOPhys.Create — hover UFO with layered draw + occupant inside

randomize();

// ---------- MOVEMENT / AI ----------
ufo_accel        = 0.20;          // how quickly we steer to goal vel (0..1)
ufo_drag         = 0.04;          // air drag each step
ufo_max_spd      = 7.0;           // speed cap
ufo_idle_drift   = 0.7;           // slow wander when no target
ufo_patrol_r     = 220;           // idle patrol radius

// altitude control
ufo_hover_h          = 160;       // desired height above ground/target
ufo_ceiling_margin   = 64;        // don't go above this from top
ufo_ground_clearance = 120;       // minimum above ground right under UFO
ufo_floor_probe_max  = room_height + 8; // how far we probe down

// soft combat
ufo_fire_interval = room_speed / 6;         // ~6 shots/sec
ufo_fire_cd       = irandom(ufo_fire_interval);
ufo_muzzle_ofs    = 36;                      // below dome center
ufo_fire_width    = 28;                      // need roughly aligned X to shoot

// motion scratch
hsp = 0;
vsp = 0;
fly_goal_x = x;
fly_goal_y = y;

// preferred target types (first existing, nearest used)
target = noone;
var _types = ["obj_Player1","objHumanPhys","obj_NeonBike_bike"];
for (var i = 0; i < array_length(_types); i++) {
    var t = asset_get_index(_types[i]);
    if (t != -1) {
        var who = instance_nearest(x, y, t);
        if (instance_exists(who)) { target = who; break; }
    }
}

// ground object (for altitude ray)
ground_obj = -1;
var _grounds = ["objSidewalk","obj_Floor_bike","objSolidGround","objFloor","obj_Floor"];
for (var g = 0; g < array_length(_grounds); g++) {
    var gi = asset_get_index(_grounds[g]);
    if (gi != -1) { ground_obj = gi; break; }
}

// ---------- VISUALS ----------
scale = 1;              // overall saucer scale
spin_angle = 0;         // for animating rings

// saucer sprite handles (use fallbacks if not present)
_sprUFO_top        = (asset_get_index("sprUFO_top")       >= 0) ? sprUFO_top       : -1;
_sprUFO_top_white  = (asset_get_index("sprUFO_top_white") >= 0) ? sprUFO_top_white : -1;
_sprUFO_bttm       = (asset_get_index("sprUFO_bttm")      >= 0) ? sprUFO_bttm      : -1;
_sprUFO_lights     = (asset_get_index("sprUFO_lights")    >= 0) ? sprUFO_lights    : -1;
_sprUFO_glass      = (asset_get_index("sprUFO_glass")     >= 0) ? sprUFO_glass     : -1;

// ring palette
ring_col_1 = make_color_hsv(irandom(255), 180, 230);
ring_col_2 = make_color_hsv(irandom(255), 180, 230);

// ---------- OCCUPANT (human/alien/zombie) ----------
occ_species = choose("human","alien","zombie");
occ_scale   = 0.55;               // occupant size inside dome
occ_dir     = 1;                  // 1 = facing right (art 0° → right)
occ_y_ofs   = 6;                 // nudge up/down inside glass
occ_x_ofs   = 0;                  // nudge left/right


// basic palette
switch (occ_species) {
	case "alien": occ_skin = make_color_hsv(irandom(255), 240, 255); break;
	case "zombie": occ_skin = make_color_hsv(irandom_range(60,120), 180, 200); break;
	default: occ_skin = make_color_hsv(irandom_range(15,35), irandom_range(20,80), irandom_range(180,255)); break;
	
}


occ_hair_1 = make_color_hsv(irandom(255), irandom_range(120,220), 230);
occ_hair_2 = make_color_hsv(irandom(255), irandom_range(120,220), 255);
occ_eye    = c_white;
occ_eye_p  = make_color_hsv(irandom(255), 200, 255);


// occupant sprite references (fallback to -1 if you’re missing any)
// --- Human set ---

var a;

a = asset_get_index("sprHuman_Head");
if (a != -1) spr_head_human = a; else spr_head_human = -1;

a = asset_get_index("sprHuman_Head_Eyes");
if (a != -1) spr_eyes_human = a; else spr_eyes_human = -1;

a = asset_get_index("sprHuman_Head_Eyes_Pupils");
if (a != -1) spr_pupil_human = a; else spr_pupil_human = -1;

a = asset_get_index("sprHuman_Head_Hair_Front");
if (a != -1) spr_hairF_human = a; else spr_hairF_human = -1;

a = asset_get_index("sprHuman_Head_Hair_Back");
if (a != -1) spr_hairB_human = a; else spr_hairB_human = -1;

// --- Alien set (fallbacks to human where missing) ---
a = asset_get_index("sprAlien_Head");
if (a != -1) spr_head_alien = a; else spr_head_alien = spr_head_human;

a = asset_get_index("sprAlien_Head_Eyes");
if (a != -1) spr_eyes_alien = a; else spr_eyes_alien = spr_eyes_human;

// --- Zombie set (fallbacks to human where missing) ---
a = asset_get_index("sprZombie_Head");
if (a != -1) spr_head_zombie = a; else spr_head_zombie = spr_head_human;

a = asset_get_index("sprZombie_Head_Eyes");
if (a != -1) spr_eyes_zombie = a; else spr_eyes_zombie = spr_eyes_human;

a = asset_get_index("sprZombie_Head_Eyes_Pupils");
if (a != -1) spr_pupil_zombie = a; else spr_pupil_zombie = spr_pupil_human;
eye_zombie_idx=irandom_range(0,3);

// choose which set we’ll actually use at draw time (we’ll branch in Draw)


// ---- Create: make a kinematic fixture (do NOT bind here) ----
fixture_idx = physics_fixture_create();
physics_fixture_set_circle_shape(fixture_idx, 22);
physics_fixture_set_density(fixture_idx, 0);
physics_fixture_set_friction(fixture_idx, 0);
physics_fixture_set_restitution(fixture_idx, 0);
physics_fixture_set_kinematic(fixture_idx);
