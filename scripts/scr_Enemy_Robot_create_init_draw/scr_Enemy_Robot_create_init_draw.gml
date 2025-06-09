function scr_Enemy_Robot_create_init_draw(){


//sprites
sprite_body=sprBody;
sprite_body_idx=irandom_range(0,3);
sprite_body_offsetX=45;
sprite_body_offsetY=79;

sprite_eyes_style=choose("dark","light");
if (sprite_eyes_style=="dark") {
	sprite_eyes_img=sprHead_Eyes_Dark;
	sprite_eyes_idx = irandom_range(0,19);
	sprite_eyes_pupil_idx=3;
} else if (sprite_eyes_style=="light") {
	sprite_eyes_img=sprHead_Eyes_Light;
	sprite_eyes_idx = irandom_range(0,9);
	sprite_eyes_pupil_idx=0;
} else {
	sprite_eyes_img=sprHead_Eyes_Light;
	sprite_eyes_idx = 0;
	sprite_eyes_pupil_idx=0;
}
sprite_eyes=sprEyes;
if (current_month==12) {
	sprite_head=sprHeadSanta;
} else {
	sprite_head=sprHead;
	sprite_head_idx=irandom_range(0,5);
}




sprite_armB=sprArmArms;
sprite_legB=sprLeg3;
sprite_armF=sprArmArms;
sprite_legF=sprLeg3;
spr_sword_arm = sprArmSword_1_Arm;
spr_sword_sword = sprArmSword_1_Sword;
spr_sword_fx = sprArmSword_1_Fx; 


}