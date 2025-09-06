// Toggle panel with F9
if (keyboard_check_pressed(vk_f9)) show_panel = !show_panel;

// Scroll list
var mw = mouse_wheel_up() - mouse_wheel_down(); // +1 if up, -1 if down
if (mw != 0) {
    scroll_y = clamp(scroll_y + mw * 24, 0, 9999);
}
