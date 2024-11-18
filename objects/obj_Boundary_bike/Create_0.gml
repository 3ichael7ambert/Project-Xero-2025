/// @description  Initialize obj_Boundary

// Boundary follows last deleted floor instance to ensure player doesn't back track

// Generate floor
var Fixture = physics_fixture_create(),
    Group = 0,
    Density = 0,
    Restitution = 0.3,
    Friction = 5,
    LinearDamp = 0,
    AngularDamp = 0;

physics_fixture_set_edge_shape(Fixture, x, y, x, y - __view_get( e__VW.HView, view_current ) * 4);

physics_fixture_set_collision_group(Fixture, Group);
physics_fixture_set_density(Fixture, Density);
physics_fixture_set_restitution(Fixture, Restitution);
physics_fixture_set_friction(Fixture, Friction);
physics_fixture_set_linear_damping(Fixture, LinearDamp);
physics_fixture_set_angular_damping(Fixture, AngularDamp);
physics_fixture_set_kinematic(Fixture);     // Boundary doesn't move so set to kinematic

physics_fixture_bind(Fixture, id);
physics_fixture_delete(Fixture);

