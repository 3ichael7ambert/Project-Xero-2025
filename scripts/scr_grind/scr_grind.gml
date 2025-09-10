/*

function scr_grind_init(){

player_state   = STATE_NORMAL;

// grind fields
grinding       = false;
grind_path     = -1;      // path resource from the rail
grind_len      = 0;       // pixels
grind_t        = 0;       // 0..1 along the path
grind_dir      = 1;       // +1/-1 along the path
grind_speed    = 0;       // pixels/sec-ish (frames)
grind_speed_min= 1.2;
grind_speed_max= 14;
grind_snap_px  = 28;      // how close you must be to snap
grind_step_px  = 6;       // sampling resolution along path
grind_fric     = 0.985;   // gentle friction each step
grind_boost    = 0.22;    // impulse when attaching
grind_off_imp  = 6.0;     // impulse when jumping off
grind_coyote   = 0;       // small detach buffer (frames)

// simple particle handle (optional)
grind_spark_timer = 0;


}

function grind_nearest_on_path(_path, _px, _py, _step_px) {
    var len = path_get_length(_path);
    if (len <= 0) return undefined;

    var best_d2 = 1e30, best_t = 0, best_x = 0, best_y = 0;
    var samples = max(2, ceil(len / max(1,_step_px)));

    for (var i = 0; i <= samples; i++) {
        var t = i / samples;
        var x = path_get_point_x(_path, t);
        var y = path_get_point_y(_path, t);
        var d2 = sqr(x - _px) + sqr(y - _py);
        if (d2 < best_d2) { best_d2 = d2; best_t = t; best_x = x; best_y = y; }
    }

    // tangent via small delta
    var dt = 1.0 / samples;
    var t2 = clamp(best_t + dt, 0, 1);
    var tx = path_get_point_x(_path, t2) - best_x;
    var ty = path_get_point_y(_path, t2) - best_y;
    var mag = max(0.0001, point_distance(0,0,tx,ty));
    tx /= mag; ty /= mag;

    return {
        path: _path,
        t: best_t,
        x: best_x, y: best_y,
        tx: tx, ty: ty,
        dist: sqrt(best_d2),
        len: len
    };
}

function grind_find_near(px,py, snap_px, step_px) {
    var best = undefined, bestDist = 1e30;

    with (objRail) if (path_index != -1) {
        var hit = grind_nearest_on_path(path_index, px, py, step_px);
        if (is_undefined(hit)) continue;
        if (hit.dist < snap_px && hit.dist < bestDist) {
            best = hit; bestDist = hit.dist;
        }
    }
    return best;
}
