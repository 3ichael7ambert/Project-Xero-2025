function add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4) {
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