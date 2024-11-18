/// @description setup

var _rad = sprite_width * 0.5;				/// base radius of shape
segments = 32;								/// break shape into convex polygons
variation = 5;								/// add variation to surface of shape
angle_dr = 360 / segments;					/// angle per slice of convex poly
tex = sprite_get_texture(sprite_index, 0);	/// texture from sprite
points = [];								/// all points on edge of shape

/// create positions on circle
for (var i = 0; i < segments; ++i) {
	var dist = _rad + irandom_range(-variation,variation);
	var x1 = lengthdir_x(dist, i * angle_dr);
	var y1 = lengthdir_y(dist, i * angle_dr);
	array_push(points, {x: x1, y: y1, r: dist});
}

/// create physics fixtures
var len =  array_length(points);
for (var i = 0; i < len; ++i) {
    // code here
	var fix, x1, y1, x2, y2;
	fix = physics_fixture_create();
	physics_fixture_set_density(fix, 0);
	physics_fixture_set_kinematic(fix);
	physics_fixture_set_friction(fix, 5);
	physics_fixture_set_restitution(fix, 0.0);
	
	x1 = points[i].x;
	y1 = points[i].y;
	x2 = points[(i+1)%len].x;
	y2 = points[(i+1)%len].y;
	
	
	physics_fixture_set_polygon_shape(fix);
	physics_fixture_add_point(fix, 0, 0);
	physics_fixture_add_point(fix, x2, y2);
	physics_fixture_add_point(fix, x1, y1);
	
	physics_fixture_bind(fix, id);
	physics_fixture_delete(fix);
}

gravity_radius = sprite_width * 0.5 + 128;