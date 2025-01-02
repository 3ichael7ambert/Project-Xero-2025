/// @description Insert description here
// You can write your code in this editor
hsp=random_range(-3,3);
vsp=random_range(5,7);

 part_particles_create(_psFireworkExplode,x,y,_ptypeFireworkTrail,irandom_range(5,15));
 
 //effect_create_above(ef_firework,x+irandom_range(-100,100),y+irandom_range(-100,100),1,choose(col1,col2,col3));
 effect_create_above(ef_firework,x,y,1,choose(col1,col2,col3));