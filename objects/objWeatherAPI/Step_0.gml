/// Step (UI controls)
if (keyboard_check_pressed(vk_f9)) show_panel = !show_panel;

var mw = mouse_wheel_up() - mouse_wheel_down(); // +1/-1
if (mw != 0) {
    scroll_y = max(0, scroll_y + mw * 24);
}
