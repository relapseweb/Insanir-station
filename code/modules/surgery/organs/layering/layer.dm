/obj/item/organ/layer
	name = "layer"
	icon_state = "liver"
	var/pain = 0
	var/hardness = 10
	var/thickness = 1
	var/penetrated = FALSE
	var/obj/item/organ/layer/underlayer

/obj/item/organ/layer/proc/damage(var/force, var/penetration)
	if(force * penetration > hardthiceval() && underlayer && !penetrated)
		underlayer.damage(force - hardness, penetration - thickness)
	damage += force
	pain += force * penetration

/obj/item/organ/layer/proc/hardthiceval()
	var/armor = hardness * thickness
	return armor
