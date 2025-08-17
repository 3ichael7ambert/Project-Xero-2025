/// Simple deterministic 0..1 hash
function hash01(a,b,c,d) {
    var xx = (a * 73856093) ^ (b * 19349663) ^ (c * 83492791) ^ (d * 2654435761);
    xx = (xx ^ (xx << 13)) & $ffffffff;
    xx = (xx ^ (xx >> 17)) & $ffffffff;
    xx = (xx ^ (xx << 5 )) & $ffffffff;
    return (xx & $7fffffff) / 2147483647;
}
