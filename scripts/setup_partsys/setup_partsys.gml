/// @description setup_partsys();
function setup_partsys(_target) {
	/*
	Created by: Rayu Johnson
	This function creates a new particle system
	*/

	globalvar PARTICLE_ENGINE;
	PARTICLE_ENGINE = _target;

	globalvar _SYS_TOP, _SYS_BOT, _partArray;
	_SYS_TOP = part_system_create();
	_SYS_BOT = part_system_create();
	_partArray = [];

	/*******************************************/
	part_system_depth( _SYS_TOP, -5001);
	part_system_depth( _SYS_BOT, -4999);


	/*
	initiliaze particle properties
	*/

	pWaterSplash = create_splash();
	pSmack = setup_animate(spr_whack,20);
	pDeath = setup_explode(pt_dust);
	pHit = setup_splatter(pt_flare);
	pMisc = setup_wander(pt_orb);
	pSplash = setup_water_ripple(pt_splash);
	/// ice attack
	pFrost = setup_splash(pt_ice);
	pIce = setup_crystal(pFrost,pt_ice);
	/// fire attack
	pFlame = create_small_flame();
	/// rock attack
	pPebble = setup_splatter(pt_earth);
	pRock = setup_rock(pPebble,pt_earth);
	
	/// Water Attack
	pDrop = setup_splash(pt_water);
	pWater = setup_emit_jump(pDrop,c_aqua);
	/// Wind Attack
	pDust = setup_explode(pt_wind2);
	pWind = setup_wind(pDust,pt_wind);
	/// wood blast
	pWood = setup_splatter(pt_wood);
	/// Rock blast
	pRock = setup_splatter(pt_rock);
	/// claw
	pClaw = setup_claw(pt_claw);
	/// pot explode
	pPot = setup_splatter(pt_pot);
	/// chest open
	pSparkle = setup_wander(spr_sparkles);
	/// leaves
	pLeaf = setup_splatter(pt_leaf);
	/// collectibles
	pCollect = create_star_puff();
	/// healing
	pHeal = create_heal_field();
	/// leveling
	pLevel = create_part_levelup();
	/// Rock blast
	pPuff = setup_splatter(pt_puff);
	/*
		weather
	*/
	
	var _time1 = room_height / 768 * 80;
	var _time2 = room_height / 768 * 240;
	var _time3 = room_height / 768 * 120;
	pWeatherRain = scr_setup_part_rain(_time1, _time1);
	pWeatherSnow = scr_setup_part_snow(_time2, _time2);
	pWeatherSlush = scr_setup_part_slush(_time3, _time3);

	/***************    EXPLOSIOMS    *************************/
	pFireball = setup_blowup(pt_fireball,30,30,.6,.8,-.001,false);
	pEmber = setup_blowup(pt_firespot,15,20,.5,1,-.01,true);
	pAsh = setup_blowup(pt_ash,15,15,.25,.5,-.01,true);

	//----------------------- Link Particles
	part_type_step(pFireball,3,pEmber);
	part_type_death(pEmber,1,pAsh);
	part_type_blend(pAsh,false);
	/************************************************************/
	
	/***************************** SPELLS ***********************/
	
	/// Electric Type
	pSpell_charge = setup_animate_ext(pt_spell_charge, 2);
	pSpell_shock = setup_animate_ext(pt_spell_shock, 2);
	pSpell_spark = setup_animate_ext(pt_spell_spark, 2);
	pSpell_zap = setup_animate_ext(pt_spell_lightning, 2);
	
	/// Air Type
	pSpell_impact = setup_animate_ext(pt_spell_impact, 2);
	pSpell_puff = setup_animate_ext(pt_spell_puff, 2);
	pSpell_smoke = setup_animate_ext(pt_spell_smoke, 2);
	pSpell_tornado = setup_animate_ext(pt_spell_tornado, 2);
	
	/// Water Type
	pSpell_ice = setup_animate_ext(pt_spell_ice, 2);
	pSpell_splash = setup_animate_ext(pt_spell_splash, 2);
	pSpell_water = setup_animate_ext(pt_spell_water, 2);
	
	/// Fire Type
	pSpell_blast = setup_animate_ext(pt_spell_blast, 2);
	pSpell_pop = setup_animate_ext(pt_spell_firepop, 2);
	pSpell_flame = setup_animate_ext(pt_spell_flame, 2);
	pSpell_missile = setup_animate_ext(pt_spell_missile, 2, true);
	pSpell_sun = setup_animate_ext(pt_spell_sun, 2);
	pSpell_whisp = setup_animate_ext(pt_spell_whisp, 2);
	
	/// MISC
	pSpell_heal = setup_animate_ext(pt_spell_heal, 2);
	pSpell_hit = setup_animate_ext(pt_spell_hit, 2);



}
