/// obj_music_controller - Step

// advance timing
_accum += delta_time / 1000000; // seconds from microseconds
while (_accum >= step_time) {
    _accum -= step_time;

    // --- DRUMS ---
    var pat = drum_patterns[drum_ix];
    var s   = step_index;

    if (pat.kick[s])  audio_play_sound(snd_kick,     1, false);
    if (pat.snare[s]) audio_play_sound(snd_snare,    1, false);
    if (pat.hat_c[s]) audio_play_sound(snd_hihat_c,  1, false);
    if (pat.hat_o[s]) audio_play_sound(snd_hihat_o,  1, false);

    // --- HARMONY CONTEXT (per bar) ---
    if (s == 0) {
        // on the downbeat, pick the next chord in the progression
        var prog = progressions[prog_choice];
        var degree = prog[prog_pos]; // 1..7
        current_chord_degrees = degree; // store
        current_chord_notes   = _chord_notes(degree); // semitone indices

        // rotate progression
        prog_pos = (prog_pos + 1) mod array_length(prog);

        // occasionally rotate drum pattern & rhythms
        if ((bar_index % bars_per_pattern) == 0 && bar_index > 0) {
            drum_ix = (drum_ix + 1) mod array_length(drum_patterns);
            piano1_rhythm = choose(rhythm_chugs_16, rhythm_offbeat_16, rhythm_sparse_16);
            piano2_rhythm = choose(rhythm_sparse_16, rhythm_offbeat_16);
            bass_rhythm   = choose(rhythm_chugs_16, rhythm_sparse_16);
            // Occasionally switch modes for variety
            if (irandom(5) == 0) bass_mode   = choose(0,1,2);
            if (irandom(5) == 0) piano1_mode = choose(0,1);
            if (irandom(5) == 0) piano2_mode = choose(0,1);
        }
    }

    // --- BASS (in key) ---
    if (bass_rhythm[s]) {
        switch (bass_mode) {
            case 0: { // chord tones: alternate root / fifth / (sometimes octave)
                var root_ix = current_chord_notes[0];
                var fifth_ix = current_chord_notes[2];
                var choice = choose(root_ix, fifth_ix, root_ix);
                play_note_from_bank(bass_sounds, choice, 1);
            } break;

            case 1: { // single pulses on scale degree 1 (root)
                var deg1 = _degree_to_note(1);
                play_note_from_bank(bass_sounds, deg1, 1);
            } break;

            case 2: { // simple melody within the scale
                var sc = _scale_array();
                var deg = choose(1,2,3,5,6); // avoid 4 & 7 for less tension
                var note_ix = (key_root + sc[deg-1]) mod 12;
                play_note_from_bank(bass_sounds, note_ix, 1);
            } break;
        }
    }

    // --- PIANO 1 (chords or melody) ---
    if (piano1_rhythm[s]) {
        if (piano1_mode == 0) {
            // play chord shape of current degree
            play_chord_from_bank(piano1_sounds, current_chord_notes, 1);
        } else {
            // melody tones tend to target chord tones
            var pick = choose(current_chord_notes[0], current_chord_notes[1], current_chord_notes[2]);
            play_note_from_bank(piano1_sounds, pick, 1);
        }
    }

    // --- PIANO 2 (layered) ---
    if (piano2_rhythm[s]) {
        if (piano2_mode == 0) {
            // layer a sus or alt inversion for color
            var degree = current_chord_degrees;
            var sus    = choose(chord_sus2, chord_sus4);
            var root   = _degree_to_note(degree);
            var notes  = [
                (root + sus[0]) mod 12,
                (root + sus[1]) mod 12,
                (root + sus[2]) mod 12
            ];
            play_chord_from_bank(piano2_sounds, notes, 1);
        } else {
            // counter-melody: pick non-root chord tone or passing scale tone
            var sc = _scale_array();
            var deg = choose(2,3,5,6);
            var note_ix = (key_root + sc[deg-1]) mod 12;
            play_note_from_bank(piano2_sounds, note_ix, 1);
        }
    }

    // advance grid
    step_index = (step_index + 1) mod steps_per_bar;
    if (step_index == 0) bar_index++;
}





//====--- HOT KEYS ---===//
// Quick tweaks (optional)
if (keyboard_check_pressed(ord("K"))) { key_root = (key_root + 1) mod 12; }
if (keyboard_check_pressed(ord("M"))) { scale_mode = 1 - scale_mode; }
if (keyboard_check_pressed(vk_up))    { bpm = clamp(bpm + 2, 60, 200); step_time = 60 / bpm / steps_per_beat; }
if (keyboard_check_pressed(vk_down))  { bpm = clamp(bpm - 2, 60, 200); step_time = 60 / bpm / steps_per_beat; }
if (keyboard_check_pressed(ord("B"))) { bass_mode = (bass_mode + 1) mod 3; }
if (keyboard_check_pressed(ord("P"))) { piano1_mode = 1 - piano1_mode; }
if (keyboard_check_pressed(ord("O"))) { piano2_mode = 1 - piano2_mode; }
if (keyboard_check_pressed(ord("D"))) { drum_ix = (drum_ix + 1) mod array_length(drum_patterns); }
