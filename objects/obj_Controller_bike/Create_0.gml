with (other) {
/// Initialize obj_Controller

randomize();

LineWidth = 2;  // How thick to render line for view on surface
Fill = true;

// Debug
Flags = phy_debug_render_shapes | phy_debug_render_joints | phy_debug_render_coms | phy_debug_render_obb;
DebugState = false;

// Physics
physics_world_create(1/14);                                     // Change the denominator to increase player speed
physics_world_gravity(0, 50);                                   // The larger the number, the faster the player falls
physics_world_update_iterations(10);                            // May need to increase number if running a faster player
physics_world_update_speed(room_speed);                         // May need to increase number if running a faster player

// Floor properties
FloorBuffer = __view_get( e__VW.WView, view_current );                         // How much further ahead to create next floor chunk
FloorHeight = y;                                                // Starting height
FloorStart = 0;                                                 // Where to start floor after initial chunk
FloorStep = sprite_get_width(spr_Floor_bike);                        // The length in between each point during floor generation. Defaulst to floor texture width
FloorLength = (__view_get( e__VW.WView, view_current ) / 2) div FloorStep;     // Initialize first floor chunk to approximately half the view
FloorLast = x;                                                  // For obj_Player view & obj_Boundary phy_y position

SkyTexture = sprite_get_texture(spr_Sky_bike, 0);                    // Define textures for drawing sky (for Neon Rider demo), floor, and subfloor respectively
SkyTextureHeight = sprite_get_height(spr_Sky_bike);

//FloorTexture = sprite_get_texture(spr_Floor, 0);                // For ball demo
FloorTexture = sprite_get_texture(spr_Floor_bike, 2);                // For Neon Rider demo
FloorTextureHeight = sprite_get_height(spr_Floor_bike);

VoidTexture = sprite_get_texture(spr_Void_bike, 0);                  // For ball demo
//VoidTexture = sprite_get_texture(spr_Void, 1);                  // For Neon Rider demo
VoidTextureHeight = sprite_get_height(spr_Void_bike);

// Generate floor
FloorID = instance_create(x, FloorHeight, obj_Floor_bike);                           // Generate first chunk of flat floor that's about half the view width depending on step size
FloorID.FloorHeight = FloorHeight;
FloorID.ControllerID = id;
FloorID.SurfaceID = surface_create(FloorLength * FloorStep, 4 * room_height);   // Create surface to draw floor on
FloorID.FloorOffset = surface_get_height(FloorID.SurfaceID) / 4;

var Fixture = physics_fixture_create(),
    Group = 0,
    Density = 0,
    Restitution = 0.2,
    Friction = 5,
    LinearDamp = 0,
    AngularDamp = 0;

physics_fixture_set_chain_shape(Fixture, false);

surface_set_target(FloorID.SurfaceID);

draw_set_alpha(1);
draw_set_colour(c_black);

var x_Previous = -FloorStep,
    y_Previous = FloorID.y + FloorID.FloorOffset,
    y_Start = y_Previous;
    
for (var i = 0; i < FloorLength; i++)
{
    physics_fixture_add_point(Fixture, i * FloorStep, FloorHeight);                                 // Add point to physics fixture
    
    draw_line_width(x_Previous, y_Previous, x_Previous + FloorStep, y_Previous, LineWidth);         // draw line if you want a line rider game
    
    if (Fill)
    {
        draw_set_colour(c_white);
        
        /*draw_primitive_begin_texture(pr_trianglestrip, SkyTexture);                                 // Sky texture used for Neon Rider demo
        draw_vertex_texture(x_Previous, y_Previous, 0, 0);
        draw_vertex_texture(x_Previous + FloorStep, y_Previous, 1, 0);
        draw_vertex_texture(x_Previous, y_Previous - SkyTextureHeight, 0, 1);
        draw_vertex_texture(x_Previous + FloorStep, y_Previous - SkyTextureHeight, 1, 1);
        draw_primitive_end();*/
                
        draw_primitive_begin_texture(pr_trianglestrip, VoidTexture);                                //Texture to draw under floor texture
        draw_vertex_texture(x_Previous, surface_get_height(FloorID.SurfaceID), 0, 1);
        draw_vertex_texture(x_Previous + FloorStep, surface_get_height(FloorID.SurfaceID), 1, 1);
        draw_vertex_texture(x_Previous, y_Previous, 0, 0);
        draw_vertex_texture(x_Previous + FloorStep, y_Previous, 1, 0);
        draw_primitive_end();
        
        draw_primitive_begin_texture(pr_trianglestrip, FloorTexture);                               //Texture to draw for floor
        draw_vertex_texture(x_Previous, y_Previous + FloorTextureHeight, 0, 1);
        draw_vertex_texture(x_Previous + FloorStep, y_Previous + FloorTextureHeight, 1, 1);
        draw_vertex_texture(x_Previous, y_Previous, 0, 0);
        draw_vertex_texture(x_Previous + FloorStep, y_Previous, 1, 0);
        draw_primitive_end();
    }
    
    x_Previous += FloorStep;
}

surface_reset_target();

physics_fixture_set_collision_group(Fixture, Group);
physics_fixture_set_density(Fixture, Density);
physics_fixture_set_restitution(Fixture, Restitution);
physics_fixture_set_friction(Fixture, Friction);
physics_fixture_set_linear_damping(Fixture, LinearDamp);
physics_fixture_set_angular_damping(Fixture, AngularDamp);
physics_fixture_set_kinematic(Fixture);                         // Floor doesn't move so set to kinematic

physics_fixture_bind(Fixture, FloorID);
physics_fixture_delete(Fixture);

FloorID.FloorLength = (i - 1) * FloorStep;
FloorStart += (i - 1) * FloorStep;

// Generate player
//PlayerID = instance_create(view_wview[view_current] / 4, FloorHeight - sprite_get_height(spr_Player) / 2, obj_Player);
//PlayerID.ControllerID = id;

// Generate neon bike
PlayerID = instance_create(__view_get( e__VW.WView, view_current ) / 4, FloorHeight - 32, obj_NeonBike_bike);
PlayerID.ControllerID = id;

// Generate boundary so player cannot backtrack
BoundaryID = instance_create(x, y, obj_Boundary_bike);
BoundaryID.ControllerID = id;

// Associate Floor to Boundary and Player
FloorID.BoundaryID = BoundaryID;
FloorID.PlayerID = PlayerID;

// Generate next floor segment
scr_GenerateFloor_bike(id);

/* */
}
/*  */
