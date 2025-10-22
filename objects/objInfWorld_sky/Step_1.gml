/*
with (objGround_mv) {
	if instance_exists(obj_Player1) {
		if (x < obj_Player1.x-2000) {
			instance_destroy();
		}
	}
}
	
	
with (objCeil_mv) {
	if instance_exists(obj_Player1) {
		if (x < obj_Player1.x-2000) {
			instance_destroy();
		}
	}
}
	
	*/
	
	if instance_exists(obj_Player1) {
	target=obj_Player1;
} else {
	target=self;
}