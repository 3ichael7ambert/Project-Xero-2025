function scr_player_1_init_sprites(){
//sprites
sprite_body=sprBody;
sprite_body_offsetX=45;
sprite_body_offsetY=79;
if (current_month==12) {
	sprite_head=sprHeadSanta;
} else {
	sprite_head=sprHead_old;
}
sprite_armF=sprArmArms;
sprite_legF=sprLeg3;

spr_sword_arm = sprArmSword_1_Arm;
spr_sword_sword = sprArmSword_1_Sword;
spr_sword_fx = sprArmSword_1_Fx; 

}