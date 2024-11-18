// Player input
KeyRight = keyboard_check(vk_right);
KeyLeft = -keyboard_check(vk_left);

Move = KeyRight + KeyLeft;

physics_apply_torque(Move * Torque);

image_xscale=scale;
image_yscale=scale;