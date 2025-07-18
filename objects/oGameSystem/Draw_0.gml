//========================================= oGameSystem DRAW GUI
// oGameSystem - Draw GUI Event

// We only want to show the message if not all player slots are taken.
// The InputManager stores the max_players count. [cite: 609]
// The oGameSystem stores the active players in a global array. [cite: 470]
if (array_length(global.players_array) >= global.Input.max_players)
{
    exit;
}

// Let's set up some variables for drawing
var _display_w = display_get_gui_width();
var _y_pos = 32;
var _line_height = 32;

// Set drawing properties
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(-1); // Default font
draw_set_color(c_white);

// Draw the instructions, which are based on the bindings set up in the oGameSystem's Step event.
// Keyboard joining is done with the Enter key. [cite: 612, 614]
// Gamepad joining is done with the L+R shoulder buttons. [cite: 611, 612]
draw_text(_display_w / 2, _y_pos, "Press ENTER to join with Keyboard.");
_y_pos += _line_height;
draw_text(_display_w / 2, _y_pos, "Press L+R on a gamepad to join.");

// Reset draw alignment for other draw events that might run
draw_set_halign(fa_left);