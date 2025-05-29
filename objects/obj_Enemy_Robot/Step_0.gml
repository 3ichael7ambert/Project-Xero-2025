//SPRITE OFFSET
image_xscale=scale;
image_yscale=scale;


scr_Enemy_Robot_step_ai();
scr_Enemy_Robot_step_();

switch (jetpack_mode) {
	
	case 1:
		scr_Enemy_Robot_step_jetpack_1();
		break;
	case 2:
		scr_Enemy_Robot_step_jetpack_2();
		break;
	case 3:
		scr_Enemy_Robot_step_jetpack_3();
		break;
	
}

if jetpack_mode=1
{
	}

if jetpack_mode=2
{
}

if jetpack_mode=3
{
}

scr_Enemy_Robot_step_weapons();









