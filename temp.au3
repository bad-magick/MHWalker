#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=e:\mhwalker\fmain.kxf
$fMain = GUICreate("MHWalker by [MPGH]'s l2noob2", 546, 499, 194, 122)
$Tab1 = GUICtrlCreateTab(8, 7, 529, 449)
$TabSheet1 = GUICtrlCreateTabItem("Info")
$Label41 = GUICtrlCreateLabel("Welcome to MHWalker.", 16, 39, 118, 17)
$Label42 = GUICtrlCreateLabel("Don't forget to check the README.txt file if you have any questions.", 16, 55, 327, 17)
$picDonate = GUICtrlCreatePic("C:\Users\Den\Desktop\New Shit\assets\PayPal.gif", 216, 423, 92, 26)
$Label46 = GUICtrlCreateLabel("This version supports 52 dungeons. See the Dungeons tab for more details.", 16, 79, 359, 17)
$Label58 = GUICtrlCreateLabel("Label58", 16, 103, 42, 17)
$Label59 = GUICtrlCreateLabel("Label59", 16, 119, 49, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$Label60 = GUICtrlCreateLabel("Label60", 16, 135, 49, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$ReadMe = GUICtrlCreateEdit("", 16, 159, 513, 257, BitOR($ES_AUTOVSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "ReadMe")
GUICtrlSetFont(-1, 8, 400, 0, "Lucida Console")
$TabSheet2 = GUICtrlCreateTabItem("Hotkeys")
$txtStart = GUICtrlCreateInput("txtStart", 80, 39, 89, 21)
$txtPause = GUICtrlCreateInput("txtPause", 80, 63, 89, 21)
$txtEnd = GUICtrlCreateInput("txtEnd", 80, 87, 89, 21)
$txtLegend = GUICtrlCreateInput("txtLegend", 80, 111, 89, 21)
$cmdDefault = GUICtrlCreateButton("Set Default", 72, 431, 97, 17)
$Label17 = GUICtrlCreateLabel("Enables/Disables the bot.", 176, 39, 126, 17)
$Label18 = GUICtrlCreateLabel("Pauses/Resumes the bot.", 176, 63, 127, 17)
$Label19 = GUICtrlCreateLabel("End the bot program.", 176, 87, 103, 17)
$Label20 = GUICtrlCreateLabel("Displays the key legend in the middle of the screen.", 176, 111, 246, 17)
$Label21 = GUICtrlCreateLabel("Start/Stop", 24, 39, 53, 17)
$Label22 = GUICtrlCreateLabel("Pause", 40, 63, 34, 17)
$Label23 = GUICtrlCreateLabel("Exit", 48, 87, 21, 17)
$Label24 = GUICtrlCreateLabel("Legend", 32, 111, 40, 17)
$Input1 = GUICtrlCreateInput("txtPauseAfterRun", 80, 135, 89, 21)
$Label50 = GUICtrlCreateLabel("PauseAfter", 16, 135, 56, 17)
$Label51 = GUICtrlCreateLabel("Pauses the bot after the current run is complete.", 176, 135, 230, 17)
$TabSheet3 = GUICtrlCreateTabItem("Binds 1")
$txtGod = GUICtrlCreateInput("txtGod", 72, 39, 89, 21)
$txtOHK = GUICtrlCreateInput("txtOHK", 72, 63, 89, 21)
$txtSmall = GUICtrlCreateInput("txtSmall", 72, 87, 89, 21)
$txtLarge = GUICtrlCreateInput("txtLarge", 72, 111, 89, 21)
$txtNormal = GUICtrlCreateInput("txtNormal", 72, 135, 89, 21)
$txtTrans1 = GUICtrlCreateInput("txtTrans1", 72, 159, 89, 21)
$txtTrans2 = GUICtrlCreateInput("txtTrans2", 72, 183, 89, 21)
$txtTenticle = GUICtrlCreateInput("txtTenticle", 72, 207, 89, 21)
$txtTimescale = GUICtrlCreateInput("txtTimescale", 72, 231, 89, 21)
$txtSkipMap = GUICtrlCreateInput("txtSkipMap", 72, 255, 89, 21)
$txtSpears = GUICtrlCreateInput("txtSpears", 72, 279, 89, 21)
$txtShipList = GUICtrlCreateInput("txtShipList", 72, 303, 89, 21)
$txtSendChange = GUICtrlCreateInput("txtSendChange", 72, 327, 89, 21)
$txtSendStart = GUICtrlCreateInput("txtSendStart", 72, 351, 89, 21)
$txtColhan = GUICtrlCreateInput("txtColhan", 72, 375, 89, 21)
$txtRocheste = GUICtrlCreateInput("txtRocheste", 72, 399, 89, 21)
$Label1 = GUICtrlCreateLabel("""god""", 176, 39, 32, 17)
$Label2 = GUICtrlCreateLabel("""ohk""", 176, 63, 32, 17)
$Label3 = GUICtrlCreateLabel("""cc_change_figure_height 0.1""", 176, 87, 153, 17)
$Label4 = GUICtrlCreateLabel("""cc_change_figure_height 1500""", 176, 111, 162, 17)
$Label5 = GUICtrlCreateLabel("""cc_change_figure_height 1""", 176, 135, 144, 17)
$Label6 = GUICtrlCreateLabel("""plr_play_overlay_sequence paladin_transformation_begin_1""", 176, 159, 296, 17)
$Label7 = GUICtrlCreateLabel("""plr_play_overlay_sequence paladin_transformation_begin_2""", 176, 183, 296, 17)
$Label8 = GUICtrlCreateLabel("""plr_play_overlay_sequence paladin_2_skill_tentacle""", 176, 207, 259, 17)
$Label9 = GUICtrlCreateLabel("""incrementvar host_timescale 1 5 4""", 176, 231, 175, 17)
$Label10 = GUICtrlCreateLabel("""changemap_to_next_random_sector""", 176, 255, 187, 17)
$Label11 = GUICtrlCreateLabel("""cc_set_sub_weapon javelin_lvl2 999""", 176, 279, 189, 17)
$Label12 = GUICtrlCreateLabel("""cc_shiplist_ui""", 176, 303, 77, 17)
$Label13 = GUICtrlCreateLabel("""cc_change_start_game_message""", 176, 327, 174, 17)
$Label14 = GUICtrlCreateLabel("""cc_send_start_game_message""", 176, 351, 161, 17)
$Label15 = GUICtrlCreateLabel("""cc_enter_colhen_from_rochest""", 176, 375, 161, 17)
$Label16 = GUICtrlCreateLabel("""cc_enter_rochest_from_colhen""", 176, 399, 161, 17)
$cmdPie = GUICtrlCreateButton("Set PieBinds 2.1", 144, 431, 97, 17)
$cmdSin = GUICtrlCreateButton("Set SinBot 2.x", 248, 431, 97, 17)
$Label25 = GUICtrlCreateLabel("God", 16, 39, 24, 17)
$Label26 = GUICtrlCreateLabel("OHK", 16, 63, 27, 17)
$Label27 = GUICtrlCreateLabel("Small", 16, 87, 29, 17)
$Label28 = GUICtrlCreateLabel("Large", 16, 111, 31, 17)
$Label29 = GUICtrlCreateLabel("Normal", 16, 135, 37, 17)
$Label30 = GUICtrlCreateLabel("Paladin 1", 16, 159, 48, 17)
$Label31 = GUICtrlCreateLabel("Paladin 2", 16, 183, 48, 17)
$Label32 = GUICtrlCreateLabel("Tenticle", 16, 207, 42, 17)
$Label33 = GUICtrlCreateLabel("Timescale", 16, 231, 52, 17)
$Label34 = GUICtrlCreateLabel("Skip Map", 16, 255, 49, 17)
$Label35 = GUICtrlCreateLabel("Spears", 16, 279, 37, 17)
$Label36 = GUICtrlCreateLabel("Ship List", 16, 303, 44, 17)
$Label37 = GUICtrlCreateLabel("LB Bypass", 16, 327, 54, 17)
$Label38 = GUICtrlCreateLabel("CS Bypass", 16, 351, 55, 17)
$Label39 = GUICtrlCreateLabel("Colhan", 16, 375, 37, 17)
$Label40 = GUICtrlCreateLabel("Rocheste", 16, 399, 50, 17)
$cmdMHWalker = GUICtrlCreateButton("Set MHWalker", 40, 431, 99, 17)
$TabSheet4 = GUICtrlCreateTabItem("Delays")
GUICtrlSetState(-1,$GUI_SHOW)
$txtTownLag = GUICtrlCreateInput("txtTownLag", 72, 39, 89, 21)
$Label47 = GUICtrlCreateLabel("Town Lag", 16, 39, 52, 17)
$Label48 = GUICtrlCreateLabel("On replay, empty battle clear appears while in town. In millisecs.", 168, 39, 302, 17)
$Button1 = GUICtrlCreateButton("Set Default", 72, 431, 97, 17)
$txtDungeonComplete = GUICtrlCreateInput("txtDungeonComplete", 72, 63, 89, 21)
$Label52 = GUICtrlCreateLabel("Time Limit", 16, 63, 51, 17)
$Label53 = GUICtrlCreateLabel("Limits how long a run will take before it resets the dungeon.", 168, 63, 282, 17)
$TabSheet5 = GUICtrlCreateTabItem("Program Options")
$chkLogFile = GUICtrlCreateCheckbox("Write output to log file.", 24, 407, 129, 17)
$cmdDefaultOptions = GUICtrlCreateButton("Set Default", 72, 431, 97, 17)
$chkKeyboard = GUICtrlCreateCheckbox("Use Keyboard Mode (clearing this will assume Mouse Mode)", 24, 39, 305, 17)
$chkEU = GUICtrlCreateCheckbox("Vindictus EU (clearing this assumes NA)", 24, 71, 209, 17)
$txtLogSize = GUICtrlCreateInput("txtLogSize", 104, 391, 41, 21)
$Label54 = GUICtrlCreateLabel("On-Screen Size", 24, 391, 78, 17)
$Label55 = GUICtrlCreateLabel("Number of lines to display (too large a number is bad).", 152, 391, 255, 17)
$chkDeleteLogFile = GUICtrlCreateCheckbox("Delete Log File on Startup", 160, 407, 145, 17)
$chkPauseOnLoseFocus = GUICtrlCreateCheckbox("Automatically Pause when Vindictus window loses focus", 24, 87, 289, 17)
$Label43 = GUICtrlCreateLabel("host_timescale Max Value", 24, 119, 127, 17)
$txtHostTimeScale = GUICtrlCreateInput("txtHostTimeScale", 152, 119, 33, 21)
$Label44 = GUICtrlCreateLabel("(MHWalker/SinBot binds = 5, PieBinds = 6)", 192, 119, 208, 17)
$chkNonWindow = GUICtrlCreateCheckbox("Allow Non-Active Window Commands (Potentially unstable, use at your own rick)", 24, 103, 449, 17)
$chkSlowMouse = GUICtrlCreateCheckbox("Slow Mouse Mode", 24, 55, 113, 17)
$chkWebServer = GUICtrlCreateCheckbox("View log remotely via built in webserver on port", 24, 367, 241, 17)
$txtWebServerPort = GUICtrlCreateInput("", 266, 367, 57, 21)
$Label73 = GUICtrlCreateLabel(".", 324, 367, 7, 17)
$TabSheet6 = GUICtrlCreateTabItem("Dungeons")
$Label45 = GUICtrlCreateLabel("Available Dungeons:", 16, 38, 102, 17)
$lvwDungeons = GUICtrlCreateListView("|Dungeon Name", 16, 55, 511, 345, BitOR($GUI_SS_DEFAULT_LISTVIEW,$WS_VSCROLL), BitOR($WS_EX_CLIENTEDGE,$LVS_EX_CHECKBOXES))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 30)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 390)
$Label61 = GUICtrlCreateLabel("Checked dungeons will use ""host_timescale"". Unchecked dungeons will not.", 16, 407, 367, 17)
$Button2 = GUICtrlCreateButton("Set Default", 72, 431, 97, 17)
$Label62 = GUICtrlCreateLabel("[*] Indicates VIP Edition required.", 368, 38, 159, 17)
$TabSheet7 = GUICtrlCreateTabItem("Auto-Sell")
$chkAutoSell = GUICtrlCreateCheckbox("Enable Auto-Selling to NPC every", 24, 47, 177, 17)
$chkNoScrolls = GUICtrlCreateCheckbox("Do not sell Enchant Scrolls", 24, 199, 153, 17)
$chkChest2 = GUICtrlCreateCheckbox("Chest 2", 40, 63, 97, 17)
$chkChest3 = GUICtrlCreateCheckbox("Chest 3", 40, 79, 97, 17)
$chkChest4 = GUICtrlCreateCheckbox("Chest 4", 40, 95, 97, 17)
$chkChest5 = GUICtrlCreateCheckbox("Chest 5", 40, 111, 97, 17)
$chkChest6 = GUICtrlCreateCheckbox("Chest 6", 40, 127, 97, 17)
$chkChest7 = GUICtrlCreateCheckbox("Chest 7", 40, 143, 97, 17)
$chkChest8 = GUICtrlCreateCheckbox("Chest 8", 40, 159, 97, 17)
$chkChest9 = GUICtrlCreateCheckbox("Chest 9", 40, 175, 97, 17)
$txtSellRuns = GUICtrlCreateInput("", 208, 47, 57, 21)
$Label68 = GUICtrlCreateLabel("runs.", 272, 47, 27, 17)
$chkNoEmpowered = GUICtrlCreateCheckbox("Do not sell Empowered Enhancement Stones", 24, 215, 233, 17)
$Button3 = GUICtrlCreateButton("Set Default", 72, 431, 97, 17)
$TabSheet8 = GUICtrlCreateTabItem("Binds 2")
$Label74 = GUICtrlCreateLabel("Mines", 16, 39, 32, 17)
$Input4 = GUICtrlCreateInput("txtMines", 72, 39, 89, 21)
$Label75 = GUICtrlCreateLabel("""cc_set_sub_weapon mining_bomb 999""", 176, 39, 199, 17)
$txtPickup = GUICtrlCreateInput("txtPickup", 72, 63, 89, 21)
$Label76 = GUICtrlCreateLabel("Pickup Dis", 16, 63, 55, 17)
$Label77 = GUICtrlCreateLabel("""incrementvar plr_search_evil_core_distance 500 1700 400""", 176, 63, 291, 17)
$Input6 = GUICtrlCreateInput("txtReload", 72, 88, 89, 21)
$Label78 = GUICtrlCreateLabel("Reload", 16, 87, 38, 17)
$Label79 = GUICtrlCreateLabel("""changemap_to_current_random_sector""", 176, 88, 200, 17)
$txtMailbox = GUICtrlCreateInput("txtMailbox", 72, 112, 89, 21)
$txtShop = GUICtrlCreateInput("txtShop", 72, 136, 89, 21)
$Input13 = GUICtrlCreateInput("txtCloseWin", 72, 160, 89, 21)
$Input14 = GUICtrlCreateInput("txtCloseAB", 72, 184, 89, 21)
$Label49 = GUICtrlCreateLabel("Mailbox", 16, 112, 40, 17)
$Label56 = GUICtrlCreateLabel("Shop", 16, 136, 29, 17)
$Label57 = GUICtrlCreateLabel("Close Win", 16, 160, 52, 17)
$Label63 = GUICtrlCreateLabel("Close AB", 16, 184, 47, 17)
$Label64 = GUICtrlCreateLabel("""cc_mailbox_ui""", 176, 112, 81, 17)
$Label65 = GUICtrlCreateLabel("""show_mini_shop""", 176, 136, 92, 17)
$Label66 = GUICtrlCreateLabel("""close_last_dialog""", 176, 160, 95, 17)
$Label67 = GUICtrlCreateLabel("""close_alchemy_box""", 176, 184, 107, 17)

$TabSheet9 = GUICtrlCreateTabItem("Bot Options")
$Checkbox1 = GUICtrlCreateCheckbox("Spend AP every", 25, 42, 97, 17)
$Input5 = GUICtrlCreateInput("txtAPRuns", 123, 42, 41, 21)
$Label80 = GUICtrlCreateLabel("runs.", 169, 42, 27, 17)
$Label81 = GUICtrlCreateLabel("Max Runs", 25, 66, 52, 17)
$Input7 = GUICtrlCreateInput("txtMaxRuns", 81, 66, 65, 21)
$Label82 = GUICtrlCreateLabel("When this number is reached, the bot will deactivate. (0 = forever)", 153, 66, 314, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Close Battle Cleared window (clearing will press Replay on Battle Cleared)", 25, 90, 505, 17)
$Checkbox4 = GUICtrlCreateCheckbox("Speed-Up Battle Cleared Window Animation (slower computers/VMs may have issues)", 25, 106, 505, 17)
$Checkbox5 = GUICtrlCreateCheckbox("Do not use ""host_timescale"" to speed up boss cutscenes", 25, 122, 505, 17)
$Label83 = GUICtrlCreateLabel("Login Info", 25, 235, 51, 17)
$Label84 = GUICtrlCreateLabel("User ID:", 81, 227, 43, 17)
$Label85 = GUICtrlCreateLabel("Server:", 81, 251, 38, 17)
$Input8 = GUICtrlCreateInput("txtUserName", 129, 227, 113, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$Combo2 = GUICtrlCreateCombo("", 121, 251, 81, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "No Selection|East|West")
$Label86 = GUICtrlCreateLabel("Password:", 249, 227, 53, 17)
$Label87 = GUICtrlCreateLabel("Character:", 209, 251, 53, 17)
$Input9 = GUICtrlCreateInput("txtPassword", 305, 227, 113, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$Combo3 = GUICtrlCreateCombo("", 265, 251, 65, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "1|2|3|4|5|6|7")
$Checkbox6 = GUICtrlCreateCheckbox("Change channel when in town to random channel between", 25, 162, 297, 17)
$Input10 = GUICtrlCreateInput("", 323, 162, 41, 21)
$Label88 = GUICtrlCreateLabel(" and", 365, 162, 25, 17)
$Input11 = GUICtrlCreateInput("", 393, 162, 41, 21)
$Label89 = GUICtrlCreateLabel(" .", 434, 162, 10, 17)
$Label90 = GUICtrlCreateLabel("When MHWalker deactivates itself, logout after", 25, 186, 228, 17)
$Input12 = GUICtrlCreateInput("5", 257, 186, 41, 21)
$Label91 = GUICtrlCreateLabel("minutes. (0 = never)", 300, 186, 97, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Use ""host_timescale"" hack to speed up dungeon (Can cause severe lag in some dungeons)", 25, 138, 505, 17)
$chkUnknownLogout = GUICtrlCreateCheckbox("When the bot is unable to identify location, logout and log back in. (Requires login info)", 24, 208, 505, 17)


GUICtrlCreateTabItem("")
$cmdSave = GUICtrlCreateButton("Save Settings", 112, 464, 97, 25)
$cmdStart = GUICtrlCreateButton("Start", 216, 464, 97, 25)
$cmdClose = GUICtrlCreateButton("Close", 320, 464, 97, 25)
Dim $fMain_AccelTable[2][2] = [["^s", $cmdSave],["^x", $cmdClose]]
GUISetAccelerators($fMain_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $fMain
		Case $picDonate
		Case $txtStart
		Case $txtPause
		Case $txtEnd
		Case $txtLegend
		Case $cmdDefault
		Case $txtGod
		Case $txtOHK
		Case $txtSmall
		Case $txtLarge
		Case $txtNormal
		Case $txtTrans1
		Case $txtTrans2
		Case $txtTenticle
		Case $txtTimescale
		Case $txtSkipMap
		Case $txtSpears
		Case $txtShipList
		Case $txtSendChange
		Case $txtSendStart
		Case $txtColhan
		Case $txtRocheste
		Case $cmdPie
		Case $cmdSin
		Case $cmdMHWalker
		Case $Button1
		Case $cmdDefaultOptions
		Case $Button2
		Case $Button3
		Case $Input4
		Case $cmdSave
		Case $cmdStart
		Case $cmdClose
	EndSwitch
WEnd
