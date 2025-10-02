/// objUFOPhys.Draw — layered saucer + occupant in dome


// --------- ANIMATE RINGS (use hsp just for a subtle spin) ---------
spin_angle += hsp * 0.5; // harmless if hsp=0

var rot       = spin_angle;
var S         = scale * 2;          // saucer size
var top_x     = x;
var top_y     = y;
var bttm_x    = x;
var bttm_y    = y + 30 * S;         // bottom ring a bit lower
var lite_x    = x;
var lite_y    = y + 2 * S;
var glass_x   = x;
var glass_y   = y - 40 * S;

var SH = scale;

// frame helpers (wrap safely even if sprite missing)
function _safe_subimg(_spr, _idx) {
    if (_spr < 0) return -1;
    var n = sprite_get_number(_spr);
    if (n <= 0) return 0;
    var f = ((round(_idx) % n) + n) % n;
    return f;
}

var fr_topw = _safe_subimg(_sprUFO_top_white,  rot);
var fr_bttm = _safe_subimg(_sprUFO_bttm,      -rot);
var fr_lite = _safe_subimg(_sprUFO_lights,    -rot * 1.2);



// ---------- OCCUPANT (draw UNDER the glass) ----------
var oxy = glass_y + (occ_y_ofs * S * 0.5);
var oxx = glass_x + (occ_x_ofs * S * 0.5);
var oS  = S * occ_scale;



// pick sprite set by species
var sh, se, sp, shF, shB;
switch (occ_species) {
    case "alien":
        sh  = spr_head_alien;
        se  = spr_eyes_alien;
        sp  = -1;               // aliens: no separate pupils by default
        shF = -1; shB = -1;     // no hair
    break;

    case "zombie":
        sh  = spr_head_zombie;
        se  = spr_eyes_zombie;
        sp  = spr_pupil_zombie;
        shF = -1; shB = -1;     // most zombies no hair by default
    break;

    default: // human
        sh  = spr_head_human;
        se  = spr_eyes_human;
        sp  = spr_pupil_human;
        shF = spr_hairF_human;
        shB = spr_hairB_human;
    break;
}


// head
if (sh  != -1) draw_sprite_ext(sh,  0, oxx, oxy+(20 * SH), oS*occ_dir, oS, 0, occ_skin,  1);

// back hair
if (shB != -1) draw_sprite_ext(shB, 0, oxx+(20 * SH), oxy-(38 * SH), oS*occ_dir, oS, 0, occ_hair_1, 1);


// eyes (base white / alien eyes sheet)
if occ_species=="alien" {
var col_eye = occ_eye_p;
} else {
	var col_eye = occ_eye;
}
if (occ_species!="zombie"){
	draw_sprite_ext(se,  0, oxx+(30 * SH), oxy-(36 * SH), oS*occ_dir, oS, 0, col_eye,  1);
}
// pupils if available
if (sp  != -1) {
	if (occ_species=="zombie"){
		draw_sprite_ext(se,  0+eye_zombie_idx, oxx+(30 * SH), oxy-(36 * SH), oS*occ_dir, oS, 0, col_eye,  1);
	    draw_sprite_ext(sp, 2*eye_zombie_idx+1, oxx+(44 * SH), oxy-(30 * SH), oS*occ_dir, oS, 0, occ_eye_p,   1);
	    draw_sprite_ext(sp, 2*eye_zombie_idx, oxx+(44 * SH), oxy-(30 * SH), oS*occ_dir, oS, 0, c_black, 1);
	} else if (occ_species!="alien") {
	draw_sprite_ext(se,  0, oxx+(30 * SH), oxy-(36 * SH), oS*occ_dir, oS, 0, col_eye,  1);
		draw_sprite_ext(sp, 1, oxx+(44 * SH), oxy-(30 * SH), oS*occ_dir, oS, 0, occ_eye_p,   1);
		draw_sprite_ext(sp, 0, oxx+(44 * SH), oxy-(30 * SH), oS*occ_dir, oS, 0, c_black,   1);
	} else {
		
	}
}

// front hair
if (shF != -1) draw_sprite_ext(shF, 0, oxx+(20 * SH), oxy-(38* SH), oS*occ_dir, oS, 0, occ_hair_2, 1);





// ---------- SAUCER LAYERS: bottom → top → white pass → glass → lights ----------
if (_sprUFO_bttm      != -1) draw_sprite_ext(_sprUFO_bttm,      fr_bttm, bttm_x,  bttm_y,  S, S, rot, ring_col_1, 1);
if (_sprUFO_top       != -1) draw_sprite_ext(_sprUFO_top,            0, top_x,   top_y,   S, S, rot, ring_col_1, 1);
if (_sprUFO_top_white != -1) draw_sprite_ext(_sprUFO_top_white, fr_topw, top_x,   top_y,   S, S, rot, c_white,    1);



// ---------- GLASS & LIGHTS ON TOP ----------
if (_sprUFO_glass   != -1) draw_sprite_ext(_sprUFO_glass,   0,      glass_x, glass_y, S, S, rot, c_white, 1);
if (_sprUFO_lights  != -1) draw_sprite_ext(_sprUFO_lights,  fr_lite, lite_x,  lite_y,  S, S, rot, ring_col_2, 1);
