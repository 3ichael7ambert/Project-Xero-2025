/// @description Static manager for the shared Tile3d vertex format.
/// This ensures the format is only created once, improving efficiency.
global.__Tile3dFormat = {
    format: -1,

    // Initializes the shared vertex format if it hasn't been created yet.
    init: function() {
        if (format == -1) {
            vertex_format_begin();
            vertex_format_add_position_3d(); // Vertex position (x, y, z)
            vertex_format_add_texcoord();    // Texture coordinates (u, v)
            vertex_format_add_color();       // Vertex color (RGBA)
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
/// This allows for highly efficient rendering of many 3D-transformed tiles.
function Tile3d() constructor {
    // The vertex buffer and the texture used for drawing the mesh.
    vbuff = -1;
    texture = -1;
    
    // An array to hold all the tile data structs before building the mesh.
    tiles = [];

    /// @function add_tile(x, y, z, width, height, rotX, rotY, rotZ, sprite, frame)
    /// @description Adds a single tile's data using individual transform components.
    static add_tile = function(_x, _y, _z, _width, _height, _rotX, _rotY, _rotZ, _sprite, _frame) {
        var _tile_struct = {
            x: _x,
            y: _y,
            z: _z,
            width: _width,
            height: _height,
            rotX: _rotX,
            rotY: _rotY,
            rotZ: _rotZ,
            uvs: sprite_get_uvs(_sprite, _frame)
        };
        array_push(tiles, _tile_struct);
    }

    /// @function add_tile_ext(_matrix, _width, _height, _sprite, _frame)
    /// @description Adds a single tile's data using a pre-built transformation matrix.
    static add_tile_ext = function(_matrix, _width, _height, _sprite, _frame) {
        var _tile_struct = {
            matrix: _matrix,
            width: _width,
            height: _height,
            uvs: sprite_get_uvs(_sprite, _frame)
        };
        array_push(tiles, _tile_struct);
    }
	
    /// @function add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
    /// @description Adds a single distorted tile's data using a matrix and four local corner points.
    static add_tile_pos = function(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4) {
        var _tile_struct = {
            matrix: _matrix,
            uvs: sprite_get_uvs(_sprite, _frame),
            // The four corner points of the quad in local space.
            // Corresponds to draw_sprite_pos(top-left, top-right, bottom-right, bottom-left)
            p1: { x: _x1, y: _y1, z: 0 },
            p2: { x: _x2, y: _y2, z: 0 },
            p3: { x: _x3, y: _y3, z: 0 },
            p4: { x: _x4, y: _y4, z: 0 },
        };
        array_push(tiles, _tile_struct);
    }

    /// @function add_tiles(tiles_array)
    /// @description Adds an array of tiles' data to the internal array for a future build.
    static add_tiles = function(tiles_array) {
        for (var i = 0; i < array_length(tiles_array); i++) {
            array_push(tiles, tiles_array[i]);
        }
    }

    /// @function build(_texture)
    /// @description Builds the entire vertex buffer from the internally stored tile data.
    static build = function(_texture) {
        global.__Tile3dFormat.init();

        if (vbuff != -1) {
            vertex_delete_buffer(vbuff);
            vbuff = -1;
        }
        
        texture = sprite_get_texture(_texture, 0);

        vbuff = vertex_create_buffer();
        vertex_begin(vbuff, global.__Tile3dFormat.format);

        var _tile_count = array_length(tiles);
        for (var i = 0; i < _tile_count; i++) {
            var _tile = tiles[i];
            var _matrix;
            var _p1, _p2, _p3, _p4; // Local space points for the quad

            // First, get the transformation matrix for the tile
            if (variable_struct_exists(_tile, "matrix")) {
                _matrix = _tile.matrix;
            } else {
                // Build matrix from individual components
                var _epsilon = 0.0001;
                var _scale_x = 1 / (abs(dcos(_tile.rotY)) + _epsilon);
                var _scale_y = 1 / (abs(dcos(_tile.rotX)) + _epsilon);
                _matrix = matrix_build(
                    _tile.x, _tile.y, _tile.z,
                    _tile.rotX, _tile.rotY, _tile.rotZ,
                    _scale_x, _scale_y, 1
                );
            }

            // Next, get the local-space vertex positions for the quad
            if (variable_struct_exists(_tile, "p1")) {
                // --- Use Custom Quad from add_tile_pos ---
                _p1 = _tile.p1;
                _p2 = _tile.p2;
                _p3 = _tile.p3;
                _p4 = _tile.p4;
            } else {
                // --- Use Standard Rectangular Quad from add_tile / add_tile_ext ---
                var _half_w = _tile.width / 2;
                var _half_h = _tile.height / 2;
                _p1 = { x: -_half_w, y: -_half_h, z: 0 };
                _p2 = { x:  _half_w, y: -_half_h, z: 0 };
                _p3 = { x:  _half_w, y:  _half_h, z: 0 };
                _p4 = { x: -_half_w, y:  _half_h, z: 0 };
            }
            
            // --- Common Vertex Calculation ---
            var _v1 = matrix_transform_vertex(_matrix, _p1.x, _p1.y, _p1.z);
            var _v2 = matrix_transform_vertex(_matrix, _p2.x, _p2.y, _p2.z);
            var _v3 = matrix_transform_vertex(_matrix, _p3.x, _p3.y, _p3.z);
            var _v4 = matrix_transform_vertex(_matrix, _p4.x, _p4.y, _p4.z);
            
            var _uvs = _tile.uvs;
            var _uv_x1 = _uvs[0]; var _uv_y1 = _uvs[1];
            var _uv_x2 = _uvs[2]; var _uv_y2 = _uvs[3];

            var _color = c_white;
            var _alpha = 1;

            // Triangle 1: (v1, v2, v3)
            vertex_position_3d(vbuff, _v1[0], _v1[1], _v1[2]); vertex_texcoord(vbuff, _uv_x1, _uv_y1); vertex_color(vbuff, _color, _alpha);
            vertex_position_3d(vbuff, _v2[0], _v2[1], _v2[2]); vertex_texcoord(vbuff, _uv_x2, _uv_y1); vertex_color(vbuff, _color, _alpha);
            vertex_position_3d(vbuff, _v3[0], _v3[1], _v3[2]); vertex_texcoord(vbuff, _uv_x2, _uv_y2); vertex_color(vbuff, _color, _alpha);

            // Triangle 2: (v1, v3, v4)
            vertex_position_3d(vbuff, _v1[0], _v1[1], _v1[2]); vertex_texcoord(vbuff, _uv_x1, _uv_y1); vertex_color(vbuff, _color, _alpha);
            vertex_position_3d(vbuff, _v3[0], _v3[1], _v3[2]); vertex_texcoord(vbuff, _uv_x2, _uv_y2); vertex_color(vbuff, _color, _alpha);
            vertex_position_3d(vbuff, _v4[0], _v4[1], _v4[2]); vertex_texcoord(vbuff, _uv_x1, _uv_y2); vertex_color(vbuff, _color, _alpha);
        }
        
        vertex_end(vbuff);
        vertex_freeze(vbuff);
    }

    /// @function submit()
    /// @description Submits the vertex buffer to be drawn by the GPU.
    static submit = function() {
        if (vbuff != -1) {
            vertex_submit(vbuff, pr_trianglelist, texture);
        }
    }

    /// @function destroy()
    /// @description Cleans up instance-specific data (vertex buffer and tile array).
    static destroy = function() {
        if (vbuff != -1) {
            vertex_delete_buffer(vbuff);
            vbuff = -1;
        }
        tiles = [];
    }
}