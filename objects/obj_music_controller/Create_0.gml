/// obj_music_controller - Create

// ====== TEMPO / GRID ======
bpm               = 100;         // change live if you want
steps_per_beat    = 4;           // 16th notes
beats_per_bar     = 4;           // 4/4
steps_per_bar     = steps_per_beat * beats_per_bar; // 16
step_time         = 60 / bpm / steps_per_beat;      // seconds per step
_accum            = 0;
step_index        = 0;           // 0..15
bar_index         = 0;

// ====== KEY / SCALE ======
key_root          = 0;  // 0=C, 1=C#, ... 11=B
scale_mode        = 0;  // 0=major, 1=natural minor

// Major / Natural Minor semitone sets (degree → semitone offset)
scale_major       = [0,2,4,5,7,9,11];
scale_minor_nat   = [0,2,3,5,7,8,10];

// ====== CHORD SHAPES (semitones) ======
chord_major       = [0,4,7];
chord_minor       = [0,3,7];
chord_sus2        = [0,2,7];
chord_sus4        = [0,5,7];

// Common pop progressions (scale degrees, 1-based): I–V–vi–IV, etc.
progressions      = [
    [1,5,6,4],
    [1,6,4,5],
    [6,4,1,5],
    [2,5,1,6]
];
prog_choice       = choose(0,1,2,3); // index into progressions
prog_pos          = 0;               // current chord of progression

// ====== INSTRUMENT MODES ======
// Bass: 0=chord tones (root/5th), 1=single pulses on root, 2=melody in scale
bass_mode         = choose(0,1,2);

// Piano 1: 0=chords in rhythm, 1=melody
piano1_mode       = choose(0,1);

// Piano 2 layered over Piano 1 (same sounds now, easy to replace later)
piano2_mode       = 0; // keep as chords to layer glue; set 1 for counter-melody

// ====== SOUND MAPS (12-index arrays: 0=C, 1=C#, ... 11=B) ======
piano1_sounds = [
    snd_piano_C4, snd_piano_Cs4, snd_piano_D4, snd_piano_Ds4,
    snd_piano_E4, snd_piano_F4,  snd_piano_Fs4, snd_piano_G4,
    snd_piano_Gs4,snd_piano_A4,  snd_piano_As4, snd_piano_B4
];

// For now piano2 uses the same sounds — but this variable lets you swap later
piano2_sounds = [
    snd_piano_C4, snd_piano_Cs4, snd_piano_D4, snd_piano_Ds4,
    snd_piano_E4, snd_piano_F4,  snd_piano_Fs4, snd_piano_G4,
    snd_piano_Gs4,snd_piano_A4,  snd_piano_As4, snd_piano_B4
];

bass_sounds = [
    snd_bass_C2, snd_bass_Cs2, snd_bass_D2, snd_bass_Ds2,
    snd_bass_E2, snd_bass_F2,  snd_bass_Fs2, snd_bass_G2,
    snd_bass_Gs2,snd_bass_A2,  snd_bass_As2, snd_bass_B2
];

// ====== DRUM PATTERNS (16-step; 0/1 or velocity-like 0..1) ======
// Use a few variations and rotate them every few bars.
drum_patterns = [
    // Basic rock/pop
    {
        kick:  [1,0,0,0,  0,0,1,0,  1,0,0,0,  0,0,1,0],
        snare: [0,0,0,0,  1,0,0,0,  0,0,0,0,  1,0,0,0],
        hat_c: [1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1],
        hat_o: [0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0]
    },
    // Four-on-the-floor + offbeat hats
    {
        kick:  [1,0,0,0,  1,0,0,0,  1,0,0,0,  1,0,0,0],
        snare: [0,0,0,0,  1,0,0,0,  0,0,0,0,  1,0,0,0],
        hat_c: [0,1,0,1,  0,1,0,1,  0,1,0,1,  0,1,0,1],
        hat_o: [0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0]
    },
    // Funky syncopation
    {
        kick:  [1,0,0,0,  0,1,0,0,  1,0,0,1,  0,0,1,0],
        snare: [0,0,0,0,  1,0,1,0,  0,0,0,0,  1,0,1,0],
        hat_c: [1,1,0,1,  1,0,1,1,  1,1,0,1,  1,0,1,1],
        hat_o: [0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0]
    }
];

drum_ix = 0; // which pattern is active

// ====== RHYTHM GRIDS (which steps pianos/bass may play on) ======
rhythm_chugs_16   = [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0]; // eighths
rhythm_offbeat_16 = [0,1,0,1, 0,1,0,1, 0,1,0,1, 0,1,0,1];
rhythm_sparse_16  = [1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0];

piano1_rhythm     = choose(rhythm_chugs_16, rhythm_offbeat_16, rhythm_sparse_16);
piano2_rhythm     = choose(rhythm_sparse_16, rhythm_offbeat_16);
bass_rhythm       = choose(rhythm_chugs_16, rhythm_sparse_16);

// ====== UTIL ======
function _scale_array() {
    return (scale_mode == 0) ? scale_major : scale_minor_nat;
}

// degree: 1..7 → semitone index (0..11) in chosen key/scale
function _degree_to_note(degree) {
    var sc = _scale_array();
    degree = clamp(degree, 1, 7);
    var semitone = (key_root + sc[degree-1]) mod 12;
    return semitone;
}

// Build a chord at (scale degree) choosing major/minor type by scale
function _chord_notes(degree) {
    var sc = _scale_array();
    var deg_ix = degree - 1;
    var semiroot = (key_root + sc[deg_ix]) mod 12;

    // In major: I, IV, V → major; ii, iii, vi → minor (basic diatonic)
    // In natural minor: i, iv, v → minor; III, VI, VII → major
    var use_major = false;
    if (scale_mode == 0) { // major
        use_major = (degree == 1) || (degree == 4) || (degree == 5);
    } else { // minor (natural)
        use_major = (degree == 3) || (degree == 6) || (degree == 7);
    }
    var shape = use_major ? chord_major : chord_minor;

    var notes = array_create(3);
    for (var i = 0; i < 3; i++) {
        notes[i] = (semiroot + shape[i]) mod 12;
    }
    return notes;
}

// ====== PLAY HELPERS ======
function play_note_from_bank(_bank, _note_ix, _gain) {
    var snd = _bank[_note_ix];
    if (snd != noone) {
        var inst = audio_play_sound(snd, 1, false);
        // Gain per instance: use audio_sound_gain(snd, gain, time) = global,
        // so we'll simulate light dynamics with multiple samples or leave as is.
        // If you want per-instance volume, consider duplicating sounds or using a mixer bus.
    }
}

function play_chord_from_bank(_bank, _note_ix_list, _gain) {
    for (var i = 0; i < array_length(_note_ix_list); i++) {
        play_note_from_bank(_bank, _note_ix_list[i], _gain);
    }
}

// ====== STARTING KEY / MODE RANDOMIZATION ======
key_root    = irandom(11);   // random key each run
scale_mode  = choose(0,1);   // major / minor

// Optional: swap patterns every N bars
bars_per_pattern = 4;
