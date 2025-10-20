function _rebuild_mesh_sky() {
    // ----------------------------
    // emit geometry from buildings
    // ----------------------------
    with (objBuilding_sky) {
        var w       = building_width;
        var h       = building_height;
        var d       = building_depth;
        var z_front = building_z;
        var z_doors = z_front - 1;

        // +1 for downward, -1 for upward — read from THIS building
        var step_s = (variable_instance_exists(self, "build_downward") && build_downward) ? 1 : -1;

        var x0 = x - (w - 1) * 0.5 * TILE;
        var y0 = y;

        // FRONT — base wall
        for (var i = 0; i < w; i++) {
            var xx = x0 + i * TILE - 32;
            for (var j = 0; j < h; j++) {
                var yy = y0 + (j * TILE * step_s);
                var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);
                other.builder.add_tile_pos(M, spr_front, frm_front, 0,0, TILE,0, TILE,TILE, 0,TILE);
            }
        }

        // STOREFRONT / DOORS (anchor row)
        var frame_px=4, kickplate_px=12, transom_px=12;
        var center_col = round((w - 1) * 0.5);
        var bias       = floor(lerp(-1, 1, other.hash01(x div TILE, y div TILE, 11, 0))); // <-- other.hash01
        var door_col   = clamp(center_col + bias, 0, max(0, w-2));

        for (var i = 0; i < w; i++) {
            if (i >= w-1) continue;
            var xx = x0 + i * TILE;
            var yy = y0;
            var M  = build_drawing_matrix(xx, yy, z_doors, 0, 0, 0);

            var xL = frame_px, xR = TILE - frame_px;
            var yKick1=frame_px, yKick2=frame_px+kickplate_px;
            var yTr2=TILE-frame_px, yTr1=yTr2-transom_px;
            yKick1 = other._clamp(yKick1,0,TILE);  // <-- other._clamp
            yKick2 = other._clamp(yKick2,0,TILE);
            yTr1   = other._clamp(yTr1,0,TILE);
            yTr2   = other._clamp(yTr2,0,TILE);

            if (i == door_col) {
                var yGlass1 = yKick2, yGlass2 = yTr1;
                other.builder.add_tile_pos(M, spr_door, frm_door, xL,yGlass1, xR,yGlass1, xR,yGlass2, xL,yGlass2, true);
                if (kickplate_px>0) other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL,yKick1, xR,yKick1, xR,yKick2, xL,yKick2);
                if (transom_px>0)   other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL,yTr1,  xR,yTr1,  xR,yTr2,  xL,yTr2);
            } else {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL,yKick2, xR,yKick2, xR,yTr1, xL,yTr1);
                if (kickplate_px>0) other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL,yKick1, xR,yKick1, xR,yKick2, xL,yKick2);
                if (transom_px>0)   other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL,yTr1,  xR,yTr1,  xR,yTr2,  xL,yTr2);
                var mull=frame_px, midxL=(TILE*0.5)-mull*0.5, midxR=(TILE*0.5)+mull*0.5;
                other.builder.add_tile_pos(M, spr_front, frm_front, midxL,yKick2, midxR,yKick2, midxR,yTr1, midxL,yTr1);
            }
        }

        // WINDOWS — upper/lower floors
        for (var i = 0; i < w; i++) {
            if (i >= w - 1) continue;
            for (var j = 1; j < h; j++) {
                if (other.hash01(x div TILE, y div TILE, j, i) <= 0.15) continue; // <-- other.hash01
                var xx = x0 + i * TILE;
                var yy = y0 + (j * TILE * step_s);
                var M  = build_drawing_matrix(xx, yy, z_doors, 0, 0, 0);

                var wm_l=10, wm_r=10, wm_t=12, wm_b=16;
                var x1=wm_l, y1=wm_t, x2=TILE-wm_r, y2=TILE-wm_b;
                y1 = other._clamp(y1,0,TILE);  // <-- other._clamp
                y2 = other._clamp(y2,0,TILE);

                other.builder.add_tile_pos(M, spr_window, frm_window, x1,y1, x2,y1, x2,y2, x1,y2);

                var rail_h=4, rail_y=other._clamp(lerp(y1,y2,0.52), 0, TILE);
                other.builder.add_tile_pos(M, spr_front, frm_front, x1,rail_y-rail_h*0.5, x2,rail_y-rail_h*0.5, x2,rail_y+rail_h*0.5, x1,rail_y+rail_h*0.5);
            }
        }

        // SIDES
        var x_left  = x0 - TILE * 0.5;
        var x_right = x0 + w * TILE - TILE * 0.5;
        for (var k = 0; k < d; k++) {
            var zz = z_front + k * TILE;
            for (var j = 0; j < h; j++) {
                var yy = y0 + (j * TILE * step_s);
                var ML = build_drawing_matrix(x_left,  yy, zz + 32, 0,  90, 0);
                var MR = build_drawing_matrix(x_right, yy, zz + 32, 0, -90, 0);
                other.builder.add_tile_ext(ML, TILE, TILE, spr_side, frm_side);
                other.builder.add_tile_ext(MR, TILE, TILE, spr_side, frm_side);
            }
        }

        // ROOF CAP (anchor row)
        var y_top = y;
        for (var i = 0; i < w; i++) {
            var xx = x0 + i * TILE;
            for (var k = 0; k < d; k++) {
                var zz = z_front + k * TILE;
                var MR = build_drawing_matrix(xx, y_top, zz + 32, 90, 0, 0);
                other.builder.add_tile_ext(MR, TILE, TILE, spr_roof, frm_roof);
            }
        }

        // lip
        var Mlip = build_drawing_matrix(x, y_top, z_front, 0, 0, 0);
        other.builder.add_tile_pos(Mlip, spr_roof, frm_roof, 0,0, 64,0, 64,8, 0,8);
    }

    // freeze+submit
    builder.build(sprBuilding_walls);
}
