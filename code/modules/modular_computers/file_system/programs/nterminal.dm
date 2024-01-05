/datum/computer_file/program/terminal
	filename = "NTerm"
	filedesc = "terminal"
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
	var/session
	var/dataterm

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
					if(M.dataterminal && M.dataterminal.powernet)
						var/obj/machinery/D
						for(D in M.dataterminal.powernet.networknodes)
							messages.Add(D.IPnumber)





/datum/computer_file/program/terminal/ui_data(mob/user)
	var/list/data = list()
	data["messages"] = messages
	return data

/datum/termapp
	var/callapp

/datum/termapp/ping
	callapp = "ping"

/datum/netpacket
	var/packet
	var/static/regex/pack_data = regex(@"(?<=D\{)([^}]*)(?=})", "g")
	var/static/regex/pack_client = regex(@"(?<=C<)([^>]*)(?=>)", "g")
	var/static/regex/pack_server = regex(@"(?<=S<)([^>]*)(?=>)", "g")
	var/static/regex/pack_param = regex(@"(?<=P\{)([^}]*)(?=})", "g")

/datum/netpacket/proc/send()

	var/list/data = pack_data.Find(packet)
	var/list/client = pack_client.Find(packet)
	var/list/server = pack_server.Find(packet)
	var/list/param = pack_param.Find(packet)
