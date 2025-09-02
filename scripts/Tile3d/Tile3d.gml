/// @description Static manager for the shared Tile3d vertex format.
/// This ensures the format is only created once, improving efficiency.
global.__Tile3dFormat = {
    format: -1,

    // Initializes the shared vertex format if it hasn't been created yet.
    init: function() {
        if (format == -1) {
            vertex_format_begin();
			vertex_format_add_position_3d();
			vertex_format_add_texcoord();
			vertex_format_add_color();
			vertex_format_add_normal(); // required
            format = vertex_format_end();
        }
    },

    // Cleans up the shared vertex format. Call this on Game End.
    cleanup: function() {
        if (format != -1) {
            vertex_format_delete(format);
            format = -1;
        }
    }
}

/// @function Tile3d()
/// @description A constructor for creating and managing a 3D tile mesh using a vertex buffer.
/// This allows for highly efficient rendering of many 3D-transformed tiles across multiple texture pages,
/// with correct sorting for opaque and transparent geometry.
function Tile3d() constructor {
    // Structs to hold tile data, segregated by transparency.
    tile_groups = {
        opaque: {},
        transparent: {}
    };
    // A single list of built meshes, ordered with opaque first, then transparent.
    render_list = [];

    /// @function add_tile(x, y, z, width, height, rotX, rotY, rotZ, sprite, frame, is_transparent)
    /// @description Adds a single tile's data using individual transform components.
    static add_tile = function(_x, _y, _z, _width, _height, _rotX, _rotY, _rotZ, _sprite, _frame, _is_transparent = false) {
        var _group = _is_transparent ? tile_groups.transparent : tile_groups.opaque;
        var _tex = sprite_get_texture(_sprite, _frame);
        var _tex_key = string(_tex);

        if (!variable_struct_exists(_group, _tex_key)) {
            _group[$ _tex_key] = {
                tiles: [],
                sprite_asset: _sprite // Store the sprite to get a fresh texture pointer later
            };
        }
        
        var _tile_struct = {
            x: _x, y: _y, z: _z,
            width: _width, height: _height,
            rotX: _rotX, rotY: _rotY, rotZ: _rotZ,
            sprite: _sprite, frame: _frame,
            is_transparent: _is_transparent,
            uvs: sprite_get_uvs(_sprite, _frame)
        };
        array_push(_group[$ _tex_key].tiles, _tile_struct);
    }

    /// @function add_tile_ext(_matrix, _width, _height, _sprite, _frame, _is_transparent)
    /// @description Adds a single tile's data using a pre-built transformation matrix.
    static add_tile_ext = function(_matrix, _width, _height, _sprite, _frame, _is_transparent = false) {
        var _group = _is_transparent ? tile_groups.transparent : tile_groups.opaque;
        var _tex = sprite_get_texture(_sprite, _frame);
        var _tex_key = string(_tex);

        if (!variable_struct_exists(_group, _tex_key)) {
            _group[$ _tex_key] = {
                tiles: [],
                sprite_asset: _sprite
            };
        }

        var _tile_struct = {
            matrix: _matrix,
            width: _width, height: _height,
            sprite: _sprite, frame: _frame,
            is_transparent: _is_transparent,
            uvs: sprite_get_uvs(_sprite, _frame)
        };
        array_push(_group[$ _tex_key].tiles, _tile_struct);
    }
    
    /// @function add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _is_transparent)
    /// @description Adds a single distorted tile's data using a matrix and four local corner points.
    static add_tile_pos = function(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _is_transparent = false) {
        var _group = _is_transparent ? tile_groups.transparent : tile_groups.opaque;
        var _tex = sprite_get_texture(_sprite, _frame);
        var _tex_key = string(_tex);

        if (!variable_struct_exists(_group, _tex_key)) {
            _group[$ _tex_key] = {
                tiles: [],
                sprite_asset: _sprite
            };
        }

        var _tile_struct = {
            matrix: _matrix,
            sprite: _sprite, frame: _frame,
            is_transparent: _is_transparent,
            uvs: sprite_get_uvs(_sprite, _frame),
            p1: { x: _x1, y: _y1, z: 0 },
            p2: { x: _x2, y: _y2, z: 0 },
            p3: { x: _x3, y: _y3, z: 0 },
            p4: { x: _x4, y: _y4, z: 0 },
        };
        array_push(_group[$ _tex_key].tiles, _tile_struct);
    }

    /// @function add_tiles(tiles_array)
    /// @description Adds an array of tiles' data. Structs can optionally contain an 'is_transparent' field.
    static add_tiles = function(tiles_array) {
        var _len = array_length(tiles_array);
        for (var i = 0; i < _len; i++) {
            var _tile = tiles_array[i];
            
            if (!variable_struct_exists(_tile, "sprite") || !variable_struct_exists(_tile, "frame")) {
                show_debug_message("WARNING: Tile3d.add_tiles() skipped a tile at index " + string(i) + " due to missing 'sprite' or 'frame' property.");
                continue;
            }
            
            var _is_transparent = variable_struct_exists(_tile, "is_transparent") ? _tile.is_transparent : false;
            var _group = _is_transparent ? tile_groups.transparent : tile_groups.opaque;
            var _tex = sprite_get_texture(_tile.sprite, _tile.frame);
            var _tex_key = string(_tex);
            
            if (!variable_struct_exists(_group, _tex_key)) {
                _group[$ _tex_key] = {
                    tiles: [],
                    sprite_asset: _tile.sprite
                };
            }
            array_push(_group[$ _tex_key].tiles, _tile);
        }
    }

    /// @function build()
    /// @description Builds vertex buffers for opaque and transparent tiles and adds them to an ordered render list.
    static build = function() {
        global.__Tile3dFormat.init();

        // Clear any previously built meshes
        for (var i = 0; i < array_length(render_list); i++) {
            vertex_delete_buffer(render_list[i].vbuff);
        }
        render_list = [];
        
        // Helper function to build a set of meshes and append them to the render_list
        var _build_and_append_meshes = function(source_groups) {
            var _group_keys = variable_struct_get_names(source_groups);
            for (var i = 0; i < array_length(_group_keys); i++) {
                var _tex_key = _group_keys[i];
                var _group = source_groups[$ _tex_key];
                var _tiles_for_tex = _group.tiles;
                var _representative_sprite = _group.sprite_asset;
                var _tile_count = array_length(_tiles_for_tex);
                if (_tile_count == 0) continue;

                var _vbuff = vertex_create_buffer();
                vertex_begin(_vbuff, global.__Tile3dFormat.format);

                for (var j = 0; j < _tile_count; j++) {
                    var _tile = _tiles_for_tex[j];
                    var _matrix;
                    var _p1, _p2, _p3, _p4;
                    if (variable_struct_exists(_tile, "matrix")) {
                        _matrix = _tile.matrix;
                    } else {
                        var _epsilon = 0.0001;
                        var _scale_x = 1 / (abs(dcos(_tile.rotY)) + _epsilon);
                        var _scale_y = 1 / (abs(dcos(_tile.rotX)) + _epsilon);
                        _matrix = matrix_build(_tile.x, _tile.y, _tile.z, _tile.rotX, _tile.rotY, _tile.rotZ, _scale_x, _scale_y, 1);
                    }
                    if (variable_struct_exists(_tile, "p1")) {
                        _p1 = _tile.p1; _p2 = _tile.p2; _p3 = _tile.p3; _p4 = _tile.p4;
                    } else {
                        var _half_w = _tile.width / 2; var _half_h = _tile.height / 2;
                        _p1 = { x: -_half_w, y: -_half_h, z: 0 }; _p2 = { x: _half_w, y: -_half_h, z: 0 };
                        _p3 = { x: _half_w, y: _half_h, z: 0 }; _p4 = { x: -_half_w, y: _half_h, z: 0 };
                    }
                    var _v1 = matrix_transform_vertex(_matrix, _p1.x, _p1.y, _p1.z);
					var _v2 = matrix_transform_vertex(_matrix, _p2.x, _p2.y, _p2.z);
					var _v3 = matrix_transform_vertex(_matrix, _p3.x, _p3.y, _p3.z);
					var _v4 = matrix_transform_vertex(_matrix, _p4.x, _p4.y, _p4.z);

					// --- NEW: compute a world-space face normal from the first tri
					var _e1 = [ _v2[0]-_v1[0], _v2[1]-_v1[1], _v2[2]-_v1[2] ];
					var _e2 = [ _v3[0]-_v1[0], _v3[1]-_v1[1], _v3[2]-_v1[2] ];
					var _Nx = _e1[1]*_e2[2] - _e1[2]*_e2[1];
					var _Ny = _e1[2]*_e2[0] - _e1[0]*_e2[2];
					var _Nz = _e1[0]*_e2[1] - _e1[1]*_e2[0];
					// builder (face normal)
					var _L  = max(0.000001, sqrt(_Nx*_Nx + _Ny*_Ny + _Nz*_Nz));
					_Nx /= _L; 
					_Ny /= _L; 
					_Nz /= _L;

					// If some faces shade inside-out, flip once:  _Nx=-_Nx; _Ny=-_Ny; _Nz=-_Nz;

					var _uvs = _tile.uvs;
					var _uv_x1 = _uvs[0]; var _uv_y1 = _uvs[1];
					var _uv_x2 = _uvs[2]; var _uv_y2 = _uvs[3];
					var _color = c_white; var _alpha = 1;

// (your six vertex_position_3d calls are here)

                    // tri 1: v1, v2, v3
					vertex_position_3d(_vbuff, _v1[0], _v1[1], _v1[2]);
					vertex_texcoord   (_vbuff, _uv_x1, _uv_y1);
					vertex_color      (_vbuff, _color, _alpha);
					vertex_normal  (_vbuff, _Nx, _Ny, _Nz);

					vertex_position_3d(_vbuff, _v2[0], _v2[1], _v2[2]);
					vertex_texcoord   (_vbuff, _uv_x2, _uv_y1);
					vertex_color      (_vbuff, _color, _alpha);
					vertex_normal  (_vbuff, _Nx, _Ny, _Nz);

					vertex_position_3d(_vbuff, _v3[0], _v3[1], _v3[2]);
					vertex_texcoord   (_vbuff, _uv_x2, _uv_y2);
					vertex_color      (_vbuff, _color, _alpha);
					vertex_normal  (_vbuff, _Nx, _Ny, _Nz);

					// tri 2: v1, v3, v4
					vertex_position_3d(_vbuff, _v1[0], _v1[1], _v1[2]);
					vertex_texcoord   (_vbuff, _uv_x1, _uv_y1);
					vertex_color      (_vbuff, _color, _alpha);
					vertex_normal  (_vbuff, _Nx, _Ny, _Nz);

					vertex_position_3d(_vbuff, _v3[0], _v3[1], _v3[2]);
					vertex_texcoord   (_vbuff, _uv_x2, _uv_y2);
					vertex_color      (_vbuff, _color, _alpha);
					vertex_normal  (_vbuff, _Nx, _Ny, _Nz);

					vertex_position_3d(_vbuff, _v4[0], _v4[1], _v4[2]);
					vertex_texcoord   (_vbuff, _uv_x1, _uv_y2);
					vertex_color      (_vbuff, _color, _alpha);
					vertex_normal  (_vbuff, _Nx, _Ny, _Nz);
					
					}
                vertex_end(_vbuff);
                vertex_freeze(_vbuff);
                array_push(render_list, { vbuff: _vbuff, sprite: _representative_sprite });
            }
        };

        // Build opaque meshes first and add them to the list
        _build_and_append_meshes(tile_groups.opaque);
        
        // Build transparent meshes and add them to the end of the list
        _build_and_append_meshes(tile_groups.transparent);
        
        // Clear the temporary tile data
        tile_groups.opaque = {};
        tile_groups.transparent = {};
    }

    /// @function submit()
    /// @description Submits all built vertex buffers from the ordered render list.
    static submit = function() {
        var _len = array_length(render_list);
        for (var i = 0; i < _len; i++) {
            var _mesh = render_list[i];
            var _texture = sprite_get_texture(_mesh.sprite, 0);
            if (_texture != -1) {
                vertex_submit(_mesh.vbuff, pr_trianglelist, _texture);
            }
        }
    }

    /// @function destroy()
    /// @description Cleans up all vertex buffers and tile data.
    static destroy = function() {
        // Clear any built meshes
        for (var i = 0; i < array_length(render_list); i++) {
            vertex_delete_buffer(render_list[i].vbuff);
        }
        
        render_list = [];
        tile_groups.opaque = {};
        tile_groups.transparent = {};
    }
}