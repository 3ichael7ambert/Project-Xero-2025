/// @description  Initialize obj_Player

Torque = 3000;                      // Torque to apply to player

OnGround = true;
JumpForce = -1200;                  // Change to set jump height
JumpTimerStart = 5;                 // Used as a grace period when player isn't contacting floor but is close enough
JumpTimer = JumpTimerStart;

AirTimerStart = room_speed / 2;     // Change this to increase or decrease time before camera zooms out
AirTimer = AirTimerStart;

ZoomState = "Null";
ZoomSpeed = 8;                                                          // Change this to increase or decrease zoom speed
ZoomMax = 2 * __view_get( e__VW.WView, view_current );                                 // Max zoom
ZoomMin = __view_get( e__VW.WView, view_current );                                     // Min zoom
ZoomProgress = ZoomMin;
ZoomRecovery = ZoomProgress;
ViewRatio = __view_get( e__VW.WView, view_current ) / __view_get( e__VW.HView, view_current );        // Ration of view to ensure width and height scale properly
y_ZoomOffsetMax = __view_get( e__VW.HView, view_current ) / 2.5;                       // Change this value to alter how the camera tracks player while zooming out
y_ZoomOffsetMin = 0
y_ZoomOffset = y_ZoomOffsetMin;

// Geometry
dx = sprite_get_width(spr_Player_bike) / 2;
dy = sprite_get_height(spr_Player_bike) / 2;

// Physics
var Fixture = physics_fixture_create(),
    Group = 0,
    Density = 0.4,
    Restitution = 0.2,
    Friction = 20,
    LinearDamp = 0.1,
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

