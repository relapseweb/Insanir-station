/obj/machinery/power/dataterminal
	name = "data terminal"
	icon_state = "dataterm"
	desc = "It's an underfloor data terminal, used to draw data from the grid."
	layer = WIRE_TERMINAL_LAYER //a bit above wires
	var/obj/machinery/master
	var/itemtype = /obj/item/dataterminal

/obj/machinery/power/dataterminal/disconnect_from_network()
	. = ..()
	if(powernet)
		powernet.dataterminals.Remove(src)

/obj/machinery/power/dataterminal/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, use_alpha = TRUE)
	if(powernet)
		powernet.dataterminals.Add(src)

/obj/machinery/power/dataterminal/proc/can_data_dismantle()
	if(!master)
		return TRUE
	else
		return FALSE

/obj/machinery/power/dataterminal/should_have_node()
	return TRUE

/obj/machinery/power/dataterminal/wirecutter_act(mob/living/carbon/user, obj/item/I)
	..()
	if(!user.wearing_shock_proof_gloves() && powernet)
		electrocute_mob(user, powernet, src)
	else
		if(can_data_dismantle())
			dismantle(user, I)
			return TRUE

/obj/machinery/power/dataterminal/proc/dismantle(mob/living/user, obj/item/I)
	user.put_in_hands(new itemtype())
	powernet.dataterminals.Remove(src)
	qdel(src)

/obj/item/dataterminal
	name = "data terminal"
	icon_state = "dataterm"
	desc = "It's an underfloor data terminal, used to send data through the grid."
	var/origin_type = /obj/machinery/power/dataterminal

/obj/item/dataterminal/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	secure(user)

/obj/item/dataterminal/proc/secure(mob/living/carbon/user)
	var/turf/T = get_turf(loc)
	if(isgroundlessturf(T))
		to_chat(user, span_warning("You need ground to plant this on!"))
		return
	for(var/obj/A in T)
		if(istype(A, /obj/machinery/power/dataterminal))
			to_chat(user, span_warning("There is already a terminal here!"))
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(user, span_warning("There is already something here!"))
			return

	user.visible_message(span_notice("[user] rights \the [src.name]."), span_notice("You right \the [name]."))
	var/obj/machinery/power/dataterminal/D = new origin_type(get_turf(loc))
	qdel(src)

/obj/machinery/power/dataterminal/proc/register_machine(var/obj/machinery/machine)
	machine.dataterminal = src
	if(powernet)
		powernet.networknodes.Add(machine)
	master = machine

/obj/machinery/power/dataterminal/proc/unregister_machine(var/obj/machinery/machine)
	machine.dataterminal = null
	if(powernet)
		powernet.networknodes.Remove(machine)
	master = null
///////////////////////////////////////////
//editing of normal stuff past this point//
///////////////////////////////////////////
/datum/powernet
	var/list/networknodes
	var/list/dataterminals

/obj/machinery/wrench_act(mob/user, obj/item/wrench, time)
	if(anchored)
		var/turf/T = get_turf(loc)
		if(anchored && !dataterminal)
			for(var/obj/A in T)
				if(istype(A,/obj/machinery/power/dataterminal))
					dataterminal = A
					dataterminal.register_machine(src)
		else
			dataterminal.unregister_machine()

/obj/machinery/power/dataterminal/proc/test()
	var/turf/T = get_turf(loc)
	for(var/obj/A in T)
		if(istype(A,/obj/machinery))
			return "works"
		else
			return "dosent"

/obj/machinery/on_construction(mob/user)
	. = ..()
	var/turf/T = get_turf(loc)
	for(var/obj/A in T)
		if(istype(A,/obj/machinery/power/dataterminal)  && !istype(src, /obj/machinery/power/dataterminal))
			dataterminal = A
			dataterminal.register_machine(src)

/obj/machinery/on_deconstruction()
	. = ..()
	if(dataterminal)
		dataterminal.unregister_machine(src)

/obj/machinery/LateInitialize()
	. = ..()
	var/turf/T = get_turf(loc)
	for(var/obj/A in T)
		if(istype(A,/obj/machinery/power/dataterminal) && !istype(src, /obj/machinery/power/dataterminal))
			dataterminal = A
			dataterminal.register_machine(src)


/obj/machinery/proc/test_terminal()
	var/turf/T = get_turf(loc)
	for(var/obj/A in T)
		if(istype(A,/obj/machinery/power/dataterminal))
			return "works"

/obj/machinery
	var/obj/machinery/power/dataterminal/dataterminal
	var/IPnumber
