/// Alarm[0]: trigger chirp (open beak)
beak_open = true;
// optional: audio_play_sound(sndBirdChirp, 1, false);
alarm[1] = irandom_range(room_speed*4/10, room_speed*7/10); // close shortly
// schedule next chirp sometime later
alarm[0] = irandom_range(room_speed*2, room_speed*5);
