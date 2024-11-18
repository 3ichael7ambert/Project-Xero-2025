/// @description Explode
var radius = 64;
repeat(20)
{
    var xx = x+lengthdir_x(random(radius), random(360));
    var yy = y+lengthdir_y(random(radius), random(360));
    var sp = random_range(0.05, 0.1);
    create_effect(xx, yy, sprSmoke, sp, 0, -0.5, c_gray, 0.8);
}
create_effect(x, y, sprExplosion, 0.4, 0, 0, c_white, 1);


