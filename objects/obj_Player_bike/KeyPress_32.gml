/// @description  Jump

if (JumpTimer > -1)
{
    physics_apply_impulse(x, y, 0, JumpForce);
}

