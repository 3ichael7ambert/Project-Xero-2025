/// @description Insert description here
// You can write your code in this editor
x+=hsp;
y+=vsp;
//vsp-=grav;


//effect_create_depth(depth,ef_spark,x+irandom_range(-5,5),y+irandom_range(-5,5),.1,choose(col1,col2,col3));
 part_particles_create(_psFireworkTrail,x,y,_ptypeFireworkTrail,1);
 
 life--;
 
 if (life<=0) {
	 instance_destroy();
 }