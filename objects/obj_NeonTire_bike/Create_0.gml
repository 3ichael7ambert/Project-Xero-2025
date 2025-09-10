/// @description  Initialize obj_NeonTire

Torque = 1000;

// Geometry
dx = 32;
dy = 32;

// Physics
var Fixture = physics_fixture_create(),
    Group = 0,
    Density = 0.2,
    Restitution = 0.2,
    Friction = 20,
    LinearDamp = 0,
    AngularDamp = 0.2;
    
physics_fixture_set_circle_shape(Fixture, dx);

physics_fixture_set_collision_group(Fixture, Group);
physics_fixture_set_density(Fixture, Density);
physics_fixture_set_restitution(Fixture, Restitution);
physics_fixture_set_friction(Fixture, Friction);
physics_fixture_set_linear_damping(Fixture, LinearDamp);
physics_fixture_set_angular_damping(Fixture, AngularDamp);

physics_fixture_bind(Fixture, id);
physics_fixture_delete(Fixture);

phy_bullet = true;

scale=.8;