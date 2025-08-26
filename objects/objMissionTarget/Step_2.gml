// stay loosely near other birds
var mate = instance_nearest(x,y,self);
if (mate != noone && mate.id != id) {
    var d = point_distance(x,y,mate.x,mate.y);
    if (d < 64) dir += irandom_range(-10,10); // jostle a bit
}
