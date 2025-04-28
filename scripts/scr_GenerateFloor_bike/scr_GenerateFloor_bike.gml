function scr_GenerateFloor_bike(argument0) {
	// scr_GenerateFloor(ControllerID);
/*
	var ControllerID = argument0;

	with (ControllerID)
	{
	    var FloorHeightOld = FloorHeight,
	        FloorLength = irandom_range(30, 80);                                        // Random length of floor to build
        
	    FloorHeight = irandom_range(FloorHeightOld - 500, FloorHeightOld + 500);        // Set target height
    
	    FloorID = instance_create(FloorStart, FloorHeightOld, obj_Floor_bike);               // Create floor instance
	    FloorID.FloorHeight = FloorHeight;
	    FloorID.ControllerID = id;
	    FloorID.BoundaryID = BoundaryID;
	    FloorID.PlayerID = PlayerID;
    
	    // Surface
	    FloorID.SurfaceID = surface_create(FloorLength * FloorStep, 4 * room_height);   // Create surface to draw floor texture on
	    FloorID.FloorOffset = surface_get_height(FloorID.SurfaceID) / 4;                // Make sure FloorHeight is never greater than 1/4 of surface
    
	    var Fixture = physics_fixture_create(),                                         // Create physics for floor
	        Group = 0,
	        Density = 0,
	        Restitution = 0.2,
	        Friction = 5,
	        LinearDamp = 0,
	        AngularDamp = 0;
        
	    physics_fixture_set_chain_shape(Fixture, false);
    
	    surface_set_target(FloorID.SurfaceID);                                          // Set drawing surface to floor surface
    
	    draw_set_alpha(1);
	    draw_set_colour(c_black);
    
	    var x_Previous = -FloorStep,
	        y_Previous = FloorID.y + FloorID.FloorOffset - FloorHeightOld,
	        y_Start = y_Previous;
        
	    for (var i = 0; i < FloorLength; i++)
	    {
	        var FloorPercent = i / FloorLength,                                                                             // Parameters to create smooth, cubic floor
	            P = FloorPercent * FloorPercent * (3 - (2 * FloorPercent)),
	            a = FloorHeightOld,
	            b = FloorHeight,
	            c = lerp(a, b, P),
            
//	        physics_fixture_add_point(Fixture, i * FloorStep, c - FloorHeightOld);                                          // Add point to physics fixture
        
//	        draw_line_width(x_Previous, y_Previous, x_Previous + FloorStep, y_Start + c - FloorHeightOld, LineWidth);       // Draw line if you wanted to make a line rider game
        /*
	        if (Fill)
	        {
	            draw_set_colour(c_white);
            
	           
            
	            draw_primitive_begin_texture(pr_trianglestrip, VoidTexture);                                                // Texture to draw under floor texture
	            draw_vertex_texture(x_Previous, surface_get_height(FloorID.SurfaceID), 0, 1);
	            draw_vertex_texture(x_Previous + FloorStep, surface_get_height(FloorID.SurfaceID), 1, 1);
	            draw_vertex_texture(x_Previous, y_Previous + FloorTextureHeight - 1, 0, 0);
	            draw_vertex_texture(x_Previous + FloorStep, y_Start + c - FloorHeightOld + FloorTextureHeight - 1, 1, 0);
	            draw_primitive_end();
            
	            draw_primitive_begin_texture(pr_trianglestrip, FloorTexture);                                               // Texture to draw for floor
	            draw_vertex_texture(x_Previous, y_Previous + FloorTextureHeight, 0, 1);
	            draw_vertex_texture(x_Previous + FloorStep, y_Start + c - FloorHeightOld + FloorTextureHeight, 1, 1);
	            draw_vertex_texture(x_Previous, y_Previous, 0, 0);
	            draw_vertex_texture(x_Previous + FloorStep, y_Start + c - FloorHeightOld, 1, 0);
	            draw_primitive_end();
	        }
        
	        x_Previous += FloorStep;
	        y_Previous = y_Start + c - FloorHeightOld;
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
	    FloorStart += (i - 1) * FloorStep;                              // Update controller's FloorStart for next segment
	}

*/

}
	