/// angle_lerp(a, b, amt) – wrap-safe
function angle_lerp(a, b, amt) {
    var d = angle_difference(b, a);
    return a + d * amt;
}
