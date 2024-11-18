/// @description draw world

var _xx = phy_position_x;
var _yy = phy_position_y;

/// draw gravity field
draw_set_alpha(0.6);
draw_circle_color(_xx,_yy, gravity_radius, c_white, c_blue, false);
draw_set_alpha(1);

/// create physics fixture
draw_set_colour(c_white);
draw_primitive_begin_texture(pr_trianglelist, tex);

/*
	draw planetoid
*/
var len =  array_length(points);
for (var i = 0; i < len; ++i) {
    // code here
	var x1, y1, x2, y2;
	var dx1, dy1, dx2, dy2;
	
	dx1 = lengthdir_x(1, i * angle_dr);
	dy1 = lengthdir_y(1, i * angle_dr);
	dx2 = lengthdir_x(1, i * angle_dr + angle_dr);
	dy2 = lengthdir_y(1, i * angle_dr + angle_dr);
	
	x1 = _xx + dx1 * points[i].r;
	y1 = _yy + dy1 * points[i].r;
	x2 = _xx + dx2 * points[(i+1)%len].r;
	y2 = _yy + dy2 * points[(i+1)%len].r;
	
	
	draw_vertex_texture(_xx, _yy, 0.5, 0.5);
	draw_vertex_texture(x2, y2, dx2 * 0.49 + 0.5, dy2 * 0.49 + 0.5);
	draw_vertex_texture(x1, y1, dx1 * 0.49 + 0.5, dy1 * 0.49 + 0.5);
	draw_line(_xx,_yy,x2,y2);
	
}
draw_primitive_end();
