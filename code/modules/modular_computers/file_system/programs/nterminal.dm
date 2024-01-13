/datum/computer_file/program/terminal
	filename = "NTerm"
	filedesc = "NTerminal"
	category = PROGRAM_CATEGORY_CREW
	program_icon_state = "command"
	extended_desc = "This program allows machine communication over NTNRC network"
	size = 8
	requires_ntnet = FALSE
	ui_header = "ntnrc_idle.gif"
	available_on_ntnet = TRUE
	tgui_id = "NTerminal"
	program_icon = "comment-alt"
	alert_able = FALSE
	var/list/messages = list("Welcome to the NTerminal!, have a safe and productive romp through our shitty networking system!")
	//^this is the messages viewable on the screen (remind me to add a line limiter if i havent already)
	var/session
	var/dataterm
	var/

/datum/computer_file/program/terminal/New()
	. = ..()
	session = new /datum/termsesh

/datum/termsesh


/datum/computer_file/program/terminal/ui_act(action, params)
	. = ..()
	switch(action)
		if("PRG_send")
			var/message = params["message"]
			messages.Add(message)
			if(message == "ping")
				if(istype(computer, /obj/item/modular_computer/processor))
					var/obj/item/modular_computer/processor/P = computer
					var/obj/machinery/modular_computer/M = P.machinery_computer
					M.netpacket_tx.send("D{ping}C<all>S<[M.dataterminal.trueip]>",M)





/datum/computer_file/program/terminal/ui_data(mob/user)
	var/list/data = list()
	data["messages"] = messages
	return data

/datum/termapp
	var/callapp
	var/params

/**
 * programs between these two
 */
/datum/termapp/ping
	callapp = "ping"

/**
 * programs between these two
 */
/datum/netpackettx
	var/obj/machinery/master
	var/static/regex/pack_data = regex(@"(?<=D\{)([^}]*)(?=})")
	var/static/regex/pack_client = regex(@"(?<=C<)([^>]*)(?=>)")
	var/static/regex/pack_server = regex(@"(?<=S<)([^>]*)(?=>)")
	var/static/regex/pack_param = regex(@"(?<=P\{)([^}]*)(?=})")

/**
 * Call to send a packet, sender var is not required
 */
/datum/netpackettx/proc/send(var/packet, var/obj/machinery/sender)
	if(!sender)
		sender = master
	pack_data.Find(packet)
	pack_client.Find(packet)
	pack_server.Find(packet)
	pack_param.Find(packet)
	var/client = pack_client.match
	var/server = pack_server.match
	var/param = pack_param.match
	var/data = pack_data.match
	if(!server)
		server = machine.dataterminal.trueip
	for(var/obj/machinery/M in machine.dataterminal.powernet.networknodes)
		if(M.dataterminal.trueip == client || client == "all")
			M.netpacket_rx.receive(packet, data, client, server, param)

/datum/netpacketrx
	var/obj/machinery/master
	var/static/regex/pack_data = regex(@"(?<=D\{)([^}]*)(?=})")
	var/static/regex/pack_client = regex(@"(?<=C<)([^>]*)(?=>)")
	var/static/regex/pack_server = regex(@"(?<=S<)([^>]*)(?=>)")
	var/static/regex/pack_param = regex(@"(?<=P\{)([^}]*)(?=})")

/**
 * Called when a machine receives a packet
 */
/datum/netpacketrx/proc/receive(var/packet, var/data, var/client, var/server, var/param)
	switch(data)
		if("ping")
			master.netpacket_tx.send("D{pong}C<[server]>S<[master.dataterminal.trueip]>P{[master.name]}", master)
		if("pong")
			if(istype(master, /obj/machinery/modular_computer))
				var/obj/machinery/modular_computer/mcomp = master
				var/obj/item/modular_computer/cpu = mcomp.cpu
				if(istype(cpu.active_program, /datum/computer_file/program/terminal))
					var/datum/computer_file/program/terminal/term = cpu.active_program
					term.messages.Add("[server] as [param]")
