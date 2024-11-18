if global.debugMode physics_draw_debug() else {
	surface_set_target(global.surf_outline);
	draw_self();
	surface_reset_target();
};