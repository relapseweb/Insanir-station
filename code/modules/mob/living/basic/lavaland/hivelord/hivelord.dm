/// Mob which retreats and spawns annoying sub-mobs to attack you
/mob/living/basic/mining/hivelord
	name = "hivelord"
	desc = "A levitating swarm of tiny creatures which act as a single individual. When threatened or hunting they rapidly replicate additional short-lived bodies."
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "hivelord"
	icon_living = "hivelord"
	// icon_aggro = "hivelord_alert"
	icon_dead = "hivelord_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	speed = 2
	maxHealth = 75
	health = 75
	melee_damage_lower = 0
	melee_damage_upper = 0
	attack_verb_continuous = "weakly tackles"
	attack_verb_simple = "weakly tackles"
	speak_emote = list("telepathically cries")
	attack_sound = 'sound/weapons/pierce.ogg'
	throw_blocked_message = "passes between the bodies of the"
	obj_damage = 0
	pass_flags = PASSTABLE
	ai_controller = /datum/ai_controller/basic_controller/hivelord
	/// Mobs to spawn when we die, varedit this to be recursive to give the players a fun surprise
	var/death_spawn_type = /mob/living/basic/hivelord_brood
	/// Action which spawns worms
	var/datum/action/cooldown/mob_cooldown/hivelord_spawn/spawn_brood

/mob/living/basic/mining/hivelord/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(/obj/item/organ/internal/monster_core/regenerative_core)
	AddElement(/datum/element/relay_attackers)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/clickbox, icon_state = "hivelord", max_scale = INFINITY, dead_state = "hivelord_dead") // They writhe so much.
	AddComponent(/datum/component/appearance_on_aggro, aggro_state = "hivelord_alert")
	spawn_brood = new(src)
	spawn_brood.Grant(src)
	ai_controller.set_blackboard_key(BB_TARGETTED_ACTION, spawn_brood)

/mob/living/basic/mining/hivelord/Destroy()
	QDEL_NULL(spawn_brood)
	return ..()

/mob/living/basic/mining/hivelord/death(gibbed)
	. = ..()
	var/list/safe_turfs = RANGE_TURFS(1, src) - get_turf(src)
	for (var/turf/check_turf as anything in safe_turfs)
		if (check_turf.is_blocked_turf(exclude_mobs = TRUE))
			safe_turfs -= check_turf

	var/turf/our_turf = get_turf(src)
	for (var/i in 1 to 3)
		if (!length(safe_turfs))
			return
		var/turf/land_turf = pick_n_take(safe_turfs)
		var/obj/effect/temp_visual/hivebrood_spawn/forecast = new(land_turf)
		forecast.create_from(death_spawn_type, our_turf, CALLBACK(src, PROC_REF(complete_spawn), land_turf))

/// Spawns a worm on the specified turf
/mob/living/basic/mining/hivelord/proc/complete_spawn(turf/spawn_turf)
	var/mob/living/brood = new death_spawn_type(spawn_turf)
	brood.faction = faction
	brood.ai_controller?.set_blackboard_key(ai_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
	brood.dir = get_dir(src, spawn_turf)

/mob/living/basic/mining/hivelord/RangedAttack(atom/atom_target, modifiers)
	spawn_brood?.Trigger(target = atom_target)

/// Attack worms spawned by the hivelord
/mob/living/basic/hivelord_brood
	name = "hivelord brood"
	desc = "Short-lived attack form of the hivelord. One isn't much of a threat, but..."
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "hivelord_brood"
	icon_living = "hivelord_brood"
	icon_dead = "hivelord_brood"
	icon_gib = "syndicate_gib"
	friendly_verb_continuous = "chirrups near"
	friendly_verb_simple = "chirrup near"
	mob_size = MOB_SIZE_SMALL
	basic_mob_flags = DEL_ON_DEATH
	pass_flags = PASSTABLE | PASSMOB
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	faction = list(FACTION_MINING)
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY
	speed = 1.5
	maxHealth = 1
	health = 1
	melee_damage_lower = 2
	melee_damage_upper = 2
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	speak_emote = list("telepathically cries")
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	obj_damage = 0
	density = FALSE
	ai_controller = /datum/ai_controller/basic_controller/simple_hostile

/mob/living/basic/hivelord_brood/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE), INNATE_TRAIT)
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/swarming)
	AddComponent(/datum/component/clickbox, icon_state = "hivelord", max_scale = INFINITY)
	addtimer(CALLBACK(src, PROC_REF(death)), 10 SECONDS)

/mob/living/basic/hivelord_brood/death(gibbed)
	if (!gibbed)
		new /obj/effect/temp_visual/hive_spawn_wither(get_turf(src), /* copy_from = */ src)
	return ..()

/// Plays a dispersing animation on hivelord and legion minions so they don't just vanish
/obj/effect/temp_visual/hive_spawn_wither
	name = "withering spawn"
	duration = 1 SECONDS

/obj/effect/temp_visual/hive_spawn_wither/Initialize(mapload, atom/copy_from)
	if (isnull(copy_from))
		. = ..()
		return INITIALIZE_HINT_QDEL
	icon = copy_from.icon
	icon_state = copy_from.icon_state
	pixel_x = copy_from.pixel_x
	pixel_y = copy_from.pixel_y
	duration = rand(0.5 SECONDS, 1 SECONDS)
	var/matrix/transformation = matrix(transform)
	transformation.Turn(rand(-70, 70))
	transformation.Scale(0.7, 0.7)
	animate(
		src,
		pixel_x = rand(-5, 5),
		pixel_y = -5,
		transform = transformation,
		color = "#44444400",
		time = duration,
		flags = ANIMATION_RELATIVE,
	)
	return ..()
