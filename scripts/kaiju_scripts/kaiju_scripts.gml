// returns angles for upper/lower arm to reach target
function solve_arm_ik(x0, y0, tx, ty, L1, L2) {
    var dx = tx - x0, dy = ty - y0;
    var dist = point_distance(0,0, dx, dy);
    dist = clamp(dist, 1, L1 + L2 - 1); // clamp inside range

    // Law of cosines
    var a = arccos(clamp((sqr(L1) + sqr(dist) - sqr(L2)) / (2 * L1 * dist), -1, 1));
    var b = arccos(clamp((sqr(L1) + sqr(L2) - sqr(dist)) / (2 * L1 * L2), -1, 1));

    var base = point_direction(x0, y0, tx, ty);
    var ang1 = base - radtodeg(a);       // shoulder angle
    var ang2 = 180 - radtodeg(b);        // elbow relative bend

    return [ang1, ang2];
}
