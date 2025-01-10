drums=music_drums_lofi_1;


// Variables for BPM and loop setup
_bpm = 130;
_beats_per_bar = 4;

// Convert BPM to seconds per beat
_bpm_to_sec = time_bpm_to_seconds(_bpm);

// Calculate total time for one bar
_bar_duration = _bpm_to_sec * _beats_per_bar;

// Set up audio loop points
audio_sound_loop_start(drums, 0);                     // Start from the beginning
audio_sound_loop_end(drums, _bar_duration);          // End after one bar

// Play the sound with looping enabled
//_sound_drums_instance = audio_play_sound(drums, 100, true);
