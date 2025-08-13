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
    /// @param {Array<Real>} _matrix A 4x4 transformation matrix.
    /// @param {Real} _width         The width of the tile.
    /// @param {Real} _height        The height of the tile.
    /// @param {Asset.Sprite} _sprite The sprite asset for the tile.
    /// @param {Real} _frame         The image index (frame) of the sprite to use.
    static add_tile_ext = function(_matrix, _width, _height, _sprite, _frame) {
        var _tile_struct = {
            matrix: _matrix,
            width: _width,
            height: _height,
            uvs: sprite_get_uvs(_sprite, _frame)
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

            // Check if the tile was added with a pre-built matrix or with components.
            if (variable_struct_exists(_tile, "matrix")) {
                // --- Use Pre-built Matrix ---
                _matrix = _tile.matrix;
            } else {
                // --- Build Matrix from Components ---
                var _epsilon = 0.0001;
                var _scale_x = 1 / (abs(dcos(_tile.rotY)) + _epsilon);
                var _scale_y = 1 / (abs(dcos(_tile.rotX)) + _epsilon);

                _matrix = matrix_build(
                    _tile.x, _tile.y, _tile.z,
                    _tile.rotX, _tile.rotY, _tile.rotZ,
                    _scale_x, _scale_y, 1
                );
            }

            // --- Common Vertex Calculation ---
            var _half_w = _tile.width / 2;
            var _half_h = _tile.height / 2;
            
            // The four corners of the quad in local space
            var _p1x = -_half_w, _p1y = -_half_h;
            var _p2x =  _half_w, _p2y = -_half_h;
            var _p3x =  _half_w, _p3y =  _half_h;
            var _p4x = -_half_w, _p4y =  _half_h;
            
            // Transform each corner point by the matrix.
            // matrix_transform_vertex returns an array: [x, y, z]
            var _v1 = matrix_transform_vertex(_matrix, _p1x, _p1y, 0);
            var _v2 = matrix_transform_vertex(_matrix, _p2x, _p2y, 0);
            var _v3 = matrix_transform_vertex(_matrix, _p3x, _p3y, 0);
            var _v4 = matrix_transform_vertex(_matrix, _p4x, _p4y, 0);
            
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
