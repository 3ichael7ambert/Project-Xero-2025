/// scr_GenerateFloor_bike(ctrl)
/// @param ctrl  (controller instance id)
function scr_GenerateFloor_bike(ctrl)
{
    var _ctrl = argument0;

    with (_ctrl)
    {
        // --- Tunables ---
        var MAX_DELTA = 220;                  // max vertical change per segment (friendlier terrain)
        var LEN_MIN   = 30;                   // min number of steps in a segment
        var LEN_MAX   = 80;                   // max number of steps in a segment

        // --- Read controller state ---
        var _floorStep   = FloorStep;
        var _floorStart  = FloorStart;
        var _hOld        = FloorHeight;       // previous baseline height
        var _hTarget     = irandom_range(_hOld - MAX_DELTA, _hOld + MAX_DELTA);
            _hTarget     = clamp(_hTarget, _hOld - MAX_DELTA, _hOld + MAX_DELTA);
        var _lenSteps    = irandom_range(LEN_MIN, LEN_MAX);

        // --- Make floor instance at the old baseline ---
        var _floor = instance_create(_floorStart, _hOld, obj_Floor_bike);
        _floor.FloorHeight  = _hTarget;       // tell the floor where it’s going to
        _floor.ControllerID = id;
        _floor.BoundaryID   = BoundaryID;
        _floor.PlayerID     = PlayerID;

        // --- Surface (large enough to draw under/over) ---
        _floor.SurfaceID   = surface_create(_lenSteps * _floorStep, 4 * room_height);
        _floor.FloorOffset = surface_get_height(_floor.SurfaceID) / 4;  // keep floor within first quarter

        // --- Physics chain shape ---
        var fx = physics_fixture_create();
        physics_fixture_set_chain_shape(fx, false);

        // --- Begin drawing to the floor’s surface ---
        surface_set_target(_floor.SurfaceID);
        draw_set_alpha(1);

        // Drawing cursors
        var x_prev = -_floorStep;
        var y_prev = _floor.FloorOffset;      // local top of the drawable floor on surface
        var y_base = y_prev;                  // cached starting line for continuity

        // Precompute sizes (textures are already on controller)
        var _floorTexH = FloorTextureHeight;

        // Build chain + draw
        for (var i = 0; i < _lenSteps; i++)
        {
            // Smooth progression 0..1 (cubic smoothstep)
            var t   = i / _lenSteps;
            var P   = t * t * (3 - 2 * t);
            var c   = lerp(_hOld, _hTarget, P);       // absolute world Y of path at this step
            var ly  = c - _hOld;                      // local Y relative to floor instance origin

            // --- Physics point (local to the floor instance) ---
            physics_fixture_add_point(fx, i * _floorStep, ly);

            // --- Optional debug line: line rider
            draw_set_colour(c_black);
            draw_line_width(x_prev, y_prev, x_prev + _floorStep, y_base + ly, LineWidth);

            // --- Filled geometry (underlay + floor skin) ---
            if (Fill)
            {
                // Under-floor (VoidTexture)
                draw_set_colour(c_white);

                draw_primitive_begin_texture(pr_trianglestrip, VoidTexture);
                draw_vertex_texture(x_prev,                 surface_get_height(_floor.SurfaceID), 0, 1);
                draw_vertex_texture(x_prev + _floorStep,    surface_get_height(_floor.SurfaceID), 1, 1);
                draw_vertex_texture(x_prev,                 y_prev + _floorTexH - 1,              0, 0);
                draw_vertex_texture(x_prev + _floorStep,    y_base + ly + _floorTexH - 1,         1, 0);
                draw_primitive_end();

                // Floor skin (FloorTexture)
                draw_primitive_begin_texture(pr_trianglestrip, FloorTexture);
                draw_vertex_texture(x_prev,                 y_prev + _floorTexH, 0, 1);
                draw_vertex_texture(x_prev + _floorStep,    y_base + ly + _floorTexH, 1, 1);
                draw_vertex_texture(x_prev,                 y_prev, 0, 0);
                draw_vertex_texture(x_prev + _floorStep,    y_base + ly, 1, 0);
                draw_primitive_end();
            }

            // Advance draw cursors
            x_prev += _floorStep;
            y_prev  = y_base + ly;
        }

        // Done drawing to surface
        surface_reset_target();

        // Finalize fixture
        physics_fixture_set_collision_group(fx, 0);
        physics_fixture_set_density        (fx, 0);
        physics_fixture_set_restitution    (fx, 0.2);
        physics_fixture_set_friction       (fx, 5);
        physics_fixture_set_linear_damping (fx, 0);
        physics_fixture_set_angular_damping(fx, 0);
        physics_fixture_set_kinematic      (fx);           // floor is static/kinematic

        physics_fixture_bind(fx, _floor);
        physics_fixture_delete(fx);

        // Segment bookkeeping (avoid using loop var outside scope)
        _floor.FloorLength = (_lenSteps - 1) * _floorStep;

        // Advance controller state for the next segment
        FloorStart  += (_lenSteps - 1) * _floorStep;       // where next segment begins (world X)
        FloorHeight  = _hTarget;                           // new baseline becomes target
        FloorLast    = _hTarget;                           // if you use this elsewhere (e.g., boundary Y)
    }
}
