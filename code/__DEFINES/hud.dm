//HUD styles.  Index order defines how they are cycled in F12.
/// Standard hud
#define HUD_STYLE_STANDARD 1
/// Reduced hud (just hands and intent switcher)
#define HUD_STYLE_REDUCED 2
/// No hud (for screenshots)
#define HUD_STYLE_NOHUD 3

/// Used in show_hud(); Please ensure this is the same as the maximum index.
#define HUD_VERSIONS 3

// Consider these images/atoms as part of the UI/HUD (apart of the appearance_flags)
/// Used for progress bars and chat messages
#define APPEARANCE_UI_IGNORE_ALPHA (RESET_COLOR|RESET_TRANSFORM|NO_CLIENT_COLOR|RESET_ALPHA|PIXEL_SCALE|TILE_BOUND) // monkestation edit
/// Used for HUD objects
#define APPEARANCE_UI (RESET_COLOR|RESET_TRANSFORM|NO_CLIENT_COLOR|PIXEL_SCALE|TILE_BOUND) // monkestation edit

/*
	These defines specificy screen locations.  For more information, see the byond documentation on the screen_loc var.

	The short version:

	Everything is encoded as strings because apparently that's how Byond rolls.

	"1,1" is the bottom left square of the user's screen.  This aligns perfectly with the turf grid.
	"1:2,3:4" is the square (1,3) with pixel offsets (+2, +4); slightly right and slightly above the turf grid.
	Pixel offsets are used so you don't perfectly hide the turf under them, that would be crappy.

	In addition, the keywords NORTH, SOUTH, EAST, WEST and CENTER can be used to represent their respective
	screen borders. NORTH-1, for example, is the row just below the upper edge. Useful if you want your
	UI to scale with screen size.

	The size of the user's screen is defined by client.view (indirectly by world.view), in our case "15x15".
	Therefore, the top right corner (except during admin shenanigans) is at "15,15"
*/

/proc/ui_hand_position(i) //values based on old hand ui positions (CENTER:-/+16,SOUTH:5)
	switch(i)
		if(1)
			return("hudleft:3,11")
		if(2)
			return("hudleft:1,11")
		else
			return("hudleft:1,16")


/proc/ui_equip_position(mob/M)
	return ("hudleft:1,16")

/proc/ui_swaphand_position(mob/M, which = 1) //values based on old swaphand ui positions (CENTER: +/-16,SOUTH+1:5)
	return "hudleft:2,10"

//Lower left, persistent menu
#define ui_inventory "WEST:6,SOUTH:5"

//Middle left indicators
#define ui_lingchemdisplay "WEST,CENTER-1:15"
#define ui_lingstingdisplay "WEST:6,CENTER-3:11"

//Lower center, persistent menu
#define ui_sstore1 "hudleft:3,12"
#define ui_id "hudleft:3,7"
#define ui_belt "hudleft:2,7"
#define ui_back "hudleft:1,12"
#define ui_storage1 "hudleft:1,8"
#define ui_storage2 "hudleft:3,8"
#define ui_combo "CENTER+4:24,SOUTH+1:7" //combo meter for martial arts

//Lower right, persistent menu
#define ui_drop_throw "hudleft:3,5"
#define ui_above_movement "hudright:1,8"
#define ui_above_intent "hudright:1,1"
#define ui_movi "hudright:1,9"
#define ui_acti "hudleft:2,6"
#define ui_combat_toggle "hudleft:1,1"
#define ui_zonesel "hudright:1,15"
#define ui_acti_alt "EAST-1:28,SOUTH:5" //alternative intent switcher for when the interface is hidden (F12)
#define ui_crafting "hudright:1,10"
#define ui_building "hudright:1,10:16"
#define ui_language_menu "hudright:1:-16,10:16"
#define ui_navigate_menu "hudright:1,10"

//Upper-middle right (alerts)
#define ui_alert1 "hudright:1,7"
#define ui_alert2 "hudright:1,6"
#define ui_alert3 "hudright:1,5"
#define ui_alert4 "hudright:1,4"
#define ui_alert5 "hudright:1,3"

//alerts insanir'ified

//Upper left (action buttons)
#define ui_action_palette "WEST+0:23,NORTH-1:5"
#define ui_action_palette_offset(north_offset) ("WEST+0:23,NORTH-[1+north_offset]:5")

#define ui_palette_scroll "WEST+1:8,NORTH-6:28"
#define ui_palette_scroll_offset(north_offset) ("WEST+1:8,NORTH-[6+north_offset]:28")

//Middle right (status indicators)
#define ui_healthdoll "hudright:1,13"
#define ui_health "hudright:1,12"
#define ui_internal "hudright:1,13"
#define ui_mood "hudright:1,14"
#define ui_spacesuit "hudleft:2,4"
#define ui_stamina "hudright:1,11"

//Pop-up inventory
#define ui_shoes "hudleft:1,7"
#define ui_iclothing "hudleft:2,8"
#define ui_oclothing "hudleft:2,11"
#define ui_gloves "hudleft:2,9"
#define ui_glasses "hudleft:3,13"
#define ui_mask "hudleft:2,13"
#define ui_ears "hudleft:1,13"
#define ui_neck "hudleft:2,12"
#define ui_head "hudleft:2,14"

//Generic living
#define ui_living_pull "EAST-1:28,CENTER-3:15"
#define ui_living_healthdoll "EAST-1:28,CENTER-1:15"

//Monkeys
#define ui_monkey_head "CENTER-5:13,SOUTH:5"
#define ui_monkey_mask "CENTER-4:14,SOUTH:5"
#define ui_monkey_neck "CENTER-3:15,SOUTH:5"
#define ui_monkey_back "CENTER-2:16,SOUTH:5"

//Drones
#define ui_drone_drop "CENTER+1:18,SOUTH:5"
#define ui_drone_pull "CENTER+2:2,SOUTH:5"
#define ui_drone_storage "CENTER-2:14,SOUTH:5"
#define ui_drone_head "CENTER-3:14,SOUTH:5"

//Cyborgs
#define ui_borg_health "EAST-1:28,CENTER-1:15"
#define ui_borg_pull "EAST-2:26,SOUTH+1:7"
#define ui_borg_radio "EAST-1:28,SOUTH+1:7"
#define ui_borg_intents "EAST-2:26,SOUTH:5"
#define ui_borg_lamp "CENTER-3:16, SOUTH:5"
#define ui_borg_tablet "CENTER-4:16, SOUTH:5"
#define ui_inv1 "CENTER-2:16,SOUTH:5"
#define ui_inv2 "CENTER-1 :16,SOUTH:5"
#define ui_inv3 "CENTER :16,SOUTH:5"
#define ui_borg_module "CENTER+1:16,SOUTH:5"
#define ui_borg_store "CENTER+2:16,SOUTH:5"
#define ui_borg_camera "CENTER+3:21,SOUTH:5"
#define ui_borg_alerts "CENTER+4:21,SOUTH:5"
#define ui_borg_language_menu "CENTER+4:19,SOUTH+1:6"
#define ui_borg_navigate_menu "CENTER+4:19,SOUTH+1:6"

//Aliens
#define ui_alien_health "EAST,CENTER-1:15"
#define ui_alienplasmadisplay "EAST,CENTER-2:15"
#define ui_alien_queen_finder "EAST,CENTER-3:15"
#define ui_alien_storage_r "CENTER+1:18,SOUTH:5"
#define ui_alien_language_menu "EAST-4:20,SOUTH:5"
#define ui_alien_navigate_menu "EAST-4:20,SOUTH:5"

//AI
#define ui_ai_core "BOTTOM:6,RIGHT-4"
#define ui_ai_shuttle "BOTTOM:6,RIGHT-3"
#define ui_ai_announcement "BOTTOM:6,RIGHT-2"
#define ui_ai_state_laws "BOTTOM:6,RIGHT-1"
#define ui_ai_mod_int "BOTTOM:6,RIGHT"
#define ui_ai_language_menu "BOTTOM+1:8,RIGHT-1:30"

#define ui_ai_crew_monitor "BOTTOM:6,CENTER-1"
#define ui_ai_crew_manifest "BOTTOM:6,CENTER"
#define ui_ai_alerts "BOTTOM:6,CENTER+1"

#define ui_ai_view_images "BOTTOM:6,LEFT+4"
#define ui_ai_camera_list "BOTTOM:6,LEFT+3"
#define ui_ai_track_with_camera "BOTTOM:6,LEFT+2"
#define ui_ai_camera_light "BOTTOM:6,LEFT+1"
#define ui_ai_sensor "BOTTOM:6,LEFT"
#define ui_ai_multicam "BOTTOM+1:6,LEFT+1"
#define ui_ai_add_multicam "BOTTOM+1:6,LEFT"
#define ui_ai_take_picture "BOTTOM+2:6,LEFT"


//pAI
#define ui_pai_software "SOUTH:6,WEST"
#define ui_pai_shell "SOUTH:6,WEST+1"
#define ui_pai_chassis "SOUTH:6,WEST+2"
#define ui_pai_rest "SOUTH:6,WEST+3"
#define ui_pai_light "SOUTH:6,WEST+4"
#define ui_pai_state_laws "SOUTH:6,WEST+5"
#define ui_pai_crew_manifest "SOUTH:6,WEST+6"
#define ui_pai_host_monitor "SOUTH:6,WEST+7"
#define ui_pai_internal_gps "SOUTH:6,WEST+8"
#define ui_pai_mod_int "SOUTH:6,WEST+9"
#define ui_pai_newscaster "SOUTH:6,WEST+10"
#define ui_pai_take_picture "SOUTH:6,WEST+11"
#define ui_pai_view_images "SOUTH:6,WEST+12"
#define ui_pai_radio "SOUTH:6,WEST+13"
#define ui_pai_language_menu "SOUTH+1:8,WEST+12:31"
#define ui_pai_navigate_menu "SOUTH+1:8,WEST+12:31"

//Ghosts
#define ui_ghost_spawners_menu "SOUTH:6,CENTER-3:24"
#define ui_ghost_orbit "SOUTH:6,CENTER-2:24"
#define ui_ghost_reenter_corpse "SOUTH:6,CENTER-1:24"
#define ui_ghost_teleport "SOUTH:6,CENTER:24"
#define ui_ghost_pai "SOUTH: 6, CENTER+1:24"
#define ui_ghost_minigames "SOUTH: 6, CENTER+2:24"
#define ui_ghost_language_menu "SOUTH: 22, CENTER+3:8"

//Team finder

#define ui_team_finder "CENTER,CENTER"

//Blobbernauts
#define ui_blobbernaut_overmind_health "EAST-1:28,CENTER+0:19"

// Defines relating to action button positions

/// Whatever the base action datum thinks is best
#define SCRN_OBJ_DEFAULT "default"
/// Floating somewhere on the hud, not in any predefined place
#define SCRN_OBJ_FLOATING "floating"
/// In the list of buttons stored at the top of the screen
#define SCRN_OBJ_IN_LIST "list"
/// In the collapseable palette
#define SCRN_OBJ_IN_PALETTE "palette"
///Inserted first in the list
#define SCRN_OBJ_INSERT_FIRST "first"

// Plane group keys, used to group swaths of plane masters that need to appear in subwindows
/// The primary group, holds everything on the main window
#define PLANE_GROUP_MAIN "main"
/// A secondary group, used when a client views a generic window
#define PLANE_GROUP_POPUP_WINDOW(screen) "popup-[REF(screen)]"

/// The filter name for the hover outline
#define HOVER_OUTLINE_FILTER "hover_outline"
