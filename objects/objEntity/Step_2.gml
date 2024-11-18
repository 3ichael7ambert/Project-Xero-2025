/// @description Limit speed
speed = min(speed, max_speed);


///Take damage
if (take_damage > 0)
{
    hp -= take_damage;
    if (hp < 0)
    {
        instance_destroy();
    }
    take_damage = 0;
    repeat(5)
    {
        instance_create(x, y, objPiece);
    }
}



///Damage smoke
if (hp < max_hp)
{
    if (random(max_hp*3) < max_hp-hp)
    {
        var xx = x+random_range(5, -5);
        var yy = y+random_range(5, -5);
        var sp = random_range(0.1, 0.3);
        var a = create_effect(xx, yy, sprSmoke, sp, 0, -0.5, c_gray, 0.8);
    }
}


