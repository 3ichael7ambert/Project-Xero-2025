species="bird";

if (species=="bird") {
	spd       = irandom_range(1,3);  // random flight speed
	dir       = irandom(359);        // random direction
	turn_rate = 3;                   // how fast bird turns
	wander_jit= 0.8;                 // wander randomness
}
