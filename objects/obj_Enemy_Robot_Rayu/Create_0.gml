/// @description Insert description here
// You can write your code in this editor

/*
//1=walk 2=jetshoes 3=jetpack
jetpack_mode=1;
scale=0.8;


//Create
// Create enemy character at its current object position
enemyCharacter = new Character2D(x, y).Initialize();

spr_enemy_head=sprHead;
spr_enemy_eyes=sprEyes;
spr_enemy_torso=sprBody;
spr_enemy_leg_back=sprLeg;
spr_enemy_leg_front=sprLeg;
spr_enemy_arm_back=sprArmArms;
spr_enemy_arm_front=sprArmArms;
spr_enemy_fist_back=sprArmHand;
spr_enemy_fist_front=sprArmHand;
// Add sprites to bones (replace with your actual enemy sprites)
enemyCharacter.AddBodyPart(enemyCharacter.FindBone("head"), spr_enemy_head);
enemyCharacter.AddBodyPart(enemyCharacter.FindBone("torso"), spr_enemy_torso);
enemyCharacter.AddBodyPart(enemyCharacter.FindBone("leftLeg"), spr_enemy_leg_back);
enemyCharacter.AddBodyPart(enemyCharacter.FindBone("rightLeg"), spr_enemy_leg_front, 0, 0, -1, 1);
