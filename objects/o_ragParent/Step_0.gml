//Draging ragdoll
if parent.dragging {
	if id = parent.draggingId {
		phy_position_x = mouse_x;
		phy_position_y = mouse_y;
	};
	phy_speed_x = 0;
	phy_speed_y = 0;	
	parent.g_gravity_acc = 0;
};
if mouse_check_button_released(mb_right) parent.dragging = 0;
image_xscale = parent.g_facing;