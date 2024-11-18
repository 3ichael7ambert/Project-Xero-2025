//Draging check
if parent.dragging = 1 exit;
if mouse_check_button(mb_right) {
	parent.dragging = 1;
	parent.draggingId = id;
};
