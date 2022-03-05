#include-once
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiComboBox.au3>
#include <GuiComboBoxEx.au3>
#include <ComboConstants.au3>
#Include <Array.au3>
#include "Settings.au3"
#include "Donator.au3"
#include "EU.au3"
#include "Console.au3"
#include "Utils.au3"

Global $ReadMeText = ""

ReadSettings()
$ReadMeText = GetReadMe()
If Not IsOnScreen($WindowX, $WindowY) Then
	$WindowX = 100
	$WindowY = 100
EndIf
#region ### START Koda GUI section ### Form=c:\users\den\desktop\new shit\fmain.kxf
Dim $fMain = GUICreate("MHWalker", 544, 499, $WindowX, $WindowY)
GUISetIcon(@TempDir & "\MHWalker.ico")
Dim $Tab1 = GUICtrlCreateTab(8, 8, 529, 449)
Dim $TabSheet1 = GUICtrlCreateTabItem("Info")
Dim $Label41 = GUICtrlCreateLabel("Welcome to MHWalker.", 16, 40, 118, 17)
Dim $Label42 = GUICtrlCreateLabel("Don't forget to check the README.txt file if you have any questions.", 16, 56, 327, 17)
Dim $lblNumDungeons = GUICtrlCreateLabel("", 16, 80, 359, 17)
Dim $Label43 = GUICtrlCreateLabel("Registration Info", 16, 104, 327, 17)
Dim $lblRegisterName = GUICtrlCreateLabel("Name: ", 16, 120, 327, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Dim $lblRegisterEmail = GUICtrlCreateLabel("Email: ", 16, 136, 327, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Dim $lblSince = GUICtrlCreateLabel("Donated on: " & $DonatorDate, 264, 119, 200, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Dim $lblRegisterMsg = GUICtrlCreateLabel("", 16, 152, 327, 17)
Dim $ReadMe = GUICtrlCreateEdit($ReadMeText, 16, 168, 513, 249, BitOR($ES_AUTOVSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetFont(-1, 8, 400, 0, "Lucida Console")

Dim $picDonate = GUICtrlCreatePic(@TempDir & "\PayPal.gif", 227, 424, 92, 26)
Dim $TabSheet2 = GUICtrlCreateTabItem("Hotkeys")
Dim $txtStart = GUICtrlCreateInput($KeyStart, 72, 40, 89, 21)
Dim $txtPause = GUICtrlCreateInput($KeyPause, 72, 64, 89, 21)
Dim $txtEnd = GUICtrlCreateInput($KeyShutDown, 72, 88, 89, 21)
Dim $txtLegend = GUICtrlCreateInput($KeyLegend, 72, 112, 89, 21)
Dim $txtPauseAfterRun = GUICtrlCreateInput($KeyPauseAfterRun, 72, 136, 89, 21)
Dim $cmdDefault = GUICtrlCreateButton("Set Default", 72, 432, 97, 17)
Dim $Label17 = GUICtrlCreateLabel("Enables/Disables the bot.", 168, 40, 126, 17)
Dim $Label18 = GUICtrlCreateLabel("Pauses/Resumes the bot.", 168, 64, 127, 17)
Dim $Label19 = GUICtrlCreateLabel("End the bot program.", 168, 88, 103, 17)
Dim $Label20 = GUICtrlCreateLabel("Displays the Additional Tools menu.", 168, 112, 246, 17)
Dim $Label51 = GUICtrlCreateLabel("Pauses the bot after the current run is complete.", 168, 136, 230, 17)
Dim $Label21 = GUICtrlCreateLabel("Start/Stop", 16, 40, 53, 17)
Dim $Label22 = GUICtrlCreateLabel("Pause", 32, 64, 34, 17)
Dim $Label23 = GUICtrlCreateLabel("Exit", 40, 88, 21, 17)
Dim $Label24 = GUICtrlCreateLabel("Tools", 24, 112, 40, 17)
Dim $Label50 = GUICtrlCreateLabel("PauseAfter", 16, 136, 56, 17)
Dim $TabSheet3 = GUICtrlCreateTabItem("Binds 1")
Dim $txtGod = GUICtrlCreateInput($BindGod, 72, 40, 89, 21)
Dim $txtOHK = GUICtrlCreateInput($BindOHK, 72, 64, 89, 21)
Dim $txtSmall = GUICtrlCreateInput($BindSmall, 72, 88, 89, 21)
Dim $txtLarge = GUICtrlCreateInput($BindLarge, 72, 112, 89, 21)
Dim $txtNormal = GUICtrlCreateInput($BindNormal, 72, 136, 89, 21)
Dim $txtTrans1 = GUICtrlCreateInput($BindTrans1, 72, 160, 89, 21)
Dim $txtNuke = GUICtrlCreateInput($BindNuke, 72, 184, 89, 21)
;Dim $txtTenticle = GUICtrlCreateInput($BindTenticle, 72, 208, 89, 21)
If $IsPremium Then Dim $txtKill1 = GUICtrlCreateInput($BindKill1, 72, 208, 89, 21)
Dim $txtTimescale = GUICtrlCreateInput($BindTimescale, 72, 232, 89, 21)
Dim $txtSkipMap = GUICtrlCreateInput($BindSkipMap, 72, 256, 89, 21)
Dim $txtSpears = GUICtrlCreateInput($BindSpears, 72, 280, 89, 21)
Dim $txtShipList = GUICtrlCreateInput($BindShipList, 72, 304, 89, 21)
Dim $txtSendChange = GUICtrlCreateInput($BindLBBypass, 72, 328, 89, 21)
Dim $txtSendStart = GUICtrlCreateInput($BindCSBypass, 72, 352, 89, 21)
Dim $txtColhan = GUICtrlCreateInput($BindColhan, 72, 376, 89, 21)
Dim $txtRocheste = GUICtrlCreateInput($BindRocheste, 72, 400, 89, 21)
Dim $Label1 = GUICtrlCreateLabel("""god""", 176, 40, 32, 17)
Dim $Label2 = GUICtrlCreateLabel("""ohk""", 176, 64, 32, 17)
Dim $Label3 = GUICtrlCreateLabel("""cc_change_figure_height 0.1""", 176, 88, 153, 17)
Dim $Label4 = GUICtrlCreateLabel("""cc_change_figure_height 1500""", 176, 112, 162, 17)
Dim $Label5 = GUICtrlCreateLabel("""cc_change_figure_height 1""", 176, 136, 144, 17)
Dim $Label6 = GUICtrlCreateLabel("""plr_play_overlay_sequence paladin_transformation_begin_1""", 176, 160, 296, 17)
Dim $Label7 = GUICtrlCreateLabel("""nuke""", 176, 184, 296, 17)
;Dim $Label8 = GUICtrlCreateLabel("""plr_play_overlay_sequence paladin_2_skill_tentacle""", 176, 208, 289, 17)
If $IsPremium Then Dim $Label8 = GUICtrlCreateLabel("""kill1""", 176, 208, 289, 17)
Dim $Label9 = GUICtrlCreateLabel("""incrementvar host_timescale 1 (x) (y)""", 176, 232, 296, 17)
Dim $Label10 = GUICtrlCreateLabel("""changemap_to_next_random_sector""", 176, 256, 187, 17)
Dim $Label11 = GUICtrlCreateLabel("""cc_set_sub_weapon javelin_lvl2 999""", 176, 280, 189, 17)
Dim $Label12 = GUICtrlCreateLabel("""cc_shiplist_ui""", 176, 304, 77, 17)
Dim $Label13 = GUICtrlCreateLabel("""cc_change_start_game_message""", 176, 328, 174, 17)
Dim $Label14 = GUICtrlCreateLabel("""cc_send_start_game_message""", 176, 352, 161, 17)
Dim $Label15 = GUICtrlCreateLabel("""cc_enter_colhen_from_rochest""", 176, 376, 161, 17)
Dim $Label16 = GUICtrlCreateLabel("""cc_enter_rochest_from_colhen""", 176, 400, 161, 17)
Dim $cmdMHWalker = GUICtrlCreateButton("Set MHWalker", 40, 432, 99, 17)
;Dim $cmdPie = GUICtrlCreateButton("Set PieBinds 2.1", 144, 432, 97, 17)
;Dim $cmdSin = GUICtrlCreateButton("Set SinBot 2.x", 248, 432, 97, 17)
Dim $Label25 = GUICtrlCreateLabel("God", 16, 40, 24, 17)
Dim $Label26 = GUICtrlCreateLabel("OHK", 16, 64, 27, 17)
Dim $Label27 = GUICtrlCreateLabel("Small", 16, 88, 29, 17)
Dim $Label28 = GUICtrlCreateLabel("Large", 16, 112, 31, 17)
Dim $Label29 = GUICtrlCreateLabel("Normal", 16, 136, 37, 17)
Dim $Label30 = GUICtrlCreateLabel("Paladin 1", 16, 160, 48, 17)
Dim $Label31 = GUICtrlCreateLabel("Nuke", 16, 184, 48, 17)
;Dim $Label32 = GUICtrlCreateLabel("Tentacle", 16, 208, 42, 17)
If $IsPremium Then Dim $Label32 = GUICtrlCreateLabel("Kill1", 16, 208, 42, 17)
Dim $Label33 = GUICtrlCreateLabel("Timescale", 16, 232, 52, 17)
Dim $Label34 = GUICtrlCreateLabel("Skip Map", 16, 256, 49, 17)
Dim $Label35 = GUICtrlCreateLabel("Spears", 16, 280, 37, 17)
Dim $Label36 = GUICtrlCreateLabel("Ship List", 16, 304, 44, 17)
Dim $Label37 = GUICtrlCreateLabel("LB Bypass", 16, 328, 54, 17)
Dim $Label38 = GUICtrlCreateLabel("CS Bypass", 16, 352, 55, 17)
Dim $Label39 = GUICtrlCreateLabel("Colhan", 16, 376, 37, 17)
Dim $Label40 = GUICtrlCreateLabel("Rocheste", 16, 400, 50, 17)
Dim $TabSheet8 = GUICtrlCreateTabItem("Binds 2")
Dim $Label74 = GUICtrlCreateLabel("Mines", 16, 39, 32, 17)
Dim $txtMines = GUICtrlCreateInput($BindMineBombs, 72, 39, 89, 21)
Dim $Label75 = GUICtrlCreateLabel("""cc_set_sub_weapon mining_bomb 999""", 176, 39, 199, 17)
Dim $txtPickup = GUICtrlCreateInput($BindPickupDistance, 72, 63, 89, 21)
Dim $Label76 = GUICtrlCreateLabel("Pickup Dis", 16, 63, 55, 17)
Dim $Label77 = GUICtrlCreateLabel("""incrementvar plr_search_evil_core_distance 500 1700 400""", 176, 63, 291, 17)
Dim $txtReload = GUICtrlCreateInput($BindReloadMap, 72, 88, 89, 21)
Dim $Label78 = GUICtrlCreateLabel("Reload", 16, 87, 38, 17)
Dim $Label79 = GUICtrlCreateLabel("""changemap_to_current_random_sector""", 176, 87, 200, 17)
Dim $txtMailbox = GUICtrlCreateInput($BindMailbox, 72, 112, 89, 21)
Dim $txtShop = GUICtrlCreateInput($BindShop, 72, 136, 89, 21)
Dim $txtCloseWindow = GUICtrlCreateInput($BindCloseWindow, 72, 160, 89, 21)
Dim $txtCloseAlchemy = GUICtrlCreateInput($BindCloseAlchemy, 72, 184, 89, 21)
Dim $Label49 = GUICtrlCreateLabel("Mailbox", 16, 112, 40, 17)
Dim $Label56 = GUICtrlCreateLabel("Shop", 16, 136, 29, 17)
Dim $Label57 = GUICtrlCreateLabel("Close Win", 16, 160, 52, 17)
Dim $Label63 = GUICtrlCreateLabel("Close AB", 16, 184, 47, 17)
Dim $Label64 = GUICtrlCreateLabel("""cc_mailbox_ui""", 176, 112, 81, 17)
Dim $Label65 = GUICtrlCreateLabel("""show_mini_shop""", 176, 136, 92, 17)
Dim $Label66 = GUICtrlCreateLabel("""close_last_dialog""", 176, 160, 95, 17)
Dim $Label67 = GUICtrlCreateLabel("""close_alchemy_box""", 176, 184, 107, 17)

Dim $TabSheet4 = GUICtrlCreateTabItem("Delays")
Dim $txtTownLag = GUICtrlCreateInput($DelayToTownLag, 72, 40, 89, 21)
Dim $Label47 = GUICtrlCreateLabel("Town Lag", 16, 40, 52, 17)
Dim $Label48 = GUICtrlCreateLabel("On replay, empty battle clear appears while in town. In millisecs.", 168, 40, 302, 17)
Dim $txtDungeonComplete = GUICtrlCreateInput($DelayDungeonComplete, 72, 64, 89, 21)
Dim $Label52 = GUICtrlCreateLabel("Time Limit", 16, 64, 51, 17)
Dim $Label53 = GUICtrlCreateLabel("Limits how long a run can take before it resets the dungeon.", 168, 64, 282, 17)
Dim $cmdDefaultDelay = GUICtrlCreateButton("Set Default", 72, 432, 97, 17)

Dim $TabSheet5 = GUICtrlCreateTabItem("Program Options")
Dim $chkKeyboard = GUICtrlCreateCheckbox("Use Keyboard Mode (unchecked will assume Mouse Mode)", 24, 39, 305, 17)
Dim $chkSlowMouse = GUICtrlCreateCheckbox("Slow Mouse Mode", 24, 55, 113, 17)
Dim $chkEU = GUICtrlCreateCheckbox("Force Vindictus EU (In case of detection problems)", 24, 71, 305, 17)

Dim $Label88 = GUICtrlCreateLabel("When Vindictus loses focus:", 24, 88, 138, 17)
Dim $cmbLoseFocus = GUICtrlCreateCombo("", 168, 88, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Do Nothing|Pause Bot|Get Focus")
_GUICtrlComboBox_SetCurSel($cmbLoseFocus, $SettingOnLoseFocus)

Dim $chkNonWindow = GUICtrlCreateCheckbox("Allow Non-Active Window Commands (Potentially unstable, use at your own risk)", 24, 111, 449, 17)
Dim $Label43 = GUICtrlCreateLabel("host_timescale Max Value", 24, 127, 127, 17)
Dim $txtHostTimeScale = GUICtrlCreateInput($SettingHostTimeScale, 152, 127, 33, 21)
Dim $Label44 = GUICtrlCreateLabel("(MHWalker/SinBot binds = 5, PieBinds = 6)", 192, 127, 208, 17)
Dim $chkWebServer = GUICtrlCreateCheckbox("View log remotely via built in webserver on port", 24, 367, 241, 17)
Dim $txtWebServerPort = GUICtrlCreateInput($WebServerPort, 266, 367, 57, 21)
Dim $txtWebServerPort = GUICtrlCreateInput($WebServerPort, 266, 367, 57, 21)
Dim $Label73 = GUICtrlCreateLabel(".", 324, 367, 7, 17)
Dim $Label54 = GUICtrlCreateLabel("On-Screen Size", 24, 391, 78, 17)
Dim $txtLogSize = GUICtrlCreateInput($SettingLogSize, 104, 391, 41, 21)
Dim $Label55 = GUICtrlCreateLabel("Number of lines to display (too large a number is bad).", 152, 391, 255, 17)
Dim $chkLogFile = GUICtrlCreateCheckbox("Write output to log file.", 24, 408, 129, 17)
Dim $chkDeleteLogFile = GUICtrlCreateCheckbox("Delete Log File on Startup", 160, 407, 145, 17)
Dim $cmdDefaultOptions = GUICtrlCreateButton("Set Default", 72, 432, 97, 17)


Dim $TabSheet9 = GUICtrlCreateTabItem("Bot Options")
Dim $chkSpendAP = GUICtrlCreateCheckbox("Spend AP every", 24, 40, 97, 17)
Dim $txtAPRuns = GUICtrlCreateInput($SettingSpendAPRuns, 122, 40, 65, 21)
Dim $Label49 = GUICtrlCreateLabel("runs.", 192, 40, 27, 17)
Dim $Label56 = GUICtrlCreateLabel("Max Runs", 25, 66, 52, 17)
Dim $txtMaxRuns = GUICtrlCreateInput($SettingMaxRuns, 81, 66, 65, 21)
Dim $Label57 = GUICtrlCreateLabel("When this number is reached, the bot will deactivate. (0 = no limit)", 153, 66, 314, 17)
Dim $chkCloseBC = GUICtrlCreateCheckbox("Close Battle Cleared window (unchecked will press Replay on Battle Cleared)", 25, 90, 409, 17)
Dim $chkBCSpeedup = GUICtrlCreateCheckbox("Use ""host_timescale"" to speed up Battle Cleared (Can MILD cause lag in ALL dungeons)", 25, 106, 449, 17)
Dim $chkHostCutscene = GUICtrlCreateCheckbox("Use ""host_timescale"" to speed up cutscenes (Can MODERATE cause lag in SOME dungeons)", 25, 122, 481, 17)
Dim $chkUseTimeHack = GUICtrlCreateCheckbox("Use ""host_timescale"" to speed up dungeon (Can SEVERE cause lag in SOME dungeons)", 25, 138, 457, 17)
Dim $chkUnknownLogout = GUICtrlCreateCheckbox("When the bot is unable to identify location, logout and log back in. (Requires login info)", 25, 208, 505, 17)
Dim $Label63 = GUICtrlCreateLabel("Login Info", 25, 235, 51, 17)
Dim $Label64 = GUICtrlCreateLabel("User ID:", 81, 227, 43, 17)
Dim $txtUserName = GUICtrlCreateInput($LoginUserID, 129, 227, 113, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
Dim $Label65 = GUICtrlCreateLabel("Password:", 249, 227, 53, 17)
Dim $txtPassword = GUICtrlCreateInput($LoginPassword, 305, 227, 113, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
Dim $Label66 = GUICtrlCreateLabel("Server:", 81, 251, 38, 17)
Dim $cmbServer = GUICtrlCreateCombo("", 121, 251, 81, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "No Selection|East|West")
Switch $LoginServer
	Case "No Selection"
		_GUICtrlComboBox_SetCurSel($cmbServer, 0)
	Case "East"
		_GUICtrlComboBox_SetCurSel($cmbServer, 1)
	Case "West"
		_GUICtrlComboBox_SetCurSel($cmbServer, 2)
EndSwitch
Dim $Label67 = GUICtrlCreateLabel("Character:", 209, 251, 53, 17)
Dim $cmbCharacter = GUICtrlCreateCombo("", 265, 251, 65, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "1|2|3|4|5|6|7")
_GUICtrlComboBox_SetCurSel($cmbCharacter, $LoginCharIndex - 1)
Dim $chkChangeChannel = GUICtrlCreateCheckbox("Change channel when in town to random channel between", 25, 162, 297, 17)
Dim $txtChannelMin = GUICtrlCreateInput($SettingChannelMin, 323, 162, 41, 21)
Dim $Label69 = GUICtrlCreateLabel(" and", 365, 162, 25, 17)
Dim $txtChannelMax = GUICtrlCreateInput($SettingChannelMax, 393, 162, 41, 21)
Dim $Label70 = GUICtrlCreateLabel(" .", 434, 162, 10, 17)
Dim $Label71 = GUICtrlCreateLabel("When MHWalker deactivates itself, logout after", 25, 186, 228, 17)
Dim $txtLogoutTime = GUICtrlCreateInput($SettingLogoutTime, 257, 186, 41, 21)
Dim $Label72 = GUICtrlCreateLabel("minutes. (0 = never)", 300, 186, 97, 17)


Dim $TabSheet7 = GUICtrlCreateTabItem("Auto-Sell")
Dim $chkAutoSell = GUICtrlCreateCheckbox("Enable Auto-Selling to NPC every", 24, 48, 177, 17)
Dim $txtSellRuns = GUICtrlCreateInput($MerchantRuns, 208, 48, 57, 21)
Dim $Label68 = GUICtrlCreateLabel("runs.", 272, 48, 27, 17)
Dim $chkChest2 = GUICtrlCreateCheckbox("Chest 2", 40, 64, 97, 17)
Dim $chkChest3 = GUICtrlCreateCheckbox("Chest 3", 40, 80, 97, 17)
Dim $chkChest4 = GUICtrlCreateCheckbox("Chest 4", 40, 96, 97, 17)
Dim $chkChest5 = GUICtrlCreateCheckbox("Chest 5", 40, 112, 97, 17)
Dim $chkChest6 = GUICtrlCreateCheckbox("Chest 6", 40, 128, 97, 17)
Dim $chkChest7 = GUICtrlCreateCheckbox("Chest 7", 40, 144, 97, 17)
Dim $chkChest8 = GUICtrlCreateCheckbox("Chest 8", 40, 160, 97, 17)
Dim $chkChest9 = GUICtrlCreateCheckbox("Chest 9", 40, 176, 97, 17)
Dim $Group1 = GUICtrlCreateGroup("Do Not Sell", 16, 200, 505, 81)
Dim $chkNoScrolls = GUICtrlCreateCheckbox("Enchant Scrolls", 25, 217, 153, 17)
Dim $chkNoEmpowered = GUICtrlCreateCheckbox("Empowered Enhancement Stones", 25, 234, 233, 17)
Dim $chkNoEpic = GUICtrlCreateCheckbox("Epic Enhancement Stones", 264, 234, 145, 17)
Dim $chkNoMP = GUICtrlCreateCheckbox("Magic Powder", 25, 251, 97, 17)
Dim $chkNoBMP = GUICtrlCreateCheckbox("Blessed Magic Powder", 264, 251, 137, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Dim $cmdDefaultAutoSell = GUICtrlCreateButton("Set Default", 72, 432, 97, 17)

Dim $TabSheet6 = GUICtrlCreateTabItem("Dungeons")
Dim $Label45 = GUICtrlCreateLabel("Available Dungeons:", 16, 39, 102, 17)
Dim $lvwDungeons = GUICtrlCreateListView("Dungeon Name", 16, 56, 511, 345, BitOR($GUI_SS_DEFAULT_LISTVIEW,$WS_VSCROLL), BitOR($WS_EX_CLIENTEDGE,$LVS_EX_CHECKBOXES))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 420)
Dim $Label61 = GUICtrlCreateLabel("Checked dungeons will use ""host_timescale"". Unchecked dungeons will not.", 16, 408, 367, 17)
Dim $Label62 = GUICtrlCreateLabel("[*] Indicates VIP Edition required.", 368, 39, 159, 17)
Dim $cmdDefaultDungeons = GUICtrlCreateButton("Set Default", 72, 432, 97, 17)

GUICtrlCreateTabItem("")
Dim $cmdSave = GUICtrlCreateButton("Save Settings", 120, 464, 97, 25)
Dim $cmdStart = GUICtrlCreateButton("Start", 224, 464, 97, 25)
Dim $cmdClose = GUICtrlCreateButton("Close", 328, 464, 97, 25)
#endregion ### END Koda GUI section ###
If $SettingSpendAP == 1 Then
	GUICtrlSetState($chkSpendAP, $GUI_CHECKED)
Else
	GUICtrlSetState($chkSpendAP, $GUI_UNCHECKED)
EndIf
If $SettingWriteLogFile == 1 Then
	GUICtrlSetState($chkLogFile, $GUI_CHECKED)
Else
	GUICtrlSetState($chkLogFile, $GUI_UNCHECKED)
EndIf
If $SettingDeleteLogFile == 1 Then
	GUICtrlSetState($chkDeleteLogFile, $GUI_CHECKED)
Else
	GUICtrlSetState($chkDeleteLogFile, $GUI_UNCHECKED)
EndIf
;If $SettingPauseOnLoseFocus == 1 Then
;	GUICtrlSetState($chkPauseOnLoseFocus, $GUI_CHECKED)
;Else
;	GUICtrlSetState($chkPauseOnLoseFocus, $GUI_UNCHECKED)
;EndIf
If $SettingKeyboardMode == 1 Then
	GUICtrlSetState($chkKeyboard, $GUI_CHECKED)
Else
	GUICtrlSetState($chkKeyboard, $GUI_UNCHECKED)
EndIf
If $SettingUseTimeHack == 1 Then
	GUICtrlSetState($chkUseTimeHack, $GUI_CHECKED)
Else
	GUICtrlSetState($chkUseTimeHack, $GUI_UNCHECKED)
EndIf
If $SettingEU == 1 Then
	GUICtrlSetState($chkEU, $GUI_CHECKED)
Else
	GUICtrlSetState($chkEU, $GUI_UNCHECKED)
EndIf
If $IsDonator Then
	Edit($lblRegisterName, "Name: " & $DonatorName)
	Edit($lblRegisterEmail, "Email: " & $DonatorEmail)
	Edit($lblRegisterMsg, $DonatorMessage)
Else
	Edit($lblRegisterName, "Name: (Public Edition)")
	Edit($lblRegisterEmail, "Email: (Public Edition)")
	Edit($lblRegisterMsg, "If you like this program, please consider donating!")
EndIf
If $SettingNonWindowMode == 1 Then
	GUICtrlSetState($chkNonWindow, $GUI_CHECKED)
Else
	GUICtrlSetState($chkNonWindow, $GUI_UNCHECKED)
EndIf
If $SettingFastBattleCleared == 1 Then
	GUICtrlSetState($chkBCSpeedup, $GUI_CHECKED)
Else
	GUICtrlSetState($chkBCSpeedup, $GUI_UNCHECKED)
EndIf
If $SettingSlowMouse == 1 Then
	GUICtrlSetState($chkSlowMouse, $GUI_CHECKED)
Else
	GUICtrlSetState($chkSlowMouse, $GUI_UNCHECKED)
EndIf
If $SettingCloseBattleCleared == 1 Then
	GUICtrlSetState($chkCloseBC, $GUI_CHECKED)
Else
	GUICtrlSetState($chkCloseBC, $GUI_UNCHECKED)
EndIf
If $SettingChangeChannel == 1 Then
	GUICtrlSetState($chkChangeChannel, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChangeChannel, $GUI_UNCHECKED)
EndIf
Edit($txtChannelMin, $SettingChannelMin)
Edit($txtChannelMax, $SettingChannelMax)
If ($MerchantOn == 1) And ($IsDonator) Then
	GUICtrlSetState($chkAutoSell, $GUI_CHECKED)
Else
	GUICtrlSetState($chkAutoSell, $GUI_UNCHECKED)
EndIf
If $MerchantChests[0] == 1 Then
	GUICtrlSetState($chkChest2, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest2, $GUI_UNCHECKED)
EndIf
If $MerchantChests[1] == 1 Then
	GUICtrlSetState($chkChest3, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest3, $GUI_UNCHECKED)
EndIf
If $MerchantChests[2] == 1 Then
	GUICtrlSetState($chkChest4, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest4, $GUI_UNCHECKED)
EndIf
If $MerchantChests[3] == 1 Then
	GUICtrlSetState($chkChest5, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest5, $GUI_UNCHECKED)
EndIf
If $MerchantChests[4] == 1 Then
	GUICtrlSetState($chkChest6, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest6, $GUI_UNCHECKED)
EndIf
If $MerchantChests[5] == 1 Then
	GUICtrlSetState($chkChest7, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest7, $GUI_UNCHECKED)
EndIf
If $MerchantChests[6] == 1 Then
	GUICtrlSetState($chkChest8, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest8, $GUI_UNCHECKED)
EndIf
If $MerchantChests[7] == 1 Then
	GUICtrlSetState($chkChest9, $GUI_CHECKED)
Else
	GUICtrlSetState($chkChest9, $GUI_UNCHECKED)
EndIf
If $MerchantNoScrolls == 1 Then
	GUICtrlSetState($chkNoScrolls, $GUI_CHECKED)
Else
	GUICtrlSetState($chkNoScrolls, $GUI_UNCHECKED)
EndIf
If $MerchantNoEmpowered == 1 Then
	GUICtrlSetState($chkNoEmpowered, $GUI_CHECKED)
Else
	GUICtrlSetState($chkNoEmpowered, $GUI_UNCHECKED)
EndIf
If $MerchantNoEpic == 1 Then
	GUICtrlSetState($chkNoEpic, $GUI_CHECKED)
Else
	GUICtrlSetState($chkNoEpic, $GUI_UNCHECKED)
EndIf
If $MerchantNoMagicPowder == 1 Then
	GUICtrlSetState($chkNoMP, $GUI_CHECKED)
Else
	GUICtrlSetState($chkNoMP, $GUI_UNCHECKED)
EndIf
If $MerchantNoBlessedPowder == 1 Then
	GUICtrlSetState($chkNoBMP, $GUI_CHECKED)
Else
	GUICtrlSetState($chkNoBMP, $GUI_UNCHECKED)
EndIf
If $SettingSpeedupScene == 1 Then
	GUICtrlSetState($chkHostCutscene, $GUI_CHECKED)
Else
	GUICtrlSetState($chkHostCutscene, $GUI_UNCHECKED)
EndIf
If $WebServerOn == 1 Then
	GUICtrlSetState($chkWebServer, $GUI_CHECKED)
Else
	GUICtrlSetState($chkWebServer, $GUI_UNCHECKED)
EndIf
If $SettingLogout == 1 Then
	GUICtrlSetState($chkUnknownLogout, $GUI_CHECKED)
Else
	GUICtrlSetState($chkUnknownLogout, $GUI_UNCHECKED)
EndIf

Global $DungeonList[1]
Global $DungeonNames[1]
Dim $TotalDungeons = 0
_GUICtrlListView_BeginUpdate($lvwDungeons)
If $IsPremium Then AddDungeon("Mercenary Training Site")
If $IsPremium Then AddDungeon("Fomorian Emblem")
If $IsPremium Then AddDungeon("Gold Leather")
AddDungeon("Gwynn's Request")
If $IsPremium Then AddDungeon("Wind Through The Ruins")
AddDungeon("Decisive Battle")
AddDungeon("Friends?")
AddDungeon("Revenge")
If $IsPremium Then AddDungeon("Red Ruins")
AddDungeon("Trampled Plains")
If $IsPremium Then AddDungeon("Hoarfrost Hollow")
If $IsPremium Then AddDungeon("Southern Rock Cliff [*]")
If $IsPremium Then AddDungeon("Western Ice Passage")
	;AddDungeon("Meet the Cave Spider [*]")
AddDungeon("Another Slingshot")
AddDungeon("Final Slingshot")
AddDungeon("Fomorian Order")
AddDungeon("Frost Stones [*]")
AddDungeon("Brynn's Research")
AddDungeon("Source of the Rumor")
AddDungeon("Kobold Chief")
AddDungeon("Dethrone the White Tyrant")
AddDungeon("Prepare for Counterattack")
AddDungeon("Culprit Behind the Disturbance")
AddDungeon("Spider Overload")
AddDungeon("White Tyrant's Challenge")
If $IsPremium Then AddDungeon("A Town Engulfed [*]")
If $IsPremium Then AddDungeon("Ellis's Trust")
If $IsPremium Then AddDungeon("Hell Beyond the Door [*]")
AddDungeon("Wake Up Call")
If $IsPremium Then AddDungeon("Friend or Foe [*]")
AddDungeon("Piercing the Crescent Moon [*]")
If $IsPremium Then AddDungeon("Ulchas's Relic")
AddDungeon("Dead End Street")
AddDungeon("Being from the Other World")
;AddDungeon("Blood Prince")
;AddDungeon("Remnants")
AddDungeon("Depths of Ainle")
AddDungeon("Burnt Pumpkin Field")
AddDungeon("Where the legend sleeps")
AddDungeon("Holy Ground")
AddDungeon("The Unveiling Truth")
AddDungeon("Regrets... Too Late")
AddDungeon("Shadowed by Darkness")
AddDungeon("The Weeping Queen [*]")
;AddDungeon("Prairie Entrance")
AddDungeon("Prairie Gnoll")
;AddDungeon("The Fleeing Gnoll King")
;AddDungeon("The Fomorian Leader")
;AddDungeon("Red Archer")
;AddDungeon("Hunter at the Ruins")
If $IsPremium Then AddDungeon("Ruins of Sanctity")
;AddDungeon("The Five Spider Brothers")
AddDungeon("Gnoll King, Ruler of the Ruins")
AddDungeon("Goliath")
AddDungeon("Hidden")
AddDungeon("Nightmare at the Ruins")
;AddDungeon("Patrolling the Depths")
If $IsPremium Then AddDungeon("Snowman Alert [*]")
If $IsPremium Then AddDungeon("Windgun [*]")
;AddDungeon("Greedy Kobold")
;AddDungeon("Ocean Scent")
;AddDungeon("The Yeti, an Ancient Race")
AddDungeon("Appearance of a Small Bear")
;AddDungeon("Big Horn Yeti")
AddDungeon("Hoarfrost Hollow in Flames")
AddDungeon("Yeti King")
AddDungeon("Madness")
AddDungeon("Irukul [*]")
AddDungeon("Proof of Courage")
AddDungeon("Revived Fear [*]")
AddDungeon("Unfinished Business")
AddDungeon("The Howling Soul")
AddDungeon("Two Moons [*]")
If $IsPremium Then AddDungeon("Beginning of the Memory [*]")
If $IsPremium Then AddDungeon("Investigation [*]")
If $IsPremium Then AddDungeon("West Hilder Forest [*]")
If $IsPremium Then AddDungeon("Habitat for Wild Plants")
AddDungeon("Forest Ruins [*]")
AddDungeon("Fight That Must Be Won")
AddDungeon("Shady Forest")
If $IsPremium Then AddDungeon("Chicanery")
If $IsPremium Then AddDungeon("Storeroom")
If $IsPremium Then AddDungeon("Contact")
If $IsPremium Then AddDungeon("Rocktune's Cabin [*]")
If $IsPremium Then AddDungeon("Cadet's Challenge")
If $IsPremium Then AddDungeon("Bandits [*]")
If $IsPremium Then AddDungeon("Herb Lands [*]")
If $IsPremium Then AddDungeon("Rocky Wilderness [*]")
AddDungeon("Lost Road")
AddDungeon("Fruitful")
AddDungeon("Buried Sorrow")
AddDungeon("Colhen in Flames")
AddDungeon("Pursuit")
AddDungeon("Rescue [*]")
AddDungeon("Gremlin Lair [*]")
AddDungeon("The Secret")
If $IsPremium Then AddDungeon("Another Storeroom [*]")
;AddDungeon("Reinforcements [*]")
AddDungeon("The Investigation")
AddDungeon("The Last Fragment [*]")
AddDungeon("The Contract [*]")
If $IsPremium Then AddDungeon("Ambush [*]")
;AddDungeon("Pretty Green Beetle [*]")
AddDungeon("Where the Road Leads [*]")
AddDungeon("Where the Sun Don't Shine [*]")
If $IsPremium Then AddDungeon("Give a Begger a Coin... (Partial Support)")
AddDungeon("What the Dead Leave Behind (Partial Support)")
AddDungeon("Taking Initiative")
;AddDungeon("Wet, Dark, and Mossy [*]")							;not presently possible
;AddDungeon("Sewers [*]")
AddDungeon("Strong Drink")
;AddDungeon("The Inverse Blade [*]")
;AddDungeon("Blade of Silence [*]")
AddDungeon("Gatekeeper of the Catacombs")
AddDungeon("Resenlian's Labyrinth")
_GUICtrlListView_EndUpdate($lvwDungeons)
;WriteDungeonList()
ReadDungeonSettings()

Edit($lblNumDungeons, "This version supports " & $TotalDungeons & " dungeons. See the Dungeons tab for more details.")

Func SetGUITitle($name)
	WinSetTitle("MHWalker", "", $name)
EndFunc

Func Edit($control, $text)
	_GUICtrlEdit_SetText($control, $text)
EndFunc

Func AddDungeon ($sValue, $Inc = True)
	Dim $myName = ""
	If StringRight($sValue, 4) == " [*]" Then
		$myName = StringLeft($SValue, StringLen($sValue) - 4)
	Else
		$myName = $sValue
	EndIf
	;_GUICtrlEdit_AppendText($txtDungeons, $sValue & @CRLF)
	Dim $lvi = GUICtrlCreateListViewItem($sValue, $lvwDungeons)
	_ArrayAdd($DungeonList, $lvi)
	_ArrayAdd($DungeonNames, $myName)
	;_GUICtrlListView_SetItemParam($lvwDungeons, Ubound($DungeonList) - 1, $myName)
	If $Inc Then
		$TotalDungeons += 1
	EndIf
EndFunc

Func HasTimeScaleSet($DungeonName)
	Dim $i = 0
    Dim $tInfo = DllStructCreate($tagLVFINDINFO)
    DllStructSetData($tInfo, "Flags", $LVFI_PARTIAL)
    DllStructSetData($tInfo, "Param", $DungeonName)
	Dim $item = _GUICtrlListView_FindItem($lvwDungeons, -1, $tInfo, $DungeonName)
	If $item == -1 Then
		Return False
	Else
		If _GUICtrlListView_GetItemChecked($lvwDungeons, $item) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc

Func SetTimeScale($DungeonName)
	Dim $i = 0
    Dim $tInfo = DllStructCreate($tagLVFINDINFO)
    DllStructSetData($tInfo, "Flags", $LVFI_PARTIAL)
    DllStructSetData($tInfo, "Param", $DungeonName)
	Dim $item = _GUICtrlListView_FindItem($lvwDungeons, -1, $tInfo, $DungeonName)
	If $item <> -1 Then
		_GUICtrlListView_SetItemChecked($lvwDungeons, $item)
	EndIf
EndFunc

Func GetVal($control)
	Return _GUICtrlEdit_GetText($control)
EndFunc

;TODO
Func CheckKeyConflicts()
	Dim $chkKeys[1]
	$chkKeys[0] = "This is a dummy placeholder. Do not delete, DO disregard."

	_ArrayAdd($chkKeys, StringUpper(GetVal($txtEnd)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtPause)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtStart)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtLegend)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtPauseAfterRun)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtGod)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtOHK)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtSmall)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtLarge)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtNormal)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtTrans1)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtNuke)))
	If $IsPremium Then _ArrayAdd($chkKeys, StringUpper(GetVal($txtKill1)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtTimescale)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtSkipMap)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtSpears)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtShipList)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtSendChange)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtSendStart)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtColhan)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtRocheste)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtMines)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtPickup)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtReload)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtMailbox)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtShop)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtCloseWindow)))
	_ArrayAdd($chkKeys, StringUpper(GetVal($txtCloseAlchemy)))

	Dim $newKeys = _ArrayUnique($chkKeys)
	If (($newKeys[0]) == Ubound($chkKeys)) Then
		Return False
	Else
		Return True
	EndIf
EndFunc

Func QuerySettings ()
	$KeyShutDown = GetVal($txtEnd)
	$KeyPause = GetVal($txtPause)
	$KeyStart = GetVal($txtStart)
	$KeyLegend = GetVal($txtLegend)
	$KeyPauseAfterRun = GetVal($txtPauseAfterRun)
	$BindGod = GetVal($txtGod)
	$BindOHK = GetVal($txtOHK)
	$BindSmall = GetVal($txtSmall)
	$BindLarge = GetVal($txtLarge)
	$BindNormal = GetVal($txtNormal)
	$BindTrans1 = GetVal($txtTrans1)
	$BindTrans2 = GetVal($txtNuke)
	;$BindTenticle = GetVal($txtTenticle)
	If $IsPremium Then $BindKill1 = GetVal($txtKill1)
	$BindTimescale = GetVal($txtTimescale)
	$BindSkipMap = GetVal($txtSkipMap)
	$BindSpears = GetVal($txtSpears)
	$BindShipList = GetVal($txtShipList)
	$BindLBBypass = GetVal($txtSendChange)
	$BindCSBypass = GetVal($txtSendStart)
	$BindColhan = GetVal($txtColhan)
	$BindRocheste = GetVal($txtRocheste)
	$BindMineBombs = GetVal($txtMines)
	$BindPickupDistance = GetVal($txtPickup)
	$BindReloadMap = GetVal($txtReload)
	$BindCloseAlchemy = GetVal($txtCloseAlchemy)
	$BindCloseWindow = GetVal($txtCloseWindow)
	$BindMailbox = GetVal($txtMailbox)
	$BindShop = GetVal($txtShop)

	$DelayToTownLag = GetVal($txtTownLag)
	If GUICtrlRead($chkSpendAP) == $GUI_CHECKED Then
		$SettingSpendAP = 1
	Else
		$SettingSpendAP = 0
	EndIf
	$SettingSpendAPRuns = GetVal($txtAPRuns)
	If GUICtrlRead($chkLogFile) == $GUI_CHECKED Then
		$SettingWriteLogFile = 1
	Else
		$SettingWriteLogFile = 0
	EndIf
	If GUICtrlRead($chkDeleteLogFile) == $GUI_CHECKED Then
		$SettingDeleteLogFile = 1
	Else
		$SettingDeleteLogFile = 0
	EndIf
	$SettingOnLoseFocus = _GUICtrlComboBox_GetCurSel($cmbLoseFocus)
	Switch $SettingOnLoseFocus
		Case 0
			$SettingPauseOnLoseFocus = 0
			$SettingForceOnLoseFocus = 0
		Case 1
			$SettingPauseOnLoseFocus = 1
			$SettingForceOnLoseFocus = 0
		Case 2
			$SettingPauseOnLoseFocus = 0
			$SettingForceOnLoseFocus = 1
	EndSwitch
	;If GUICtrlRead($chkPauseOnLoseFocus) == $GUI_CHECKED Then
	;	$SettingPauseOnLoseFocus = 1
	;Else
	;	$SettingPauseOnLoseFocus = 0
	;EndIf
	$SettingMaxRuns = GetVal($txtMaxRuns)
	$SettingLogSize = GetVal($txtLogSize)
	If GUICtrlRead($chkKeyboard) == $GUI_CHECKED Then
		$SettingKeyboardMode = 1
		$MoveForward = "{UP}"
		$MoveForwardDown = "{UP DOWN}"
		$MoveForwardUp = "{UP UP}"
		$MoveBackward = "{DOWN}"
		$MoveBackwardDown = "{DOWN DOWN}"
		$MoveBackwardUp = "{DOWN UP}"
		$MoveLeft = "{LEFT}"
		$MoveLeftDown = "{LEFT DOWN}"
		$MoveLeftUP = "{LEFT UP}"
		$MoveRight = "{RIGHT}"
		$MoveRightDown = "{RIGHT DOWN}"
		$MoveRightUp = "{RIGHT UP}"
		$FireSecondary = "{LSHIFT}"
	Else
		$SettingKeyboardMode = 0
		$MoveForward = "w"
		$MoveForwardDown = "{W DOWN}"
		$MoveForwardUp = "{W UP}"
		$MoveBackward = "s"
		$MoveBackwardDown = "{S DOWN}"
		$MoveBackwardUp = "{S UP}"
		$MoveLeft = "a"
		$MoveLeftDown = "{A DOWN}"
		$MoveLeftUp = "{A UP}"
		$MoveRight = "{D}"
		$MoveRightDown = "{D DOWN}"
		$MoveRightUp = "{D UP}"
		$FireSecondary = "f"
	EndIf
	$SettingHostTimeScale = GetVal($txtHostTimeScale)
	If GUICtrlRead($chkUseTimeHack) == $GUI_CHECKED Then
		$SettingUseTimeHack = 1
	Else
		$SettingUseTimeHack = 0
	EndIf
	If ($SettingUseTimeHack == 1) Then
		$SettingHostTimeScaleUse = $SettingHostTimeScale
	Else
		$SettingHostTimeScaleUse = 1
	EndIf
	If $SettingHostTimeScale == 0 Then
		$SettingHostTimeScale = 1
	EndIf
	If GUICtrlRead($chkEU) == $GUI_CHECKED Then
		$SettingEU = 1
	Else
		$SettingEU = 0
	EndIf
	If GUICtrlRead($chkNonWindow) == $GUI_CHECKED Then
		$SettingNonWindowMode = 1
	Else
		$SettingNonWindowMode = 0
	EndIf
	If GUICtrlRead($chkBCSpeedup) == $GUI_CHECKED Then
		$SettingFastBattleCleared = 1
	Else
		$SettingFastBattleCleared = 0
	EndIf
	If GUICtrlRead($chkSlowMouse) == $GUI_CHECKED Then
		$SettingSlowMouse = 1
		$SettingMouseSpeed = 10
	Else
		$SettingSlowMouse = 0
		$SettingMouseSpeed = 5
	EndIf
	If GUICtrlRead($chkCloseBC) == $GUI_CHECKED Then
		$SettingCloseBattleCleared = 1
	Else
		$SettingCloseBattleCleared = 0
	EndIf
	If GUICtrlRead($chkUnknownLogout) == $GUI_CHECKED Then
		$SettingLogout = 1
	Else
		$SettingLogout = 0
	EndIf
	$LoginCharIndex = _GUICtrlComboBox_GetCurSel($cmbCharacter) + 1
	$LoginServer = GetVal($cmbServer)
	$LoginUserID = GetVal($txtUserName)
	$LoginPassword = GetVal($txtPassword)

	;change channel settings
	If GUICtrlRead($chkChangeChannel) == $GUI_CHECKED Then
		$SettingChangeChannel = 1
	Else
		$SettingChangeChannel = 0
	EndIf
	$SettingChannelMin = Int(GetVal($txtChannelMin))
	$SettingChannelMax = Int(GetVal($txtChannelMax))

	;query settings for auto-sell
	If GUICtrlRead($chkAutoSell) == $GUI_CHECKED Then
		$MerchantOn = 1
	Else
		$MerchantOn = 0
	EndIf
	$MerchantRuns = GetVal($txtSellRuns)
	If GUICtrlRead($chkChest2) == $GUI_CHECKED Then
		$MerchantChests[0] = 1
	Else
		$MerchantChests[0] = 0
	EndIf
	If GUICtrlRead($chkChest3) == $GUI_CHECKED Then
		$MerchantChests[1] = 1
	Else
		$MerchantChests[1] = 0
	EndIf
	If GUICtrlRead($chkChest4) == $GUI_CHECKED Then
		$MerchantChests[2] = 1
	Else
		$MerchantChests[2] = 0
	EndIf
	If GUICtrlRead($chkChest5) == $GUI_CHECKED Then
		$MerchantChests[3] = 1
	Else
		$MerchantChests[3] = 0
	EndIf
	If GUICtrlRead($chkChest6) == $GUI_CHECKED Then
		$MerchantChests[4] = 1
	Else
		$MerchantChests[4] = 0
	EndIf
	If GUICtrlRead($chkChest7) == $GUI_CHECKED Then
		$MerchantChests[5] = 1
	Else
		$MerchantChests[5] = 0
	EndIf
	If GUICtrlRead($chkChest8) == $GUI_CHECKED Then
		$MerchantChests[6] = 1
	Else
		$MerchantChests[6] = 0
	EndIf
	If GUICtrlRead($chkChest9) == $GUI_CHECKED Then
		$MerchantChests[7] = 1
	Else
		$MerchantChests[7] = 0
	EndIf
	If GUICtrlRead($chkNoScrolls) == $GUI_CHECKED Then
		$MerchantNoScrolls = 1
	Else
		$MerchantNoScrolls = 0
	EndIf
	If GUICtrlRead($chkNoEmpowered) == $GUI_CHECKED Then
		$MerchantNoEmpowered = 1
	Else
		$MerchantNoEmpowered = 0
	EndIf
	$MerchantNoEpic = GetCheckBox($chkNoEpic)
	$MerchantNoMagicPowder = GetCheckBox($chkNoMP)
	$MerchantNoBlessedPowder = GetCheckBox($chkNoBMP)

	If GUICtrlRead($chkHostCutscene) == $GUI_CHECKED Then
		$SettingSpeedupScene = 1
		$SettingHostTimeScaleStatic = $SettingHostTimeScale
	Else
		$SettingSpeedupScene = 0
		$SettingHostTimeScaleStatic = 1
	EndIf
	$SettingLogoutTime = GetVal($txtLogoutTime)

	If GUICtrlRead($chkWebServer) == $GUI_CHECKED Then
		$WebServerOn = 1
	Else
		$WebServerOn = 0
	EndIf
	$WebServerPort = GetVal($txtWebServerPort)
EndFunc

Func GetCheckBox($chkName)
	If GUICtrlRead($chkName) == $GUI_CHECKED Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc

Func ShowGUI()
	GUISetState(@SW_SHOW)
	SetComboHeight($cmbLoseFocus, 3, $fMain)
	SetComboHeight($cmbServer, 3, $fMain)
	SetComboHeight($cmbCharacter, 7, $fMain)
	While 1
		Dim $nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				SaveWindow($fMain)
				Exit

			Case $picDonate
				ShellExecute("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=NGMXT38XXWXR6")
			Case $cmdDefault
				Edit($txtStart, "{INS}")
				Edit($txtPause, "{PAUSE}")
				Edit($txtEnd, "{END}")
				Edit($txtLegend, "{DEL}")
				Edit($txtPauseAfterRun, "{HOME}")

			;Case $cmdPie
			;	Edit($txtGod, "{NUMPADDIV}")
			;	Edit($txtOHK, "{NUMPADMULT}")
			;	Edit($txtSmall, "{NUMPAD4}")
			;	Edit($txtLarge, "{NUMPAD6}")
			;	Edit($txtNormal, "{NUMPAD5}")
			;	Edit($txtTrans1, "{F7}")
			;	Edit($txtTrans2, "{F8}")
			;	Edit($txtTenticle, "h")
			;	Edit($txtTimescale, "{NUMPAD2}")
			;	Edit($txtSkipMap, "{NUMPAD0}")
			;	Edit($txtSpears, "I")
			;	Edit($txtShipList, "{HOME}")
			;	Edit($txtSendChange, "{DEL}")
			;	Edit($txtSendStart, "{END}")
			;	Edit($txtColhan, "{F9}")
			;	Edit($txtRocheste, "{F10}")
			;	Edit($txtMines, "k")
			;	Edit($txtPickup, "-")
			;	Edit($txtReload, "{NUMPAD9}")
			;	Edit($txtHostTimeScale, "6")
			;Case $cmdSin
			;	Edit($txtGod, "{NUMPAD0}")
			;	Edit($txtOHK, "{NUMPADSUB}")
			;	Edit($txtSmall, "{NUMPAD4}")
			;	Edit($txtLarge, "[")
			;	Edit($txtNormal, "{NUMPAD5}")
			;	Edit($txtTrans1, "{UP}")
			;	Edit($txtTrans2, "{RIGHT}")
			;	Edit($txtTenticle, "{PGUP}")
			;	Edit($txtTimescale, "{NUMPADDIV}")
			;	Edit($txtSkipMap, "{NUMPAD6}")
			;	Edit($txtSpears, "{NUMPAD7}")
			;	Edit($txtShipList, "=")
			;	Edit($txtSendChange, "l")
			;	Edit($txtSendStart, "-")
			;	Edit($txtColhan, ",")
			;	Edit($txtRocheste, ".")
			;	Edit($txtMines, "{NUMPAD9}")
			;	Edit($txtPickup, "{]}")
			;	Edit($txtReload, "{NUMPAD3}")
			;	Edit($txtHostTimeScale, "5")
			Case $cmdMHWalker
				Edit($txtGod, "{NUMPAD0}")
				Edit($txtOHK, "{NUMPADSUB}")
				Edit($txtSmall, "{NUMPAD4}")
				Edit($txtLarge, "[")
				Edit($txtNormal, "{NUMPAD5}")
				Edit($txtTrans1, "{NUMPAD8}")
				Edit($txtNuke, "{NUMPADDOT}")
				;Edit($txtTenticle, "{NUMPADADD}")
				If $IsPremium Then Edit($txtKill1, "{NUMPAD2}")
				Edit($txtTimescale, "{NUMPADDIV}")
				Edit($txtSkipMap, "{NUMPAD6}")
				Edit($txtSpears, "{NUMPAD7}")
				Edit($txtShipList, "=")
				Edit($txtSendChange, "l")
				Edit($txtSendStart, "-")
				Edit($txtColhan, ",")
				Edit($txtRocheste, ".")
				Edit($txtMines, "{NUMPAD9}")
				Edit($txtPickup, "{]}")
				Edit($txtReload, "{NUMPAD3}")
				Edit($txtHostTimeScale, "5")
				Edit($txtMailbox, "{F5}")
				Edit($txtShop, "{F6}")
				Edit($txtCloseWindow, "{F7}")
				Edit($txtCloseAlchemy, "{F8}")
				DetectConsole()
				If $ConsoleExists Then
					Dim $ret = MsgBox(4, "Paste binds?", "I see that you're using " & $ConsoleName & ". Would you like me to paste the binds directly to console?")
					If $ret == 6 Then
						AutoItSetOption("SendKeyDelay", 0)
						AutoItSetOption("SendKeyDownDelay", 0)
						DankSoleWrite("bind ""KP_LEFTARROW"" ""cc_change_figure_height 0.1""")
						DankSoleWrite("bind ""KP_5"" ""cc_change_figure_height 1""")
						DankSoleWrite("bind ""KP_RIGHTARROW"" ""changemap_to_next_random_sector""")
						DankSoleWrite("bind ""KP_HOME"" ""cc_set_sub_weapon javelin_lvl2 999""")
						If $ConsoleGodmode Then
							DankSoleWrite("bind ""KP_INS"" ""godmode""")
						Else
							DankSoleWrite("bind ""KP_INS"" ""god""")
						EndIf
						DankSoleWrite("bind ""KP_MINUS"" ""ohk""")
						DankSoleWrite("bind ""KP_SLASH"" ""incrementvar host_timescale 1 5 4""")
						DankSoleWrite("bind ""KP_UPARROW"" ""plr_play_overlay_sequence paladin_transformation_begin_1""")
						DankSoleWrite("bind ""KP_DEL"" ""nuke""")
						DankSoleWrite("bind ""KP_PGUP"" ""cc_set_sub_weapon mining_bomb 999""")
						DankSoleWrite("bind ""KP_PLUS"" ""plr_play_overlay_sequence paladin_2_skill_tentacle""")
						DankSoleWrite("bind ""KP_PGDN"" ""changemap_to_current_random_sector""")
						DankSoleWrite("bind ""F5"" ""cc_mailbox_ui""")
						DankSoleWrite("bind ""F6"" ""show_mini_shop""")
						DankSoleWrite("bind ""F7"" ""close_last_dialog""")
						DankSoleWrite("bind ""F8"" ""close_alchemy_box""")
						DankSoleWrite("bind ""["" ""cc_change_figure_height 1500""")
						DankSoleWrite("bind ""]"" ""incrementvar plr_search_evil_core_distance 500 3000 2500""")
						DankSoleWrite("bind ""="" ""cc_shiplist_ui""")
						DankSoleWrite("bind ""-"" ""cc_send_start_game_message""")
						DankSoleWrite("bind "","" ""cc_enter_colhen_from_rochest""")
						DankSoleWrite("bind ""."" ""cc_enter_rochest_from_colhen""")
						DankSoleWrite("bind ""/"" ""force_state_transition_to_purgetowharf""")
						If  $ConsoleExtras Then
							DankSoleWrite("bind ""KP_END"" ""brk""")
							DankSoleWrite("bind ""*"" ""kill2""")
						EndIf
						AutoItSetOption("SendKeyDelay", 5)
						AutoItSetOption("SendKeyDownDelay", 5)

						MinimizeConsole()
					EndIf
				EndIf

			Case $cmdDefaultDelay
				Edit($txtTownLag, "15000")
				Edit($txtDungeonComplete, "300000")

			Case $cmdDefaultOptions
				GUICtrlSetState($chkSpendAP, $GUI_CHECKED)
				Edit($txtAPRuns, "10")
				GUICtrlSetState($chkLogFile, $GUI_CHECKED)
				Edit($txtMaxRuns, "0")
				Edit($txtLogSize, "10")
				GUICtrlSetState($chkDeleteLogFile, $GUI_UNCHECKED)
				;GUICtrlSetState($chkPauseOnLoseFocus, $GUI_CHECKED)
				GUICtrlSetState($chkKeyboard, $GUI_UNCHECKED)
				GUICtrlSetState($chkUseTimeHack, $GUI_CHECKED)
				GUICtrlSetState($chkNonWindow, $GUI_UNCHECKED)
				GUICtrlSetState($chkBCSpeedup, $GUI_CHECKED)
				GUICtrlSetState($chkCloseBC, $GUI_CHECKED)
				GUICtrlSetState($chkChangeChannel, $GUI_CHECKED)
				Edit($txtChannelMin, "160")
				Edit($txtChannelMax, "190")
				GUICtrlSetState($chkHostCutscene, $GUI_CHECKED)
				Edit($txtLogoutTime, "5")
				GUICtrlSetState($chkWebServer, $GUI_UNCHECKED)

			Case $cmdDefaultDungeons
				UncheckAllDungeons()
				SetTimeScale("Gwynn's Request")
				SetTimeScale("Decisive Battle")
				SetTimeScale("Revenge")
				SetTimeScale("Trampled Plains")
				SetTimeScale("Wake Up Call")
				SetTimeScale("Dead End Street")
				SetTimeScale("Being from the Other World")
				SetTimeScale("Dephths of Ainle")
				SetTimeScale("Burnt Pumpkin Field")
				SetTimeScale("Where the legend sleeps")
				SetTimeScale("Holy Ground")
				SetTimeScale("Regrets... Too Late")
				SetTimeScale("Gnoll King, Ruler of the Ruins")
				SetTimeScale("Goliath")
				SetTimeScale("Fight That Must Be Won")
				SetTimeScale("Buried Sorrow")
				SetTimeScale("The Secret")
				SetTimeScale("The Contract")

			Case $cmdDefaultAutoSell
				GUICtrlSetState($chkChest2, $GUI_CHECKED)
				GUICtrlSetState($chkChest3, $GUI_CHECKED)
				GUICtrlSetState($chkNoScrolls, $GUI_CHECKED)
				GUICtrlSetState($chkNoEmpowered, $GUI_CHECKED)
				GUICtrlSetState($chkNoEpic, $GUI_CHECKED)
				GUICtrlSetState($chkNoMP, $GUI_CHECKED)
				GUICtrlSetState($chkNoBMP, $GUI_CHECKED)

			Case $cmdSave
				QuerySettings()
				SaveWindow($fMain)
				If CheckKeyConflicts() Then
					MsgBox(0, "Conflict found!", "One or more of your hotkey or binds conflicts. Every value on Binds and Hotkeys should be unique. This could cause serious issues! Please reset your Binds and Hotkeys and try again.")
				Else
					SaveSettings()
					WriteDungeonSettings()
				EndIf
			Case $cmdStart
				QuerySettings()
				SaveWindow($fMain)
				If CheckKeyConflicts() Then
					MsgBox(0, "Conflict found!", "One or more of your hotkey or binds conflicts. Every value on Binds and Hotkeys should be unique. This could cause serious issues! Please reset your Binds and Hotkeys and try again.")
				Else
					GUISetState(@SW_HIDE)
					Return
				EndIf
			Case $cmdClose
				SaveWindow($fMain)
				Exit

			Case $chkAutoSell
				If GUICtrlRead($chkAutoSell) == $GUI_CHECKED Then
					If (Not $IsDonator) Then
						GUICtrlSetState($chkAutoSell, $GUI_UNCHECKED)
						MsgBox(0, "VIP Functions Diabled", "VIP functions are currently disabled.")
					EndIf
				EndIf

		EndSwitch
	WEnd
EndFunc

Func WriteDungeonSettings()
	Dim $i = 0
	Dim $val = 0

	For $i = 1 To UBound($DungeonNames) - 1
		If _GUICtrlListView_GetItemChecked($lvwDungeons, $i - 1) Then
			$val = 1
		Else
			$val = 0
		EndIf
		IniWrite($SettingsFile, "Dungeons", $DungeonNames[$i], $val)
	Next
EndFunc

Func ReadDungeonSettings()
	Dim $i = 0

	For $i = 1 To UBound($DungeonNames) - 1
		If IniRead($SettingsFile, "Dungeons", $DungeonNames[$i], "0") == 1 Then
			_GUICtrlListView_SetItemChecked($lvwDungeons, $i - 1)
		Else
			_GUICtrlListView_SetItemChecked($lvwDungeons, $i - 1, False)
		EndIf
	Next
EndFunc

Func UncheckAllDungeons()
	Dim $i = 0

	For $i = 0 To UBound($DungeonNames) - 2
		_GUICtrlListView_SetItemChecked($lvwDungeons, $i, False)
	Next
EndFunc

Func WriteDungeonListA($fileName = "DungeonList_Long.txt")
	If FileExists(@WorkingDir & "\" & $fileName) Then
		FileDelete(@WorkingDir & "\" & $fileName)
	EndIf

	Dim $file = FileOpen(@WorkingDir & "\" & $fileName, 2)
	Dim $i = 0
	For $i = 1 To (Ubound($DungeonNames) - 1)
		FileWriteLine($file, $DungeonNames[$i])
	Next
	FileClose($file)
EndFunc

Func WriteDungeonListB($fileName = "DungeonList_Wide.txt")
	If FileExists(@WorkingDir & "\" & $fileName) Then
		FileDelete(@WorkingDir & "\" & $fileName)
	EndIf
	Dim $s = ""

	Dim $file = FileOpen(@WorkingDir & "\" & $fileName, 2)
	Dim $i = 0
	For $i = 1 To (Ubound($DungeonNames) - 1)
		$s = $s & $DungeonNames[$i] & ", "
	Next
	FileWriteLine($file, $s)
	FileClose($file)
EndFunc

Func GetReadMe()
	Dim $file = FileOpen("README.txt")
	Dim $text = FileRead($file)
	FileClose($file)
	Return $text
EndFunc

Func SetComboHeight2($cmbHwnd, $itemsToDisplay)
	GUICtrlRecvMsg($cmbHwnd, $CB_SETMINVISIBLE, $itemsToDisplay)
EndFunc

Func SetComboHeight($cmbHwnd, $itemsToDisplay, $parentHwnd)
	;Get rectangles
	Dim $rctComboBox
	Dim $rctDropDown

	$rctComboBox = WinGetClientSize($cmbHwnd)
	;DropDownList rect
	$rctDropDown = GUICtrlRecvMsg($cmbHwnd, $CB_GETDROPPEDCONTROLRECT, 0, 2)

	;Get Item height
	Dim $itemHeight = GUICtrlRecvMsg($cmbHwnd, $CB_GETITEMHEIGHT, -1)

	;Converts coordinates
	Dim $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", $rctDropDown[0])
	DllStructSetData($tPoint, "Y", $rctDropDown[1])
	_WinAPI_ScreenToClient($parentHwnd, $tPoint)
	$rctDropDown[0] = DllStructGetData($tPoint, "X")
	$rctDropDown[1] = DllStructGetData($tPoint, "Y")
	DllStructSetData($tPoint, "X", $rctDropDown[2])
	DllStructSetData($tPoint, "Y", $rctDropDown[3])
	_WinAPI_ScreenToClient($parentHwnd, $tPoint)
	$rctDropDown[2] = DllStructGetData($tPoint, "X")
	$rctDropDown[3] = DllStructGetData($tPoint, "Y")

	;Set height
	$rctDropDown[3] = $rctDropDown[1] + 25 + ($itemHeight * $itemsToDisplay)

	;apply changes
	GUICtrlSetPos($cmbHwnd, $rctDropDown[0], $rctDropDown[1], $rctDropDown[2] - $rctDropDown[0], $rctDropDown[3])
EndFunc