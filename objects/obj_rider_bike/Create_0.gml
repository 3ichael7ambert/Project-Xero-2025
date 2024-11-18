depth=-10;

Torque = 10000;

// Geometry
dx = 32;
dy = 32;

scale=1;

// Physics
var Fixture = physics_fixture_create(),
    Group = 0,
    Density = 1,
    Restitution = 0.2,
    Friction = 20,
    LinearDamp = 1,
    AngularDamp = 1;
    

physics_fixture_set_polygon_shape(Fixture);
physics_fixture_add_point(Fixture, -20,0);

physics_fixture_add_point(Fixture, 0,-40);

physics_fixture_add_point(Fixture, 20,0);

physics_fixture_add_point(Fixture, 0,40);

/*
physics_fixture_add_point(Fixture, 2,104);
physics_fixture_add_point(Fixture, 48,0);
physics_fixture_add_point(Fixture, 84,48);
physics_fixture_add_point(Fixture, 28,154);
*/


physics_fixture_set_collision_group(Fixture, Group);
physics_fixture_set_density(Fixture, Density);
physics_fixture_set_restitution(Fixture, Restitution);
physics_fixture_set_friction(Fixture, Friction);
physics_fixture_set_linear_damping(Fixture, LinearDamp);
physics_fixture_set_angular_damping(Fixture, AngularDamp);

physics_fixture_bind(Fixture, id);
physics_fixture_delete(Fixture);

phy_bullet = true;



xx = phy_position_x;
yy = phy_position_y;

facing_right=true;
armF_dir=0;
mouse_aim=false;