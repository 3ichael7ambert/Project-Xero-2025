/// @description  Initialize obj_NeonBike

/*
var half = sprite_width/2;

var tire=instance_create(x-half+10, y+33, obj_tire);
physics_joint_revolute_create(id,tire,tire.x,tire.y, 0, 0, 0, 0, 0, 0, false);

var tire=instance_create(x+half-10, y+33, obj_tire);
physics_joint_revolute_create(id,tire,tire.x,tire.y, 0, 0, 0, 0, 0, 0, false);

var rider=instance_create(x, y-65, obj_rider);
physics_joint_revolute_create(id,rider,rider.x,rider.y, 0, 0, 0, 0, 0, 0, false);

*/

Torque = 2000;

OnGround = true;

image_speed = 0;
image_index = 0;

AirTimerStart = room_speed / 2;
AirTimer = AirTimerStart;

ZoomState = "Null";
ZoomSpeed = 8;
ZoomMax = 2 * __view_get( e__VW.WView, view_current );
ZoomMin = __view_get( e__VW.WView, view_current );
ZoomProgress = ZoomMin;
ZoomRecovery = ZoomProgress;
ViewRatio = __view_get( e__VW.WView, view_current ) / __view_get( e__VW.HView, view_current );
y_ZoomOffsetMax = __view_get( e__VW.HView, view_current ) / 2.5;
y_ZoomOffsetMin = 0
y_ZoomOffset = y_ZoomOffsetMin;

// Surface
SurfaceID = surface_create(__view_get( e__VW.WView, view_current ) * 2, 4 * __view_get( e__VW.HView, view_current ));

TrailTexture = sprite_get_texture(spr_Trail_bike, 0);
TrailTextureHeight = sprite_get_height(spr_Trail_bike);

VoidTexture = sprite_get_texture(spr_Void_bike, 0);
VoidTextureHeight = sprite_get_height(spr_Void_bike);

// Physics
var Fixture = physics_fixture_create(),
    Group = 0,
    Density = 0.2,
    Restitution = 0.2,
    Friction = 1,
    LinearDamp = 0.1,
    AngularDamp = 0.2;
	
physics_fixture_set_polygon_shape(Fixture);

physics_fixture_add_point(Fixture, -80, 0);
physics_fixture_add_point(Fixture, -80, -48);
physics_fixture_add_point(Fixture, 80, -60);
physics_fixture_add_point(Fixture, 80, 0);

physics_fixture_set_collision_group(Fixture, Group);
physics_fixture_set_density(Fixture, Density);
physics_fixture_set_restitution(Fixture, Restitution);
physics_fixture_set_friction(Fixture, Friction);
physics_fixture_set_linear_damping(Fixture, LinearDamp);
physics_fixture_set_angular_damping(Fixture, AngularDamp);

physics_fixture_bind(Fixture, id);
physics_fixture_delete(Fixture);

phy_bullet = true;

// Rear tire
RearTireID = instance_create(x - 86, y-5, obj_NeonTire_bike);
RearTireID.BikeID = id;
with (RearTireID) {
	scale=.9;
		dx = 42*scale;
		dy = 42*scale;
}
physics_joint_revolute_create(id, RearTireID, x - 86, y-5, 0, 0, false, 0, 0, false, false);

x_Node = RearTireID.phy_position_x

// Front tire
FrontTireID = instance_create(x + 96, y+8, obj_NeonTire_bike);
FrontTireID.BikeID = id;
with (FrontTireID) {
	scale=.8;
	dx = 42*scale;
	dy = 42*scale;
}
physics_joint_revolute_create(id, FrontTireID, x + 96, y+8, 0, 0, false, 0, 0, false, false);


//Rider
RiderID = instance_create(x, y-80, obj_rider_bike);
RiderID.BikeID = id;
with (RiderID) {
	scale=.8;

}

physics_joint_revolute_create(id, RiderID, x , y-80, 0, 0, false, 0, 0, false, false);
