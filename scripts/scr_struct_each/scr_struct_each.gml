/// 
function scr_struct_each(struct, x, y, line_h) {
	var s = argument0, bx = argument1, yy = argument2, lh = argument3;
	if (!function_exists(variable_struct_get_names)) return yy;
	var names = variable_struct_get_names(s);
	for (var i = 0; i < array_length(names); i++) {
	    var k = names[i];
	    var v = variable_struct_get(s, k);
	    draw_set_color(c_aqua);  draw_text(bx, yy, string(k) + ":");
	    draw_set_color(c_white); draw_text(bx + 180, yy, is_string(v) ? v : json_stringify(v));
	    yy += lh;
	}
	return yy;
}
