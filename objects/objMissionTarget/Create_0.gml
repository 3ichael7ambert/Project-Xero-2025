species="balloon";

if (species=="bird") {
	spd       = irandom_range(1,3);  // random flight speed
	dir       = irandom(359);        // random direction
	turn_rate = 3;                   // how fast bird turns
	wander_jit= 0.8;                 // wander randomness
}

if (species=="balloon") {
	/// Simple balloon
	spr_balloon = sprBalloon;

	scale      = random_range(.42, .48);   // size
	rise_speed = random_range(0.6, 1.0);
	sway_amp   = irandom_range(5, 10);
	sway_freq  = random_range(0.6, 1.1);
	bob_amp    = irandom_range(1, 3);
	bob_freq   = random_range(0.8, 1.3);
	t          = irandom(1000);

	x_anchor   = x;
	y_anchor   = y;
	tint_col   = make_color_hsv(irandom(359), 220, 255);
	alpha_col  = 1;
}