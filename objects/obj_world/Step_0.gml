/// @description apply gravity

var _list = ds_list_create();
var _count = collision_circle_list(phy_position_x, phy_position_y, gravity_radius, obj_physics_parent, 0, 1, _list, 0);
var _gravity = 45;

/// apply gravity
for (var i = 0; i < _count; ++i) {
    // get every object in the gravity well and apply force proportional to their masses
	var _obj = _list[| i];
	with(_obj){
		var _force = phy_mass * _gravity;
		var _direction = point_direction(phy_position_x, phy_position_y, other.phy_position_x, other.phy_position_y);
		var _fx = lengthdir_x(_force, _direction);
		var _fy = lengthdir_y(_force, _direction);
		physics_apply_force(phy_position_x, phy_position_y, _fx, _fy);
		/// add each gravity vector
		var move_vec = new Vector2(-_fx, -_fy);
		gravity_normal.add(move_vec);
	}
}
