if instance_exists(obj_Player1) {
	
	with (obj_Player1) {
		jetpack_mode=2;
		can_switch_jetpack=false;
		game_style="mv";
		can_switch_weapons=false;
		weapon=1;
		
	}
	
}

//ENEMIES
scr_Director_Update_mv();
