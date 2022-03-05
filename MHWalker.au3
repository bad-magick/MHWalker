#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=assets/MHWalker.ico
#AutoIt3Wrapper_Outfile=bin/MHWalker.exe
#AutoIt3Wrapper_Outfile_x64=bin/MHWalker64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.0.0.32
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("GUICloseOnESC", 0)

Global $ProgramName = "MHWalker"
Global $Version = "0.935"
Dim $me = "[Class:AutoIt v3 GUI; Title:" & $ProgramName & "]"
Dim $wWindow = "[Class:Valve001; Title:Vindictus]"

#include <WinAPI.au3>
;#include <WinAPIEx.au3>
;#include <APIConstants.au3>
#include <Date.au3>
#include <Misc.au3>
#include <Sound.au3>
#include "CommandLine.au3"
#include "LogServer.au3"
#include "Utils.au3"

If Not Singleton("27b6391a73f524e5ca08238bca7de09100f38") Then
	If WinExists($me) Then
		WinActivate($me)
	ElseIf WinExists($wWindow) Then
		WinActivate($wWindow)
	EndIf
	Exit
EndIf

#include "InLineResources.au3"
_PayPalImage(True)	;must preceed the inclusion of GUI.au3
;_MHLogoIcon(True)
If Not FileExists(@TempDir & "\Alarm.wav") Then
	_Alarm(True)
EndIf
#include "Settings.au3"
$SettingsFile = $ProgramName & ".ini"
ReadSettings()
#include "GUI.au3"
#include "Battles.au3"
#include "Dungeons.au3"
#include "Comic.au3"
#include "Console.au3"
#include "FastPixel.au3"
#include "ErrorReport.au3"
#include "Donator.au3"
#include "EU.au3"
#include "NA.au3"
#include "Languages.au3"
#include "Mining.au3"
#include "Signatures.au3"
#include "DetectUI.au3"
#include "Premium.au3"

Global $Locked = True
Global $UseLang = "EN"
Global $Ticks = 0
Global $AverageTime = 0

Global $CurrentLocation = "Unknown"
Global $LastLocation = "Unknown"
Global $Difficulty = "Unknown"
Global $Errors = 0
Global $ErrorCondition = 0
Global $NextFix = "Unknown"
Global $Running = False
Global $DungeonID = "Unknown"
Global $DungeonVIP = False
Global $DungeonUnsupported = False
Global $PartySize = 0		;initialize in unknown state
Global $DungeonOathPos = 0
Dim $DungeonLocPos = 0
Dim $DungeonNumOaths = 0
Dim $DungeonEnhanced = False
Global $DungeonStartTime = 0
Global $Runs = 0
Global $Paused = False
Global $PauseAfterRun = False
Global $WaitingFor = ""
Global $hWindow = WinGetHandle($wWindow)
Global $numLogs = 0
Global $log[$SettingLogSize]
Dim $canLaunch = True
Dim $ExitApp = False
Dim $LogOpen = False
Dim $LogNoDisplay = False
Dim $MailMode = False
Dim $OathMode = False
Dim $OathModePos = 0
Dim $OathModeStarted = False
Dim $OathComplete = False
Dim $MiningMode = False
Dim $InMiningDungeon = False
Dim $MineTime = 0
Dim $LevelingMode = False
Dim $InLevelingDungeon = False
Dim $TrialCount = 0
Dim $Debug = False
Dim $Virgin = True
Dim $ErrorTimer = 0
Dim $ErrorTicks = 0
Dim $Spoken = False
Dim $WaitStates = True
Dim $BattleSliderLocation = 0
Dim $LastDungeon = ""
Dim $LogAltLocation = False
Dim $LogoutTimer = 0
Dim $WebServerActive = False
Dim $res[2]

Global $Skips = 0
Global $UseSkips = 0
Global $BossInProgress = False
Global $HotKeysSet = False

Dim $vinPID
Dim $vinHwnd
Dim $hCon

Dim $DungeonTempVar = 0
Dim $DoneVIPDungeon = False

AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseCoordMode", 2)

If (Not IsAdmin()) Then
	;this SHOULD never happen because of previous directives... just in case...
	MsgBox(0, $string_RequiresElevation, $string_YouMustRunThisProgramWithFullAdministratorPrivlidges)
	Exit
EndIf

;debug functions
If Not (@WorkingDir == "C:\Users\Den\Desktop\New Shit") Then
	$Locked = True
Else
	$Locked = False
	$CommandUnlock = 1
	$Debug = True
	WriteDungeonListA()
	WriteDungeonListB()
EndIf

SetGUITitle($ProgramName & " v" & $Version & " (" & $Edition & " Edition) by [MPGH]'s l2noob2")
AutoItSetOption("WinTitleMatchMode", 2)

;free trials of functions
If $CommandTrial == 1 Then
	$Locked = False
EndIf
If $CommandUnlock = 1 Then
	$Locked = False
EndIf

If $IsPremium Then InitPremium()

Dim $hImage
Dim $hIcon

Dim $PosY_ReturnToTown_6Party = 0
Dim $PosY_ReturnToTown_8Party = 0

While 1
	Do
		;/start?
		If $CommandAutoStart == 0 Then
			If $WebServerActive Then
				WebServerStop()
				$WebServerActive = False
			EndIf
			ShowGUI()
		Else
			$CommandAutoStart = 0 ;unflag to force gui next time through
		EndIf
		;check vindi window exists, terminate if not
		If Not WinExists($wWindow) Then
			Dim $ret
			$ret = MsgBox(1, "Where's Vindictus?", "I cannot find the Vindictus window. Launch Vindictus and try again.")
			If $ret == 2 Then
				Exit
			EndIf
		EndIf
	Until WinExists($wWindow)

	DetectConsole()
	If ($Debug) And ($Running) And (Not ($ConsoleName == "Hell_Demon[VIP Edition 4.0]")) Then
		DankSoleWriteDebug()
	EndIf
	fastPixelStartup()
	;$hImage = _GDIPlus_ImageLoadFromFile(@TempDir & "MH.ico")
	;_WinAPI_DeleteObject($hImage)
	;$hIcon = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

	;make sure settings are current, they should already be...
	QuerySettings()

	;setup vars about vindi window
	WinActivate($wWindow)
	$vinRes = WinGetClientSize($wWindow)
	$vinHwnd = WinGetHandle($wWindow)
	$OperationHwnd = $vinHwnd
	$vinCenter[0] = $vinRes[0] / 2
	$vinCenter[1] = $vinRes[1] / 2
	$res = $vinRes
	$ControlMode = $SettingNonWindowMode
	$ForceHwnd = $SettingForceOnLoseFocus
	;get EU going
	SetEU_NA()
	ComputeSignatures()

	;Start off on a good foot...
	UpdateClientPosition()
	SaveScreen()
	IdentifyDungeon(False)
	;log init
	If $SettingDeleteLogFile == 1 Then
		FileDelete($ProgramName & ".log")
	EndIf
	$LogOpen = True
	WriteLogFileHeader()
	WriteLog("Welcome to " & $ProgramName & " (" & $Edition & " Edition)!")
	If $IsDonator Then
		If GetSpecialMessage() == "" Then
			WriteLog("Thanks for donating, " & $DonatorName & ".")
		Else
			WriteLog("Special message from the developer:")
			WriteLog("        " & GetSpecialMessage())
		EndIf
	EndIf

	;start webserver
	If $WebServerOn == 1 Then
		If WebServerStart(@IPAddress1, $WebServerPort) Then
			WriteLog("Web server started on port " & $WebServerPort & ".")
			$WebServerActive = True
		Else
			WriteLog("Web server failed to start.")
		EndIf
	EndIf

	;EU setup
	If $SettingUseEU == 1 Then
		$SpeedMod = (1 / $EURunSpeedModifier)	;sleep multipier
		WriteLog("Running in EU Mode.")
	Else
		$SpeedMod = 1	;normal
		WriteLog("Running in NA Mode.")
	EndIf
	;console exists? warn if not
	If Not $ConsoleExists Then
		;dank will probably make ini mode come back someday... give a nice warning instead of terminating
		WriteLog("Unable to find console!")
		WriteLog("Please be sure that you have your binds set!")
	EndIf

	Dim $a = GetBattleInfo()
	$DungeonID = $a[0]
	$DungeonOathPos = $a[1]
	$Difficulty = $a[2]
	$BattleSliderLocation = $a[3]
	WriteDebug("BattleSliderLocation: " & $BattleSliderLocation)
	$PartySize = $a[4]
	$DungeonLocPos = $a[5]
	$DungeonNumOaths = $a[6]

	WriteLog("Please create your boat and press " & $KeyStart & " to begin, or")
	WriteLog("  go near the docks to reload the last dungeon ran.")

	While 1
		If ($WebServerOn == 1) And ($WebServerActive) Then
			WebServerLoop()
		EndIf
		Sleep(100)
		;exit?
		If $ExitApp Then
			$ExitApp = False
			_Send("{ALT UP}")
			KillLogWindow()
			ExitLoop
		EndIf
		;check vindi window
		If Not WinExists($wWindow) Then
			MsgBox(0, "Awww Snap!", "Vindictus window no longer found. Terminating program.")
			Exit
		EndIf
		If (Not WinActive($wWindow)) And (Not $Paused) And ($Running) And ($SettingOnLoseFocus == 1) Then
			WriteLog("Vindictus no longer foreground window.")
			$Paused = True
			WriteLog("Pausing...")
		EndIf

		UpdateClientPosition()
		SaveScreen()

		If ($CommandTrial == 1) And ($TrialCount >= 15) Then
			WriteLog("Your free trial has ended.")
			$MiningMode = False
			$Locked = True
			$CommandTrial = 0
		EndIf

		If (WinActive($wWindow)) And (Not $HotKeysSet) Then
			HotKeySet($KeyShutDown, "ShutDownApp")
			HotKeySet("{ALT}" & $KeyShutDown, "ShutDownApp")
			HotKeySet($KeyStart, "BeginMod")
			HotKeySet("{ALT}" & $KeyStart, "BeginMod")
			HotKeySet($KeyPause, "Pause")
			HotKeySet("{ALT}" & $KeyPause, "Pause")
			HotKeySet($KeyLegend, "ShowLegend")
			HotKeySet("{ALT}" & $KeyLegend, "ShowLegend")
			HotKeySet($KeyPauseAfterRun, "PauseAfterRun")
			HotKeySet("{ALT}" & $KeyPauseAfterRun, "PauseAfterRun")
			HotKeySet("{PRINTSCREEN}", "CreateErrorData")
			HotKeySet("{ALT}{PRINTSCREEN}", "CreateErrorData")
			HotKeySet("^x", "Kill")
			HotKeySet("!^x", "Kill")
			If $Debug Then
				HotKeySet("^i", "IdentifyDungeonDisplay")
			EndIf
			$HotKeysSet = True
		EndIf
		If (Not WinActive($wWindow)) And ($HotKeysSet) Then
			HotKeySet($KeyShutDown)
			HotKeySet("{ALT}" & $KeyShutDown)
			HotKeySet($KeyStart)
			HotKeySet("{ALT}" & $KeyStart)
			HotKeySet($KeyPause)
			HotKeySet("{ALT}" & $KeyPause)
			HotKeySet($KeyLegend)
			HotKeySet("{ALT}" & $KeyLegend)
			HotKeySet($KeyPauseAfterRun)
			HotKeySet("{ALT}" & $KeyPauseAfterRun)
			HotKeySet("{PRINTSCREEN}")
			HotKeySet("{ALT}{PRINTSCREEN}")
			HotKeySet("^x")
			HotKeySet("!^x")
			If $Debug Then
				HotKeySet("^i")
			EndIf
			$HotKeysSet = False
		EndIf

		If (Not $Running) And ($LogoutTimer <> 0) And ($SettingLogoutTime <> 0) Then
			If (_Date_Time_GetTickCount() - $LogoutTimer) > ($SettingLogoutTime * 60000) Then
				WriteLog("Timer has elapsed. Starting logout procedure.")
				$LogoutTimer = 0
				Logout()
			EndIf
		EndIf

		If ($Running) And (Not $Paused) And ((Not HasError()) And ($ErrorCondition == 0)) Then
			If HasDeadScreen() Then
				WriteLog("Oh shit! You're dead.")
				ClearDeadScreen()
				$WaitingFor = "Battle Failed"
			EndIf

			Select
				Case $WaitingFor == "Start"
					If $MailMode Then
						$WaitingFor = "Boat"
					Else
						$ErrorCondition = 1
						$NextFix = "Identify Location"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
				Case $WaitingFor == "Dungeon"
					If HasHPBar() Then
						If $UseSkips > 0 Then
							$UseSkips -= 1
							WriteLog("Skipping current map, " & $UseSkips & " skips remaining.")
							SkipToBoss(1)
						Else
							If $InMiningDungeon Then
								WriteLog("Starting mining procedure.")
								$WaitingFor = "Mining"
							ElseIf $LevelingMode Then
								WriteLog("Starting kill procedure.")
								$WaitingFor = "Leveling"
							ElseIf (Not $LevelingMode) And ($InLevelingDungeon) Then
								SkipToBoss(1)
								$WaitingFor = "Dungeon"
							Else
								WriteLog("Arrived at boss room.")
								WriteLog("Waiting for boss room preperation.")
								$WaitingFor = "BossRoom"
							EndIf
						EndIf
					;ElseIf CheckBoat() Then		;still on the boat, something went wrong
					;	WriteLog("Incorrect command sent from server...")
					;	$ErrorCondition = 1
					;	$Errors += 1
					;	$NextFix = "Leave Party"
					EndIf
				Case $WaitingFor == "Mining"
					If $MiningMode Then
						If (_Date_Time_GetTickCount() - $DungeonStartTime) <  $DelayMiningTime Then ;under 55 minutes?
							If $Runs <> 0 Then
								$AverageTime = ((_Date_Time_GetTickCount() - $Ticks) / 1000) / $Runs
							EndIf
							RunMining()
							$WaitingFor = "DropCollection"
						Else
							WriteLog("Dungeon will expire soon.")
							Forfeit()
							$WaitingFor = "MiningForfeit"
						EndIf
					Else
						Forfeit()
						Begin(True)
					EndIf
				Case $WaitingFor == "MiningForfeit"
					If CheckTown() Then
						ReloadBoat()
						$WaitingFor = "Boat"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
				Case $WaitingFor == "DropCollection"
					CollectDrops(20)
					$TrialCount += 1
					If ($DungeonVIP) And (Not $IsDonator) Then
						$DoneVIPDungeon = True
						Forfeit()
						Begin(True)
					EndIf
					If $MiningMode Then
						ReloadMap()
						$WaitingFor = "Dungeon"
					Else
						Forfeit()
						Begin(True)
					EndIf
				Case $WaitingFor == "Leveling"
					If $Runs <> 0 Then
						$AverageTime = ((_Date_Time_GetTickCount() - $Ticks) / 1000) / $Runs
					EndIf
					RunLeveling()
					ReloadMap()
					$WaitingFor = "Dungeon"
				Case $WaitingFor == "BossRoom"
					RunDungeon()
					If $WaitingFor <> "Town" Then
						$WaitingFor = "BattleClearedWorking"
						If $SettingUseEU == 1 Then
							WriteLog("Waiting for Battle Cleared.")
						Else
							WriteLog("Waiting for Battle Cleared.")
						EndIf
					EndIf
				Case $WaitingFor == "BattleStats"
					If HasBattleStats() Then
						Dim $count = 0
						Do
							NextPage()
							Sleep(500)
							$count += 1
						Until (Not HasBattleCleared()) Or ($count >= 5)
						If ($count >= 5) Then
							WriteLog("I've clicked several times. Taking corrective action.")
							$ErrorCondition = 1
							$NextFix = "Identify Location"
							$ErrorTimer = _Date_Time_GetTickCount()
						Else
							$WaitingFor = "BattleCleared"
							WriteLog("Waiting for Battle Cleared (Page 2).")
						EndIf
					Else
						If HasBattleClearedBox() Then
							ClickArray("left", $click_BattleClearedCenter)	;click center battle cleared
							Sleep(100)
						EndIf
					EndIf
					If ($WaitingFor == "BattleStats") And ($ErrorCondition <> 1) Then
						If (_Date_Time_GetTickCount() - $DungeonStartTime) >= $DelayDungeonComplete Then
							WriteLog("Dungeon is taking longer than it should.")
							Forfeit()
						EndIf
					EndIf
				Case $WaitingFor = "BattleClearedWorking"
					If HasBattleClearedWorking() Or HasBattleClearedBox() Then
						If $SettingFastBattleCleared == 1 Then
							ToggleRateStatic()
						EndIf
						If $SettingUseEU == 1 Then
							WriteLog("Waiting for Battle Cleared (Page 1).")
							$WaitingFor = "BattleStats"
						Else
							$WaitingFor = "BattleCleared"
						EndIf
					Else
						RunDungeon()
					EndIf
					If $WaitingFor == "BattleClearedWorking" Then
						If (_Date_Time_GetTickCount() - $DungeonStartTime) >= $DelayDungeonComplete Then
							WriteLog("Dungeon is taking longer than it should.")
							Forfeit()
						EndIf
					EndIf
				Case $WaitingFor == "BattleCleared"
					If HasBattleCleared() Then
						If $SettingFastBattleCleared == 1 Then
							ToggleRateStatic()
						EndIf
						$BossInProgress = False
						BossRoomDone()
						$Runs += 1
						WriteLog("Completed run #" & $Runs)
						WriteLog("Replaying.")
						Dim $count = 0
						Do
							Replay()
							Sleep(2000)
							$count += 1
						Until (Not HasBattleCleared()) Or ($count >= 5)
						If ($count >= 5) Then
							WriteLog("I've clicked several times. Taking corrective action.")
							$ErrorCondition = 1
							$NextFix = "Identify Location"
							$ErrorTimer = _Date_Time_GetTickCount()
						Else
							If (Not $OathMode) Then
								$WaitingFor = "Boat"
								WriteLog("Waiting for boat launch screen.")
								If $PauseAfterRun Then
									Pause()
									$PauseAfterRun = False
								EndIf
							Else
								$OathComplete = True
								$WaitingFor = "Town"
								WriteLog("Waiting to be returned to town.")
							EndIf
						EndIf
					ElseIf HasBattleClearedBox() Then
						ClickArray("left", $click_BattleClearedCenter)	;click center battle cleared
						Sleep(100)
					ElseIf (_Date_Time_GetTickCount() - $DungeonStartTime) >= $DelayDungeonComplete Then
						WriteLog("Dungeon is taking longer than it should.")
						Forfeit()
					EndIf
				Case $WaitingFor == "Clear Mail Page"
					$DungeonStartTime = _Date_Time_GetTickCount()
					MailGetPage()
					$Runs += 1
					$WaitingFor = "Boat"
				Case $WaitingFor == "Boat"
					$canLaunch = True
					If $MailMode Then
						If $MerchantOn == 1 Then
							If (Mod($Runs, $MerchantRuns) == 0) And ($Runs <> 0) Then
								WriteLog("Selling items.")
								MerchantItems()
								Sleep(500)
							Else
								WriteLog("Selling items in " & ($MerchantRuns - Mod($Runs, $MerchantRuns)) & " more runs.")
							EndIf
						EndIf
						$WaitingFor = "Clear Mail Page"
						ContinueLoop
					EndIf
					If CheckBoat() Then
						;get rid of windows if necessary
						RemoveBoatWindows()
						If $Runs <> 0 Then
							$AverageTime = ((_Date_Time_GetTickCount() - $Ticks) / 1000) / $Runs
							WriteLog("Run completed in " & ((_Date_Time_GetTickCount() - $DungeonStartTime) / 1000) & " secs.")
						EndIf
						If $SettingSpendAP == 1 Then
							If (Mod($Runs, $SettingSpendAPRuns) == 0) And ($Runs <> 0) Then
								WriteLog("Spending AP.")
								SpendAP()
								Sleep(500)
							Else
								WriteLog("Spending AP in " & ($SettingSpendAPRuns - Mod($Runs, $SettingSpendAPRuns)) & " more runs.")
								WriteLog("Spending AP in " & ($SettingSpendAPRuns - Mod($Runs, $SettingSpendAPRuns)) & " more runs.")
							EndIf
						EndIf
						RemoveBoatWindows()
						If $MerchantOn == 1 Then
							If (Mod($Runs, $MerchantRuns) == 0) And ($Runs <> 0) Then
								WriteLog("Selling items.")
								MerchantItems()
								Sleep(500)
							Else
								WriteLog("Selling items in " & ($MerchantRuns - Mod($Runs, $MerchantRuns)) & " more runs.")
							EndIf
						EndIf
						RemoveBoatWindows()
						$i = 0
						Do
							;refresh the in-memory screenshot
							SaveScreen()
							IdentifyDungeon()
							;if mining, overwrite identity
							If $MiningMode Then
								IdentifyMining()
							EndIf
							If $LevelingMode Then
								IdentifyLeveling()
							EndIf
							If $DungeonID <> "Unknown" Then
								ExitLoop
							EndIf
							If $DungeonID == "Unknown" Then
								Sleep(1000)
							EndIf
							$i += 1
						Until ($DungeonID <> "Unknown") Or ($i >= $SettingIdentifyAttempts)
						If $DungeonID == "Unknown" Then
							WriteLog("Unable to identify dungeon. Aborting!")
							Begin(True)
							$WaitingFor = ""
						ElseIf $DungeonUnsupported == 1 Then
						Else
							If ($OathMode) And (Not $OathModeStarted) Then
								RefreshBattleInfo()
								Sleep(500)
								WriteLog("Returning to town.")
								LeaveParty()
								$WaitingFor = "Town"
							Else
								If $OathMode Then
									WriteLog("Running oath " & $OathModePos & " of " & $DungeonNumOaths & ".")
								EndIf
								If (HasTimeScaleSet($DungeonID)) And $SettingUseTimeHack Then
									$SettingHostTimeScaleUse = $SettingHostTimeScale / (5 / 4)							;ADD ADVANCED OPTION
									WriteLog("This dungeon is in super-de-duper fast mode.")
								Else
									$SettingHostTimeScaleUse = 1
								EndIf
								If ($SettingMaxRuns <> 0) Then
									If ($SettingMaxRuns == $Runs) Then
										WriteLog("Run limit reached!")
										Begin(True)
										$WaitingFor = ""
										$canLaunch = False
									Else
										WriteLog(($SettingMaxRuns - $Runs) & " runs remaining.")
									EndIf
								EndIf
								If ((Not $IsDonator) And ($DungeonVIP) And (Not $DoneVIPDungeon)) Then
									If (Not $IsDonator) And (Not $DoneVIPDungeon) Then
										$DoneVIPDungeon = True
										WriteLog("This is a VIP map.")
										WriteLog("You may only run a VIP map once per program start.")
									EndIf
								ElseIf (Not $IsDonator) And ($DungeonVIP) And ($DoneVIPDungeon) Then
									WriteLog("You have already run a VIP dungeon.")
									$canLaunch = False
									Begin(True)
									$WaitingFor = ""
								EndIf
								If $canLaunch Then
									;If ($DungeonID <> $LastDungeon) Then
									RefreshBattleInfo()
									;EndIf
									LaunchBoat()
									$UseSkips = $Skips
									$WaitingFor = "Dungeon"
									WriteLog("Waiting for dungeon to load.")
									Sleep(1000)
								EndIf
							EndIf
						EndIf
					ElseIf CheckGlitchedTownOrBoat() Or CheckTown() Then
						$ErrorCondition = 1
						$NextFix = "Leave Party"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
				Case $WaitingFor == "Town"
					If CheckTown() Then
						$ErrorCondition = 1
						$NextFix = "Leave Party"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
				Case $WaitingFor == "Battle Failed"
					If HasBattleFailed() Then
						ClickArray("left", $click_BattleFailedReplay)	;click Replay
						$BossInProgress = False
						$DungeonTempVar = 0
						$WaitingFor = "Boat"
						Sleep(1000)
					EndIf
			EndSelect
		EndIf
		If ($Running) And ($ErrorCondition == 1) And (Not $Paused) And (Not HasError()) Then
			Select
				Case $NextFix == "Login"
					If ($LoginUserID <> "") And ($LoginPassword <> "") Then
						Login($LoginUserID, $LoginPassword, $LoginServer)
						$NextFix = "LoginWaitChars"
					Else
						WriteLog("Cannot log you back in. I don't have the login info.")
						Begin(True)
					EndIf
				Case $NextFix == "LoginBox"
					If ($LoginUserID <> "") And ($LoginPassword <> "") Then
						ClickArray("left", $click_LoginStartGame)	;click Start Game
						Sleep(1000)
						Login($LoginUserID, $LoginPassword, $LoginServer)
						$NextFix = "LoginWaitChars"
					Else
						WriteLog("Cannot log you back in. I don't have the login info.")
						Begin(True)
					EndIf
				Case $NextFix == "LoginWaitChars"
					If (fastPixelGetColor($vinRes[0] - 140, 70) < 0x100000) Then	;First Character Button	;refactor
						LoginChar($LoginCharIndex)
						Sleep(2000)
						ClickArray("left", $click_LoginStart)	;click Start
						$NextFix = "WaitTown"
					EndIf
				Case $NextFix == "WaitTown"
					Dim $pixel1 = fastPixelGetColor(113, 22)	;Exit / Open Mailbox	;refactor
					Dim $pixel2 = fastPixelGetColor(264, 22)	;Exit					;refactor
					If (HasChatBox()) And (Not HasHPBar()) And (Not HasAvatarShop()) And (fastPixelGetColor(62, $vinRes[1] - 72) < 0x100000) And (IsColorMatch($pixel1, 0x34494F)) Then
						SetEU_NA()
						If IsColorMatch($pixel2, 0x394D5A) Then ;refactor
							WriteLog("Don't mind me, I'm busy staring at Tieve's boobs.")
							ClickArray("left", $click_BuildingButton2)	;Click Exit at Inn
						Else
							WriteLog("Let's bang Blawynn while we're here.")
							ClickArray("left", $click_BuildingButton1)	;Click Exit at Dormatory
						EndIf
						$ErrorTimer = _Date_Time_GetTickCount()
						$NextFix = "Force Town Wait"
					EndIf
				Case $NextFix == "Leave Party Force Reload"
					LeaveParty()
					$NextFix = "PartyLeaveWaitForceReload"
				Case $NextFix == "PartyLeaveWaitForceReload"
					If (Not HasParty()) Then ; And (Not HasChatBox()) Then
						$NextFix = "Reload Boat"
					EndIf
				Case $NextFix == "Leave Party"										;leave the current party
					LeaveParty()
					$NextFix = "PartyLeaveWait"
					$ErrorTimer = _Date_Time_GetTickCount()
				Case $NextFix == "PartyLeaveWait"									;wait for successful party drop
					If (_Date_Time_GetTickCount() - $ErrorTimer) >= $DelayLeavePartyWaitMax Then
						WriteLog("Taking too long to leave party.")
						$NextFix = "Identify Location"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
					If (HasAvatarShop()) And (Not HasParty()) Then ;And (Not HasChatBox()) Then
						$NextFix = "Reload Boat"
					EndIf
				Case $NextFix == "Check Boat"										;check boat for errors
					WriteLog("Checking boat for errors.")
					If CheckBoat() Then					;boat ok
						$ErrorCondition = 0
						$NextFix = ""
						$WaitingFor = "Boat"
						$BossInProgress = False
					Else								;boat NOT ok
						WriteLog("Found glitched boat.")
						WriteLog("Returning to town.")
						$NextFix = "Leave Party"
					EndIf
				Case $NextFix == "Reload Boat"										;select battle quest from menu
					WriteLog("Reloading boat.")
					If ReloadBoat() Then
						Sleep(500)
						$NextFix = "Reload Wait"
						$ErrorTimer = _Date_Time_GetTickCount()
					Else
						$ErrorCondition = 0
						$WaitingFor = "Boat"
						Begin(True)
					EndIf
				Case $NextFix == "Reload Wait"										;wait for boat to load
					If (_Date_Time_GetTickCount() - $ErrorTimer) >= $DelayMakeBoatWaitMax Then
						WriteLog("Taking to long to make a boat.")
						$NextFix = "Identify Location"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
					If (Not HasBoatBeingPrepared() And HasHPBar()) Then
						Sleep(1000)	;make sure it's not just a early accidental detection
						$NextFix = "Reload Wait 2"
					EndIf
				Case $NextFix == "Reload Wait 2"
					If (Not HasBoatBeingPrepared() And HasHPBar()) Then
						Sleep(1000)	;make sure it's not just a early accidental detection x2
						$NextFix = "Reload Wait 3"
					EndIf
				Case $NextFix == "Reload Wait 3"
					If (Not HasBoatBeingPrepared() And HasHPBar()) Then
						$NextFix = "Check Boat"
						Sleep(500)	;extra wait state
					EndIf
				Case $NextFix == "Force Town"										;clear empty battle cleared
					WriteLog("Forcing reload to Colhen.")
					_Send($BindColhan)
					Sleep(1000)
					If (Not HasHPBarLive()) Then
						$NextFix = "Force Town Wait"	;wait for respawn
						$ErrorTimer = _Date_Time_GetTickCount()
					Else
						$NextFix = "Leave Party"		;already in colhen
					EndIf
				Case $NextFix == "Force Town Wait"									;wait for character respawn
					If (_Date_Time_GetTickCount() - $ErrorTimer) >= $DelayToTownWaitMax Then
						WriteLog("I guess the carriage is broken.")
						$NextFix = "Identify Location"
						$ErrorTimer = _Date_Time_GetTickCount()
					EndIf
					If CheckTown() Then
						$NextFix = "Leave Party"
					EndIf
				Case $NextFix == "Identify Location"
					KillLogWindow()
					Select
						Case ((_Date_Time_GetTickCount() - $ErrorTimer) >= $DelayErrorWait)
							WriteLog("Timer has elapsed.")
							If ($SettingLogout == 0) Then
								WriteLog("I have no idea where the fuck I am.")
								Begin(True)
							Else
								Logout()
								$ErrorTimer = _Date_Time_GetTickCount()
								WriteLog("Waiting on login screen.")
							EndIf
						Case CheckTown()
							WriteLog("You're in town.")
							$NextFix = "Leave Party"
						Case CheckBoat()
							WriteLog("You're on a dock.")
							$NextFix = "Check Boat"
						Case HasLoginBox()
							WriteLog("Still trying to log in.")
							$NextFix = "LoginBox"
						Case CheckGlitchedTownOrBoat()
							WriteLog("One foot in town, one on a boat.")
							$NextFix = "Leave Party"
						Case CheckTownBattleStatsGlitch()	;very rare glitch
							WriteLog("Battle Cleared in town glitch.")
							$NextFix = "Force Town"
						Case HasBattleCleared()	;must be before battle stats
							WriteLog("Battle Cleared screen detected.")
							$ErrorTimer = _Date_Time_GetTickCount()
							$ErrorCondition = 0
							$WaitingFor = "BattleCleared"
						Case HasBattleStats()
							WriteLog("Battle Cleared (Page 1) detected.")
							$ErrorTimer = _Date_Time_GetTickCount()
							$ErrorCondition = 0
							$WaitingFor = "BattleStats"
						Case HasEmptyBattleCleared()
							WriteLog("Empty Battle Cleared screen detected.")
							$ErrorTimer = _Date_Time_GetTickCount()
							$WaitingFor = "Boat"
							$ErrorCondition = 0
						Case HasLoginScreen()
							WriteLog("You're at the login screen.")
							$NextFix = "Login"
					EndSelect
			EndSelect
		EndIf
		If ($Running) And (HasError()) And (Not $Paused) Then
			$Errors += 1
			$ErrorCondition = 1
			WriteLog("Error detected!")
			;WriteLog("Waiting " & ($DelayErrorWait / 1000) & " seconds before taking action.")
			;Sleep($DelayErrorWait)
			WriteLog("Attempting to resolve error condition.")
			WriteLog("Clearing error boxes.")
			Dim $count = 0
			Do
				_Send("{ALT DOWN}")
				Sleep(200)
				_MouseClick("left", $vinCenter[0] - 2, $vinCenter[1] + 64, 1, $SettingMouseSpeed)
				_Send("{ALT UP}")
				Sleep(2000)
				$count += 1
			Until (Not HasErrorLive()) Or ($count >= 5)
			WriteLog("Let's see where we end up...")
			WriteLog("This could take a bit. (Up to " & ($DelayErrorWait / 1000) & " secs)")
			$ErrorTimer = _Date_Time_GetTickCount()
			$NextFix = "Identify Location"
		EndIf
		If ($Running) And ($WaitingFor == "Boat") And (HasEmptyBattleCleared()) And (Not $Paused) Then
			WriteLog("Server lag on dungeon replay detected.")
			WriteLog("Waiting up to " & ($DelayToTownLag / 1000) & " seconds.")
			Dim $timer = $DelayToTownLag
			Do
				Sleep(100)
				$timer -= 100
			Until ($timer <= 0) Or (Not HasEmptyBattleClearedLive())
			If HasEmptyBattleClearedLive() Then
				$Errors += 1
				$ErrorCondition = 1
				WriteLog("Attempting to resolve error condition.")
				$NextFix = "Force Town"
				Sleep(500)		;wait state to prevent duplicate triggers
			Else
				WriteLog("Server lag cleared after " & (($DelayToTownLag - $timer) / 1000) & " seconds.")
			EndIf

		EndIf

	WEnd
	fastPixelShutdown()
	_WinAPI_DeleteObject($hIcon)
	HotKeySet($KeyShutDown)
	HotKeySet($KeyStart)
	HotKeySet($KeyPause)
	HotKeySet($KeyLegend)
	HotKeySet($KeyPauseAfterRun)
	HotKeySet("{PRINTSCREEN}")
	HotKeySet("^x")
	$HotKeysSet = False
	$LogOpen = False
	$Running = False
	$Paused = False
	$WaitingFor = ""
	$ErrorCondition = 0
	$NextFix = ""
WEnd

Func CreateErrorData()
	Dim $s = GetNextErrorIndex()
	Dim $dataFile = @WorkingDir & "\Error Reports\Data" & $s & ".txt"
	Dim $shotFile = @WorkingDir & "\Error Reports\Shot" & $s & ".bmp"
	Dim $setsFile = @WorkingDir & "\Error Reports\" & $ProgramName & ".ini"
	SaveScreenCapture($shotFile, $vinClient[0], $vinClient[1], $vinClient[0] + $vinRes[0], $vinClient[1] + $vinRes[1])
	SaveData($dataFile, $Edition, $WaitingFor, $ErrorCondition, $NextFix, $OathMode, $MiningMode, $MailMode, $BattleSliderLocation, $SettingUseEU)
	FileCopy(@WorkingDir & "\" & $ProgramName & ".ini", $setsFile)
	IniWrite($setsFile, "Login", "UserID", "REMOVED")
	IniWrite($setsFile, "Login", "Pass", "REMOVED")
	IniWrite($setsFile, "Login", "Server", "REMOVED")
	IniWrite($setsFile, "Login", "Char", "REMOVED")
	IniWrite($setsFile, "WebServer", "Use", "REMOVED")
	IniWrite($setsFile, "WebServer", "Port", "REMOVED")
	BuildReport($s, $shotFile, $dataFile, $setsFile)
	FileDelete($shotFile)
	FileDelete($dataFile)
	FileDelete($setsFile)

	WriteLog("Debug data written to disk.")

	;pass the message
	HotKeySet("{PRINTSCREEN}")
	Send("{PRINTSCREEN}")
	HotKeySet("{PRINTSCREEN}", "CreateErrorData")
EndFunc

Func Logout()
	ClickArray("left", $click_SystemMenuOpen)
	Sleep(1000)
	ClickArray("left", $click_SystemMenuLogout)
	Sleep(1000)
	ClickArray("left", $click_OkOkCancel)
	WriteLog("Logout procedure completed at " & @HOUR & ":" & @MIN & ":" & @SEC & ".")
EndFunc

Func HasPageClear ()
	Dim $y = 0

	For $y = 1 To 9
		If IsColorMatch(PixelGetColor(396, ($y * 34) + 95), 0x84614A) Then	;refactor
			Return False
		EndIf
	Next
	Return True
EndFunc

Func MailClearError()
	If HasErrorLive() Then
		ClickArray("left", $click_OkOnly)
		Do
			Sleep(250)
		Until (Not HasError())
	EndIf
EndFunc

Func HasNoMail()
	Dim $y = 0

	For $y = 1 To 9
		If (IsColorMatch(fastPixelGetColor(396, ($y * 34) + 95), 0x84614A)) Or  (IsColorMatch(fastPixelGetColor(396, ($y * 34) + 95), 0xDED3AD)) Then	;refactor
			Return False
		EndIf
	Next
	Return True
EndFunc

Func MailGetPage()
	WriteDebug("Starting get page.")
	If (Not HasSignature($sig_WindowMailbox)) Then
		OpenWindowMailbox()
	EndIf
	SaveScreen()
	If HasNoMail() Then
		WriteLog("Mailbox empty, mail mode complete.")
		If (HasSignature($sig_WindowMailbox)) Then
			OpenWindowMailbox()
		EndIf
		SetMailMode()
		Begin(True)
	EndIf
	Dim $y = 0
	Dim $px = 0
	Dim $count = 0
	If (Not HasNoMail()) Then
		_Send("{ALT DOWN}")
		Sleep(200)
		Do
			SaveScreen()
			For $y = 1 To 9
				MailClearError()
				$px = fastPixelGetColor(396, ($y * 34) + 95)
				If IsColorMatch($px, 0x84614A) Then
					MailClearError()
					_MouseClick("left", 396, ($y * 34) + 95, 1, 3)
					Sleep(50)
					SaveScreen()
				EndIf
			Next
		Until HasPageClear()
		SaveScreen()
		;If (Not HasNoMail()) Then
			_MouseClick("left", 53, 99, 1, $SettingMouseSpeed)
			_MouseClick("left", 380, 439, 1, $SettingMouseSpeed)
			Do
				Sleep(100)
				$count += 1
			Until (HasOkButtonLive() Or ($count >= 50))
			If HasOkButtonLive() Then
				ClickOk()
			EndIf
		;EndIf
		_Send("{ALT UP}")
		WriteDebug("Done page.")
	EndIf
EndFunc

Func MerchantItems()
	If Not $IsDonator Then
		WriteLog("This function requires VIP Edition.")
		Return
	EndIf
	If $MerchantOn == 1 Then
		$LogAltLocation = True
		WriteLog("Beginning auto-sell function.")
		;open npc store
		OpenWindowShop()
		SaveScreen()
		Dim $chest = 0
		Dim $x = 0
		Dim $y = 0
		Dim $count = 0
		For $chest = 2 To 9
			If (IsColorMatch(fastPixelGetColor($vinRes[0] - 334, 45 + ($chest * 40)), 0x817665)) Or (IsColorMatch(fastPixelGetColor($vinRes[0] - 334, 45 + ($chest * 40)), 0x865E58)) And ($MerchantChests[$chest - 2] == 1) Then	;check for valid chest
				MerchantClearError()
				_Send("{ALT DOWN}")
				Sleep(200)
				_MouseClick("left", $vinRes[0] - 334, 45 + ($chest * 40), 5, $SettingMouseSpeed)
				_Send("{ALT UP}")
				Sleep(1000)
				SaveScreen()
				WriteLog("Selling contents of chest " & $chest & ".")
				$y = 0
				For $y = 1 To 8
					MerchantClearError()
					$x = 0
					For $x = 1 To 6
						MerchantClearError()
						;check for empty slot
						MerchantClearError()
						If Not HasSignature($sig_WindowShop) Then
							OpenWindowShop()
						EndIf
						SaveScreen()
						If (fastPixelGetColor($vinRes[0] - 315 + (43 * $x), 64 + (43 * $y)) > 0x100000) And (fastPixelGetColor($vinRes[0] - 317 + (43 * $x), 66 + (43 * $y)) > 0x100000) And (fastPixelGetColor($vinRes[0] - 316 + (43 * $x), 65 + (43 * $y)) > 0x100000) Then
							Dim $thisPixel = fastPixelGetColor($vinRes[0] - 315 + (43 * $x), 64 + (43 * $y))
							If (IsColorMatch($thisPixel, 0x794821)) And ($MerchantNoScrolls == 1) Then
								WriteLog("Skipping possible scroll: Chest " & $chest & " - " & $x & "x" & $y)
							ElseIf (IsColorMatch($thisPixel, 0xE86573)) And ($MerchantNoEmpowered == 1) Then
								WriteLog("Skipping possible empowered stone: Chest " & $chest & " - " & $x & "x" & $y)
							ElseIf (IsColorMatch($thisPixel, 0x7164AC)) And ($MerchantNoEpic == 1) Then
								WriteLog("Skipping possible epic stone: Chest " & $chest & " - " & $x & "x" & $y)
							ElseIf (IsColorMatch($thisPixel, 0x8B7451)) And ($MerchantNoMagicPowder == 1) Then
								WriteLog("Skipping possible magic powder: Chest " & $chest & " - " & $x & "x" & $y)
							ElseIf (IsColorMatch($thisPixel, 0x9A5F12)) And ($MerchantNoBlessedPowder == 1) Then
								WriteLog("Skipping possible blessed magic powder: Chest " & $chest & " - " & $x & "x" & $y)
							Else
								WriteLog("Selling Item: Chest " & $chest & " - " & $x & "x" & $y)
								_Send("{ALT DOWN}")
								Sleep(200)
								_MouseMove($vinRes[0] - 325 + (43 * $x), 76 + (43 * $y), $SettingMouseSpeed)
								Sleep(100)
								_MouseClick("right", $vinRes[0] - 325 + (43 * $x), 76 + (43 * $y), 5, $SettingMouseSpeed)
								_Send("{ALT UP}")
								$count = 0
								Do
									Sleep(100)
									$count += 1
								Until (IsColorMatch(PixelGetColor($vinCenter[0] - 52, $vinCenter[1] + 65), 0x000000)) Or (HasErrorLive()) Or ($count >= 50)
								If HasErrorLive() Then
									_Send("{ALT DOWN}")
									Sleep(200)
									WriteLog("Item sale failed.")
									_MouseClick("left", $vinCenter[0], $vinCenter[1] + 65, 1, $SettingMouseSpeed)
									_Send("{ALT UP}")
								ElseIf ($count >= 50) Then
									WriteLog("Something went wrong, skipping item.")
								Else
									_Send("{ALT DOWN}")
									Sleep(200)
									_MouseMove($vinCenter[0] - 53, $vinCenter[1] + 64, $SettingMouseSpeed)
									Sleep(200)
									$count = 0
									_MouseClick("left", $vinCenter[0] - 53, $vinCenter[1] + 64, 1, $SettingMouseSpeed)
									_Send("{ALT UP}")
									Do
										Sleep(100)
										$count += 1
									Until (Not IsColorMatch(PixelGetColor($vinCenter[0] - 52, $vinCenter[1] + 65), 0x000000)) Or ($count >= 50)
									If ($count >= 50) Then
										WriteLog("Something went wrong, skipping item.")
									EndIf
								EndIf
								MerchantClearError()
							EndIf
						EndIf
					Next
				Next
			Else
				;WriteLog("Skipping chest " & $chest & ".")
			EndIf
		Next

		$LogAltLocation = False
		;close npc store
		RemoveBoatWindows()
		MerchantClearError()
		WriteLog("Auto-sell function completed.")
	EndIf
EndFunc

Func MerchantClearError()
	If HasError() Then
		_Send("{ALT DOWN}")
		Sleep(200)
		_MouseClick("left", $vinCenter[0], $vinCenter[1] + 65, 1, $SettingMouseSpeed)
		_Send("{ALT UP}")
	EndIf
EndFunc

Func ChangeChannel()
	If Not $SettingChangeChannel Then
		Return False
	EndIf
	Dim $count = 0
	Dim $channel = Random($SettingChannelMin, $SettingChannelMax, 1)
	Do
		_Send("{ALT DOWN}")
		Sleep(200)
		_MouseClick("left", $vinRes[0] - 49, 21, 1, $SettingMouseSpeed)	;click
		Sleep(200)
		_Send("{ALT UP}")
		$count += 1
		Sleep(1000)
	Until (IsColorMatch(PixelGetColor($vinCenter[0] - 26, $vinCenter[1] + 67), 0x000000)) Or ($count >= 3)	;OK button?
	If $count >= 3 Then
		WriteLog("Change channel failed.")
		Return False
	EndIf
	Dim $a = StringSplit(String($channel), "")
	Dim $i = 0
	For $i = 1 To $a[0]
		_Send($a[$i], 1)
		Sleep(300)
	Next
	$count = 0
	Do
		_Send("{ALT DOWN}")
		Sleep(200)
		_MouseClick("left", $vinCenter[0] - 26, $vinCenter[1] + 64, 1, $SettingMouseSpeed)
		Sleep(200)
		_Send("{ALT UP}")
		$count += 1
		Sleep(1000)
	Until ((Not IsColorMatch(PixelGetColor($vinCenter[0] -26, $vinCenter[1] + 64), 0x000000))) Or ($count >= 3)
	If $count >= 3 Then
		WriteLog("Change channel failed.")
		Send("{ESC}")
		Return False
	EndIf
	Sleep(3000)
	WriteLog("Changed to channel " & $channel & ".")
EndFunc

Func RemoveBoatWindows ()
	_Send($BindCloseWindow)
	Sleep(200)
	_Send($BindCloseWindow)
	Sleep(200)
	_Send($BindCloseAlchemy)
	Sleep(200)
EndFunc

Func RefreshBattleInfo()
	WriteLog("Getting dungeon location on battle list.")
	OpenWindowBattle()
	$BattleSliderLocation = GetBattleSliderLocation()
	WriteDebug("BattleSliderLocation: " & $BattleSliderLocation)
	RemoveBoatWindows()
	$LastDungeon = $DungeonID
	SaveBattleInfo($DungeonID, $DungeonOathPos, $Difficulty, $BattleSliderLocation, $PartySize, $DungeonLocPos, $DungeonNumOaths)
EndFunc

Func SetBattleSliderLocation()
	WriteDebug("BattleSliderLocation: " & $BattleSliderLocation)
	If $BattleSliderLocation <> 0 Then
		Dim $y
		Do
			WriteDebug("Attempting to set battle slider.")
			$y = GetBattleSliderLocation($coord_SliderCreateParty)
			If $y <> 0 Then
				MouseClickDrag("left", $coord_SliderCreateParty, $y - 12, $coord_SliderCreateParty, $BattleSliderLocation - 12, $SettingMouseSpeed * 4)
			EndIf
		Until (GetBattleSliderLocation($coord_SliderCreateParty) == $BattleSliderLocation) Or ($y == 0)
	EndIf
EndFunc

Func GetBattleSliderLocation ($y = -1)
	If ($y == -1) Then
		$y = $coord_SliderBattleWindow
	EndIf
	Dim $i = 0
	Send("{ALT DOWN}")
	MouseMove(0, 0, 0)
	SaveScreen()
	For $i = $range_Slider[0] To $range_Slider[1] Step -1
		If IsColorMatch(fastPixelGetColor($y, $i), $color_SliderBottom) Then
			Send("{ALT UP}")
			Return $i
		EndIf
	Next
	Send("{ALT UP}")
	WriteLog("Unable to get dungeon info.")
	Return 0
EndFunc

Func CheckTownBattleStatsGlitch ()
	If (HasAvatarShop() And HasBattleStats()) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasOkButtonLive()
	If IsColorMatch(PixelGetColor($vinCenter[0] - 26, $vinCenter[1] + 70), 0x0B0805) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func ClickOk ()
	Dim $count = 0
	Do
		Sleep(100)
		$count += 1
	Until HasOkButtonLive() Or ($count >= 50)
	If ($count >= 50) Then
		$ErrorCondition = 1
		$NextFix = "Identify Location"
		WriteLog("Didn't find expected confirmation box.")
	Else
		_MouseClick("left", $vinCenter[0] - 26, $vinCenter[1] + 63, 1, $SettingMouseSpeed)	;click OK
	EndIf
EndFunc

Func Forfeit ()
	ClearForfeit()
	$WaitingFor = "Town"
EndFunc

Func NextPage ()
	Dim $count = 0
	Do
		ClickArray("left", $click_BattleClearedNextPage)
		Do
			Sleep(100)
			$count += 1
		Until (PixelGetColor(353, 259) > 0x500000) Or ($count >= 10)
	Until (PixelGetColor(353, 259) > 0x500000)
	;_MouseClick("left", 671, 708, 1, $SettingMouseSpeed)
EndFunc

Func UpdateClientPosition ()
	Dim $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", 0)
	DllStructSetData($tPoint, "Y", 0)
	_WinAPI_ClientToScreen($vinHwnd, $tPoint)
	Dim $x = DllStructGetData($tPoint, "X")
	Dim $y = DllStructGetData($tPoint, "Y")
	If ($vinClient[0] <> $x) Or ($vinClient[1] <> $y) Then
		$vinClient[0] = $x
		$vinClient[1] = $y
		RefreshLog()
	EndIf
	$res = WinGetClientSize($wWindow)
	If ($res[0] <> $vinRes[0]) Or ($res[1] <> $vinRes[1]) Then
		$vinRes = $res
		$vinCenter[0] = $res[0] / 2
		$vinCenter[1] = $res[1] / 2
		ComputeSignatures()
	EndIf
EndFunc

;add checks
Func ReloadBoat ()
	If $OathMode Then
		$OathModeStarted = True
		If $OathComplete Then
			$OathModePos += 1
		EndIf
		$OathComplete = False
		If $OathModePos <= $DungeonNumOaths Then
			$DungeonOathPos = $OathModePos
		Else
			WriteLog("Oath runs complete.")
			SetOathMode()
			Return False
		EndIf
	EndIf

	Dim $usePos = $DungeonLocPos
	;detect and handle Two Pumpkins
	If IsColorMatch(PixelGetColor(683, 199), 0x731617) Then	;raid symbol found on thrid dungeon
		If $usePos >= 2 Then
			$usePos += 1					;skip two pumpkins
		EndIf
		If $usePos >= 10 Then			;bottom of battle list now
			$usePos = 0
		EndIf
	EndIf
	If (Not IsColorMatch(PixelGetColor(683, 166), 0x731617)) Then
		If ($usePos >= 10) And ($usePos <= 2) Then
			$usePos -= 1
		EndIf
	EndIf
	Dim $y = 0
	;select the right dungeon for the right job
	Switch $usePos
		Case 0
			$y = 502 - 66
		Case 1
			$y = 195 - 66
		Case 2
			$y = 230 - 66
		Case 3
			$y = 265 - 66
		Case 4
			$y = 300 - 66
		Case 5
			$y = 332 - 66
		Case 6
			$y = 364 - 66
		Case 7
			$y = 400 - 66
		Case 8
			$y = 434 - 66
		Case 9
			$y = 466 - 66
	EndSwitch

	OpenShipList()
	_Send("{ALT DOWN}")
	OpenCreateParty()

	WriteDebug("Current Slider Location: " & GetBattleSliderLocation($coord_SliderCreateParty))
	If (GetBattleSliderLocation($coord_SliderCreateParty) <> $BattleSliderLocation) And ($BattleSliderLocation <> 0) Then
		SetBattleSliderLocation()
	EndIf

	_MouseClick("left", 600, $y, 1, $SettingMouseSpeed)			;click dungeon
	Sleep(500)
	If $DungeonOathPos <> 0 Then				;click oath
		;oath specified
		Dim $oathY = GetOathY($DungeonOathPos)
		If $DungeonOathPos == 6 Then
			MouseClickDrag("left", 405, 255, 405, 266, $SettingMouseSpeed)
			$oathY = $oathY - 20
		EndIf
		_MouseClick("left", 169, $oathY, 1, $SettingMouseSpeed)	;click Oath
	Else
		;no oath
		ClickArray("left", $click_OathNoneCreateParty)	;click None oath
	EndIf

	Sleep(500)
	ClickArray("left", $click_OnBoatCreateParty)			;click on boat

	Sleep(500)
	Switch $Difficulty							;click difficulty
		Case "Normal"
			ClickArray("left", $click_DifficultyNormal)
		Case "Hard"
			ClickArray("left", $click_DifficultyHard)
		Case "Hero"
			ClickArray("left", $click_DifficultyHero)
	EndSwitch

	ClickArrayIfSigLive("left", $click_PrivateCreateParty, $sig_PrivateUncheckedCreateParty)

	Sleep(500)
	Dim $count = 0
	Do
		ClickArray("left", $click_CreatePartyCreateParty)			;click Create Party (black)
		$count += 1
		Sleep(100)
	Until HasBoatBeingPrepared() Or ($count >= 10)
	;if party glitch, click on Ok (this sould be prevented now)
	;_MouseClick("left", $vinCenter[0] - 26, $vinCenter[1] + 70, 1, $SettingMouseSpeed)	;click Ok
	_Send("{ALT UP}")
	Return True
EndFunc

Func Stupidity ()
	If Not $Spoken Then
		WriteLog($relief[Random(0, UBound($relief) - 1, 1)])
		$Spoken = True
	EndIf
	AdlibRegister("Stupidity", Random(60000, 180000, 1))
EndFunc

Func RefreshLog ()
	WriteLog("")
EndFunc

Func WaitStateBoatLaunch()
	If $WaitStates And (Not $IsDonator) Then
		WriteLog("Public Edition has a required wait time between launches.")
		Sleep(30000)
	EndIf
EndFunc

Func WriteDebug($text)
	If $Debug Then
		WriteLog("* " & $text)
	EndIf
EndFunc

Func WriteLog ($sText, $Invis = False)
	If Not $LogOpen Then
		Return
	EndIf
	If $sText <> "" Then
		$Spoken = False
	EndIf
	Dim $tPoint = DllStructCreate("int X; int Y")
	DllStructSetData($tPoint, "X", 0)
	DllStructSetData($tPoint, "Y", 0)
	_WinAPI_ClientToScreen($vinhWnd, $tPoint)

	If $sText <> "" Then
		If $SettingLogSize > $numLogs Then
			$numLogs += 1
			$log[$numLogs - 1] = $sText
		Else
			Dim $i
			For $i = 1 To ($SettingLogSize - 1)
				$log[$i - 1] = $log[$i]
			Next
			$log[$SettingLogSize - 1] = $sText
		EndIf
		WriteLogFile($sText)
	EndIf

	Dim $display = "- Runs: " & $Runs & " - Errors: " & $Errors & " - Avg: " & StringFormat("%.1f",  $AverageTime) &" secs -" & @CRLF
	$display = $display & RunningTime() & @CRLF
	$display = $display & "- Dungeon: " & $DungeonID & " (" & $Difficulty & ") -" & @CRLF
	For $i = 0 To ($SettingLogSize - 1)
		$display = $display & $log[$i] & " " & @CRLF
	Next
	Dim $title = $ProgramName & " v" & $Version & " (" & $Edition & " Edition)"
	If $CommandTrial == 1 Then
		$title = $title & " [Trial]"
	EndIf
	If $CommandUnlock == 1 Then
		$title = $title & " [Unlocked]"
	EndIf
	If $Debug Then
		$title = $title & " [Debug]"
	EndIf
	Dim $x = 0
	If Not $LogAltLocation Then
		$x = $vinRes[0] - 200 + DllStructGetData($tPoint, "X")
	Else
		$x = 200 + DllStructGetData($tPoint, "X")
	EndIf
	If Not $LogNoDisplay Then
		ToolTip($display, $x, $vinCenter[1] + DllStructGetData($tPoint, "Y"), $title, $hIcon, 2)
		Dim $twin = WinGetHandle("[Class:tooltips_class32; Title:- Runs: ]")
		DllCall("user32.dll", "int", "SendMessage", "hwnd", $twin, "int", 1043, "int", 0xFFFFFF, "long", 0)
		DllCall("user32.dll", "int", "SendMessage", "hwnd", $twin, "int", 1044, "int", 0x000000, "long", 0)
	EndIf
EndFunc

Func WriteLogFile ($sText)
	If $SettingWriteLogFile Then
		FileWriteLine($ProgramName & ".log", "[" & @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $sText)
	EndIf
EndFunc

Func KillLogWindow ()
	ToolTip("", 0, 0, "")
EndFunc

Func WriteLogFileHeader()
	Dim $tTime
	Dim $tLocal

	WriteLogFile("")
	$tTime  = _Date_Time_EncodeFileTime(@MON, @MDAY, @YEAR, @HOUR, @MIN, @SEC)
	$tLocal = _Date_Time_LocalFileTimeToFileTime(DllStructGetPtr($tTime))
	WriteLogFile("Started: " & _Date_Time_FileTimeToStr($tLocal))
EndFunc

Func RunningTime ()
	If Not $Running Then
		Return "- Running time: not running -"
	EndIf
	Dim $curTicks = _Date_Time_GetTickCount()
	Dim $hours
	Dim $mins
	Dim $secs
	Dim $sTime = "- Running time: "
	_TicksToTime($curTicks - $Ticks, $hours, $mins, $secs)
	If $hours <> 0 Then
		$sTime = $sTime & $hours & " hours "
	EndIf
	$sTime = $sTime & $mins & " minutes " & $secs & " seconds -"
	Return $sTime
EndFunc

Func PauseAfterRun ()
	$PauseAfterRun = True
	WriteLog("Pausing after this run is complete.")
EndFunc

Func SetOathMode ()
	UnSetLegendHotkeys()
	If $OathMode Then
		$OathMode = False
		WriteLog("Oath mode deactivated.")
		If $OathModeStarted Then
			WriteLog("Continuing in normal mode.")
		EndIf
	Else
		AllModesOff()
		$OathMode = True
		$OathModePos = 1
		$OathModeStarted = False
		$OathComplete = False
		WriteLog("Oath mode activated.")
	EndIf
EndFunc

Func SetMiningMode ()
	UnSetLegendHotkeys()
	If $MiningMode Then
		$MiningMode = False
		WriteLog("Mining mode deactivated.")
		If $InMiningDungeon Then
			WriteLog("You will return to town after this run is complete.")
		EndIf
	Else
		AllModesOff()
		$MiningMode = True
		WriteLog("Mining mode activated.")
	EndIf
EndFunc

Func SetMailMode ()
	UnSetLegendHotkeys()
	If $MailMode Then
		$MailMode = False
		WriteLog("Mail mode deactivated.")
	Else
		AllModesOff()
		$MailMode = True
		WriteLog("Mail mode activated.")
		WriteLog("Make sure you are on a dock when starting.")
	EndIf
EndFunc

Func SetLevelingMode ()
	UnSetLegendHotkeys()
	If $LevelingMode Then
		$LevelingMode = False
		WriteLog("Leveling mode deactivated.")
	Else
		AllModesOff()
		$LevelingMode = True
		WriteLog("Leveling mode activated.")
	EndIf
EndFunc

Func AllModesOff()
	If $OathMode Then
		SetOathMode()
	EndIf
	If $MiningMode Then
		SetMiningMode()
	EndIf
	If $MailMode Then
		SetMailMode()
	EndIf
	If $LevelingMode Then
		SetLevelingMode()
	EndIf
EndFunc

Func ExitLegend ()
	UnSetLegendHotkeys()
	RefreshLog()
EndFunc

Func UnSetLegendHotkeys ()
	$LogNoDisplay = False
	HotKeySet("1")
	HotKeySet("2")
	HotKeySet("3")
	HotKeySet("4")
	HotKeySet("0")
EndFunc

Func ShowLegend ()
	Dim $tPoint = DllStructCreate("int X; int Y")
	DllStructSetData($tPoint, "X", 0)
	DllStructSetData($tPoint, "Y", 0)
	_WinAPI_ClientToScreen($vinhWnd, $tPoint)

	Dim $text = @CRLF
	$text = $text & "1 - Oath Mode ("
	If $OathMode Then
		$text = $text & "On"
	Else
		$text = $text & "Off"
	EndIf
	$text = $text & ")" & @CRLF
	HotKeySet("1", "SetOathMode")

	$text = $text & "2 - Mining Mode ("
	If $MiningMode Then
		$text = $text & "On"
	Else
		$text = $text & "Off"
	EndIf
	$text = $text & ")" & @CRLF
	HotKeySet("2", "SetMiningMode")

	$text = $text & "3 - Mail Mode ("
	If $MailMode Then
		$text = $text & "On"
	Else
		$text = $text & "Off"
	EndIf
	$text = $text & ")" & @CRLF
	HotKeySet("3", "SetMailMode")

	$text = $text & "4 - Leveling Mode ("
	If $LevelingMode Then
		$text = $text & "On"
	Else
		$text = $text & "Off"
	EndIf
	$text = $text & ")" & @CRLF
	HotKeySet("4", "SetLevelingMode")

	$text = $text & "0 - Exit Menu" & @CRLF
	HotKeySet("0", "ExitLegend")

	$LogNoDisplay = True
	ToolTip($text, $vinCenter[0] + DllStructGetData($tPoint, "X"), $vinCenter[1] + DllStructGetData($tPoint, "Y"), $ProgramName & " " & $Version & " - Additional Tools", 0, 2)
EndFunc

Func PasteData ()
	ConsoleWrite("PasteData()" & @CRLF)
	Dim $text = ClipGet()
	_Send($text)
	HotKeySet("^x")
	Send("^x")
	HotKeySet("^x", "PasteData")
EndFunc

Func ShutDownApp ()
	If WinActive($wWindow) Then
		$ExitApp = True
	EndIf
EndFunc

Func Kill ()
	Exit
EndFunc

Func Pause ()
	If WinActive($wWindow) Then
		If $Paused Then
			$Paused = False
			WriteLog("Resuming...")
		Else
			$Paused = True
			WriteLog("Pausing...")
		EndIf
	EndIf
EndFunc

Func HasError ()
	Dim $color1
	Dim $color2
	Dim $color3
	Dim $color4

 	$color1 = fastPixelGetColor($vinCenter[0] - 14, $vinCenter[1] + 69)
	$color2 = fastPixelGetColor($vinCenter[0] - 1, $vinCenter[1] + 69)
	$color3 = fastPixelGetColor($vinCenter[0] + 14, $vinCenter[1] + 69)
	$color4 = fastPixelGetColor($vinCenter[0] + 1, $vinCenter[1] + 64)

	Return _HasError($color1, $color2, $color3, $color4)
EndFunc

Func HasErrorLive ()
	Dim $color1
	Dim $color2
	Dim $color3
	Dim $color4

 	$color1 = PixelGetColor($vinCenter[0] - 14, $vinCenter[1] + 69)
	$color2 = PixelGetColor($vinCenter[0] - 1, $vinCenter[1] + 69)
	$color3 = PixelGetColor($vinCenter[0] + 14, $vinCenter[1] + 69)
	$color4 = PixelGetColor($vinCenter[0] + 1, $vinCenter[1] + 64)

	Return _HasError($color1, $color2, $color3, $color4)
EndFunc

Func _HasError ($a, $b, $c, $d)
	If (IsColorMatch($a, 0x050402) And IsColorMatch($b, 0x0B0805) And IsColorMatch($c, 0x050402) And IsColorMatch($d, 0x90775F)) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasLoginScreen ()
	Dim $pixel1 = LetterBoxCheck(783, 473)
	Dim $pixel2 = LetterBoxCheck(913, 549)
	Dim $pixel3 = LetterBoxCheck(788, 335)
	Dim $pixel4 = LetterBoxCheck(788, 375)

	If IsColorMatch($pixel1, 0xFFFFFF) And IsColorMatch($pixel2, 0xFFFFFF) And IsColorMatch($pixel3, 0xF6C663) And IsColorMatch($pixel4, 0xF6C263) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasLoginBox ()
	Dim $pixel1 = fastPixelGetColor($vinCenter[0] + 74, $vinCenter[1] - 57)
	Dim $pixel2 = fastPixelGetColor($vinCenter[0] + 69, $vinCenter[1] - 64)
	Dim $pixel3 = fastPixelGetColor($vinCenter[0] + 87, $vinCenter[1] - 63)

	If IsColorMatch($pixel1, 0xE7A263) And IsColorMatch($pixel2, 0xE9E4A7) And IsColorMatch($pixel3, 0x312008) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func Login($username, $password, $server, $startGame = True)
	If $startGame Then
		KillLogWindow()
		_MouseClick("left", (($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2) + ((($vinRes[0] - ((($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2) * 2)) / 1024) * 849), ($vinRes[1] / 768) * 476, 1, $SettingMouseSpeed)	;click Start Game
		Sleep(1000)
		_Send($LoginUserID)
		Sleep(200)
		_Send("{TAB}")
		Sleep(200)
		_Send($LoginPassword)

		If $LoginServer <> "No Selection" Then
			_MouseClick("left", $vinCenter[0] + 39, $vinCenter[1] + 89, 1, $SettingMouseSpeed)	;click Select Server
			Sleep(200)
			Switch $LoginServer
				Case "East"
					_MouseClick("left", $vinCenter[0] - 10, $vinCenter[1] -31, 1, $SettingMouseSpeed)	;click East
				Case "West"
					_MouseClick("left", $vinCenter[0] - 10, $vinCenter[1] -9, 1, $SettingMouseSpeed)	;click West
			EndSwitch
			Sleep(200)
			_MouseClick("left", $vinCenter[0] - 22, $vinCenter[1] + 56, 1, $SettingMouseSpeed)	;click Ok
			Sleep(200)
		EndIf
	EndIf
	_MouseClick("left", $vinCenter[0] - 142, $vinCenter[1] + 89, 1, $SettingMouseSpeed)	;click Ok
EndFunc

Func LoginChar($char)
	_MouseClick("left", $vinRes[0] - 165, 28 + ($char * 64) - 32, 1, $SettingMouseSpeed)	;click character's button
EndFunc

Func HasAvatarShop ()
	Dim $color

	$color = fastPixelGetColor($vinRes[0] - 13, $vinRes[1] - 26)	;Avatar button
	If IsColorMatch($color, 0x936B42) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasAvatarShopLive ()
	Dim $color

	$color = PixelGetColor($vinRes[0] - 13, $vinRes[1] - 26)
	If IsColorMatch($color, 0x936B42) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasLeaveParty ()
	Dim $color1
	Dim $color2

	$color1 = fastPixelGetColor(89, 434)	;4-peron  Leave Party and Exit button
	$color2 = fastPixelGetColor(89, 596)	;6/8-person Leave Party and Exit button
	If IsColorMatch($color1, 0x0A0602) Or IsColorMatch($color2, 0x0A0602) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasHPBar ()
	Dim $color

	$color = fastPixelGetColor(285, 15)
	If IsColorMatch($color, 0xCBD8DC) Or IsColorMatch($color, 0xB61A11) Or IsColorMatch($color, 0xAE0A09) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasHPBarLive ()
	Dim $color

	$color = PixelGetColor(285, 15)
	If IsColorMatch($color, 0xB61A11) Or IsColorMatch($color, 0xAE0A09) Then	;check docks and town (color changes slightly)
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasStartButton ()
	Dim $color

	$color = fastPixelGetColor(111, $vinRes[1] - 114)
	If IsColorMatch($color, 0x000000) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasStartButtonLive ()
	Dim $color

	$color = PixelGetColor(111, $vinRes[1] - 114)
	If IsColorMatch($color, 0x000000) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasCreateParty ()
	Dim $color

	$color = fastPixelGetColor(335, 660)
	If ($color > 0xC00000) And ($color < 0xCE0000) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasBlackScreen ()
	Dim $color1
	Dim $color2

	$color1 = fastPixelGetColor(1, 1)
	$color2 = fastPixelGetColor(100, 100)
	If IsColorMatch($color1, 0x000000) And IsColorMatch($color2, 0x000000) Then
		If ($LastLocation <> "Black Screen") Then
			LocationChanged("Black Screen")
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasBattleClearedBox ()
	If IsColorMatch(fastPixelGetColor(556, 128), 0xFFFFFF) And IsColorMatch(fastPixelGetColor(561, 130), 0xFFFFFF) And IsColorMatch(fastPixelGetColor(483, 59), 0xFFFFFF) And (fastPixelGetColor(490, 136) < 0x303030) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasBattleFailed ()
	Dim $pixel1 = fastPixelGetColor(472, 125)
	Dim $pixel2 = fastPixelGetColor(472, 158)
	Dim $pixel3 = fastPixelGetColor(471, 175)
	dim $pixel4 = fastPixelGetColor(271, 717)
	If IsColorMatch($pixel1, 0x95928F) And IsColorMatch($pixel2, 0x8F8F8F) And IsColorMatch($pixel3, 0x313331) And IsColorMatch($pixel4, 0x000000) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasEmptyBattleCleared ()
	Dim $color1
	Dim $color2

	$color1 = fastPixelGetColor(260, 294)
	$color2 = fastPixelGetColor(504, 294)
	If IsColorMatch($color1, 0x927960) And IsColorMatch($color2, 0x927960) And (HasAvatarShop()) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasEmptyBattleClearedLive ()
	Dim $color1
	Dim $color2

	$color1 = PixelGetColor(260, 294)
	$color2 = PixelGetColor(504, 294)
	If IsColorMatch($color1, 0x927960) And IsColorMatch($color2, 0x927960) And (HasAvatarShop()) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasBattleClearedWorking ()
	Dim $pixel1 = fastPixelGetColor($vinCenter[0] + 79, $vinCenter[1] - 75)
	Dim $pixel2 = fastPixelGetColor($vinCenter[0] - 101, $vinCenter[1] - 29)
	Dim $pixel3 = fastPixelGetColor($vinCenter[0] - 53, $vinCenter[1] + 60)
	If IsColorMatch($pixel1, 0xF7FBF7) And IsColorMatch($pixel2, 0xF4EBE1) And IsColorMatch($pixel3, 0x393842) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasBoatBeingPrepared ()
	Dim $pixel1 = fastPixelGetColor($vinCenter[0] - 80, $vinCenter[1] - 31)
	Dim $pixel2 = fastPixelGetColor($vinCenter[0] + 24, $vinCenter[1] - 27)
 	Dim $pixel3 = fastPixelGetColor($vinCenter[0] - 103, $vinCenter[1] - 68)	;NA									;EU
	If (IsColorMatch($pixel1, 0xF1F1F1) Or IsColorMatch($pixel1, 0xF8F8F8)) And (IsColorMatch($pixel2, 0xF3F3F3) Or IsColorMatch($pixel2, 0xDCDCDC)) And (IsColorMatch($pixel3, 0xC04034) Or IsColorMatch($pixel3, 0x9B342A)) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func CheckGlitchedTownOrBoat ()
	If (HasHPBar() And (HasStartButton()) And (HasAvatarShop()) And (Not HasBoatBeingPrepared())) Then
		Return True
	Else
		Return False
	EndIf
Endfunc

Func CheckTown ()
	If (HasHPBar() And (Not HasStartButton()) And (HasAvatarShop())) Then
		If ($LastLocation <> "Town") Then
			LocationChanged("Town")
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc

Func CheckTownLive ()
	If (HasHPBarLive() And (Not HasStartButtonLive()) And (HasAvatarShopLive())) Then
		If ($LastLocation <> "Town") Then
			LocationChanged("Town")
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc

Func CheckBoat ()
	If ((HasHPBar()) And (HasStartButton()) And (Not HasAvatarShop()) And Not (HasBoatBeingPrepared())) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func CheckBoatLive ()
	If ((HasHPBarLive()) And (HasStartButtonLive()) And (Not HasAvatarShopLive())) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func LocationChanged ($sLocation)
	$CurrentLocation = $sLocation
	$LastLocation = $CurrentLocation
EndFunc

Func HasParty ()
	If IsColorMatch(fastPixelGetColor(76, 206), 0x980702) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func HasPartyLive ()
	If IsColorMatch(PixelGetColor(76, 206), 0x980702) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

;TODO: Checks for Ok button before click attempt
Func LeaveParty ()
	If CheckTown() Then
		ChangeChannel()
	EndIf
	If HasPartyLive() Then
		WriteLog("Leaving party.")
		_Send("{ALT DOWN}")
		If $PartySize == 4 Then
			;ClickAndWaitArray("left", $click_UILeaveParty4[0], $click_UILeaveParty4[1], $sig_DialogLeaveParty, 1500, 1)
			_MouseClick("left", 20, 431, 1, $SettingMouseSpeed)	;leave on 4-person
		ElseIf $PartySize == 6 Then
			;ClickAndWaitArray("left", $click_UILeaveParty6[0], $click_UILeaveParty6[1], $sig_DialogLeaveParty, 1500, 1)
			_MouseClick("left", 20, 590, 1, $SettingMouseSpeed)	;leave on 6/8-person
		ElseIf $PartySize == 8 Then
			;ClickAndWaitArray("left", $click_UILeaveParty6[0], $click_UILeaveParty6[1], $sig_DialogLeaveParty, 1500, 1)
			_MouseClick("left", 20, 590, 1, $SettingMouseSpeed)	;leave on 6/8 person
		Else
			;ClickAndWaitArray("left", $click_UILeaveParty4[0], $click_UILeaveParty4[1], $sig_DialogLeaveParty, 1500, 1)
			;ClickAndWaitArray("left", $click_UILeaveParty6[0], $click_UILeaveParty6[1], $sig_DialogLeaveParty, 1500, 1)
			_MouseClick("left", 20, 431, 1, $SettingMouseSpeed)	;leave on 4-person
			_MouseClick("left", 20, 590, 1, $SettingMouseSpeed)	;leave on 6/8-person
		EndIf
		;double check we've clicked where the button is
		;If (IsColorMatch(PixelGetColor(95, 432), 0x000000)) Then
		;	_MouseClick("left", 20, 431, 1, $SettingMouseSpeed)	;leave on 4-person
		;ElseIf (IsColorMatch(PixelGetColor(95, 592), 0x000000)) Then
		;	_MouseClick("left", 20, 590, 1, $SettingMouseSpeed)	;leave on 6/8 person
		;EndIf
		Sleep(1000)
		ClickArray("left", $click_OkOkCancel)
		;ClickAndWaitArrayNot("left", $click_OkOkCancel[0], $click_OkOkCancel[1], $sig_UIParty)
		;_MouseClick("left", $vinCenter[0] - 26, $vinCenter[1] + 70, 1, $SettingMouseSpeed)	;click ok
		_Send("{ALT UP}")

		;possible to get a error dialog here
		Sleep(2000)
		If HasErrorLive() Then
			;clear error
			_MouseClick("left", $vinCenter[0] - 2, $vinCenter[1] + 64, 1, $SettingMouseSpeed)	;clear error box
		EndIf
	Else
		WriteDebug("No party to leave from.")
	EndIf
EndFunc

;add checks
Func SpendAPCurrentSkill ()
	_MouseClick("left", 758, 509, 1, $SettingMouseSpeed)	;+Max
	_MouseClick("left", 614, 509, 1, $SettingMouseSpeed)	;+1
EndFunc

Func SetEU_NA()
	DetectEU($vinRes[0] - 56, $vinRes[1] - 33)
	If $SettingEU == 1 Then
		$SettingUseEU = 1
		$PosY_ReturnToTown_6Party = $EU_PosY_ReturnToTown_6Party
		$PosY_ReturnToTown_8Party = $EU_PosY_ReturnToTown_8Party
		WriteLog("Running in EU mode.")
	Else
		$PosY_ReturnToTown_6Party = $NA_PosY_ReturnToTown_6Party
		$PosY_ReturnToTown_8Party = $NA_PosY_ReturnToTown_8Party
		WriteLog("Running in NA mode.")
	EndIf
EndFunc

;add checks
Func SpendAP ()
	OpenWindowSkills()
	If IsColorMatch(PixelGetColor(540, 99), 0x040708) Then
		_MouseClick("left", 542, 99, 1, $SettingMouseSpeed)	;trained skills checked?
	EndIf
	_MouseClick("left", 78, 70, 1, $SettingMouseSpeed)		;click all tab
	_MouseClick("left", 182, 153, 1, $SettingMouseSpeed)	;skill 1,1
	SpendAPCurrentSkill()
	_MouseClick("left", 414, 153, 1, $SettingMouseSpeed)	;skill 2,1
	SpendAPCurrentSkill()
	_MouseClick("left", 182, 225, 1, $SettingMouseSpeed)	;skill 1,2
	SpendAPCurrentSkill()
	_MouseClick("left", 414, 225, 1, $SettingMouseSpeed)	;skill 2,2
	SpendAPCurrentSkill()
	RemoveBoatWindows()
	;_MouseClick("left", 442, 664, 1, $SettingMouseSpeed)	;click Close
EndFunc

Func StartBoat ()
	_Send("{ALT DOWN}")
	Sleep(100)
	_MouseMove(105, $vinRes[1] - 120, $SettingMouseSpeed)	;Start button
	Sleep(200)
	_MouseClick("left", 105, $vinRes[1] - 120, 1, $SettingMouseSpeed)	;Start button
	_Send("{ALT UP}")
EndFunc

Func Replay ()
	If (Not $OathMode) Then
		If $SettingCloseBattleCleared == 0 Then
			ClearBattleClearedReplay()
		Else
			ClearBattleCleared()
			_Send("{ALT DOWN}")
			Sleep(500)
			Switch $PartySize
				Case 4
					MouseClick("left", 89, 425, 1, $SettingMouseSpeed)
				Case 6
					MouseClick("left", 89, 610, 1, $SettingMouseSpeed)
				Case 8
					MouseClick("left", 89, 610, 1, $SettingMouseSpeed)
			EndSwitch
			_Send("{ALT UP}")
		EndIf
	Else
		ClearBattleCleared()
		_Send("{ALT DOWN}")
		Sleep(500)
		Switch $PartySize
			Case 4
				MouseClick("left", 89, 395, 1, $SettingMouseSpeed)
			Case 6
				MouseClick("left", 89, $PosY_ReturnToTown_6Party, 1, $SettingMouseSpeed)
			Case 8
				MouseClick("left", 89, $PosY_ReturnToTown_8Party, 1, $SettingMouseSpeed)
		EndSwitch
		_Send("{ALT UP}")
	EndIf
EndFunc

Func BypassBoat ()
	WriteLog("Activating bypasses.")
	;_Send($BindLBBypass)
	;Sleep(100)
	_Send($BindCSBypass)
	Sleep(100)
EndFunc

Func BossRoomPrep ($Transform = True, $MineBombs = False, $OHK = True)
	_Send($BindGod)
	Sleep(100)
	WriteDebug("God mode.")
	If $OHK Then
		If ($DungeonEnhanced And $ConsoleExtras)Then
			_Send($BindIK)
			Sleep(100)
			WriteDebug("Instant Kill.")
		Else
			_Send($BindOHK)
			Sleep(100)
			WriteDebug("One-Hit-Kill.")
		EndIf
	EndIf
	_Send($BindSmall)
	Sleep(100)
	WriteDebug("Small size.")
	If $MineBombs Then
		_Send($BindMineBombs)
		WriteDebug("Mine bombs equipped.")
	Else
		_Send($BindSpears)
		WriteDebug("Fine spears equipped.")
	EndIf
	Sleep(100)
	;If ($Transform) And (Not($DungeonEnhanced And $ConsoleExtras)) Then
	;	WriteDebug("Transform Paladin 1")
	;	_Send($BindTrans1)
	;	Sleep(500)
	;	WriteDebug("Transform Paladin 2")
	;	_Send($BindTrans2)
	;	Sleep(500)
	;EndIf
EndFunc

Func BossRoomDone ()
	;in case anything in the future nieeds to be turned off
	;If ($SettingPickItems == 1) And ($ConsoleExtras) And ($SettingBreakItems == 1) Then
	;	_Send($BindBreak)
	;	Dim $px = PixelGetColor($vinCenter[0], $vinCenter[1] + 100)
	;	Do
	;		Sleep(100)
	;	Until $px <> PixelGetColor($vinCenter[0], $vinCenter[1] + 100)
	;EndIf

	;If ($SettingPickItems == 1) Then
	;	CollectDrops(30);
	;EndIf
EndFunc

Func SpamSkill ($num, $delay=50)
	If $IsPremium Then
		_Send($BindKill1)
	EndIf
EndFunc

Func SpamKill ($num, $delay=50)
	;If (Not $DungeonEnhanced) Or (Not $ConsoleExtras) Then
	;	Dim $i

	;	For $i = 1 To $num
	;		_Send($FireSecondary)
	;		Sleep($delay)
			;_Send($BindTenticle)
			;Sleep($delay)
	;		MouseMove($vinCenter[0] - 20, $vinCenter[1], 5)
	;	Next
	;EndIf
	If $IsPremium Then
		;_Send($BindKill1)
	Else
		_Send($FireSecondary)
		Sleep($delay)
		MouseMove($vinCenter[0] - 20, $vinCenter[1], 5)
	EndIf
EndFunc

Func Nuke ()
	_Send($BindNuke)
EndFunc


Func SpamSpears ($num)
	Dim $i

	For $i = 1 to $num
		_Send($FireSecondary)
		If $num > 1 Then
			Sleep(200)
		EndIf
	Next
EndFunc

Func LaunchBoat ()
	WaitStateBoatLaunch()
	$DungeonStartTime = _Date_Time_GetTickCount()
	WriteLog ("Starting boat.")
	Dim $count = 0
	Do
		_Send("{ALT DOWN}")
		Sleep(200)
		ClickArray("left", $click_BoatStart)
		_Send("{ALT UP}")
		WriteLog("Waiting for the boat to depart.")
		Do
			Sleep(100)
			$count += 1
		Until (Not HasHPBarLive()) Or ($count >= 10)
	Until (Not HasHPBarLive())
	$Virgin = False
	BypassBoat()
EndFunc

Func PlayAlarm()
	Dim $alarm1 = _SoundOpen(@TempDir & "\Alarm.wav")
	_SoundPlay($alarm1, 0)
EndFunc

Func BeginMod()
	Begin()
EndFunc

Func Begin ($PlaySound = False)
	If Not $Running Then
		$Running = True
		$BossInProgress = False
		$WaitingFor = "Start"
		$Runs = 0
		;$DungeonID = "Unknown"
		$ErrorCondition = 0
		$NextFix = ""
		$Virgin = True
		$PauseAfterRun = False
		If $Paused Then
			WriteLog ("Activated, but still paused!")
		Else
			WriteLog("Activated!")
		EndIf

		WinActivate($wWindow)
		AdlibRegister("Stupidity", Random(60000, 180000, 1))
		AdlibRegister("RefreshLog", 1000)
		$Ticks = _Date_Time_GetTickCount()
		$LogoutTimer = 0
	Else
		$Running = False
		$WaitingFor = ""
		$PauseAfterRun = False
		;$DungeonID = "Unknown"
		WriteLog("Deactivated!")
		AdlibUnRegister("Stupidity")
		AdlibUnRegister("RefreshLog")
		If ($PlaySound) Then
			PlayAlarm()
			$LogoutTimer = _Date_Time_GetTickCount()
		Else
			$LogoutTimer = 0
		EndIf
	EndIf
EndFunc

Func SkipToBoss ($numSkips)
	Dim $i

	For $i = 1 To $numSkips
		_Send($BindSkipMap)
		Sleep(1000)
		Do
			Sleep(100)
		;Until (HasChatBoxLive())
		Until (HasHPBarLive())
	Next
EndFunc

Func ToggleRate ()
	If $SettingHostTimeScaleUse > 1 Then
		Sleep(200)
		_Send($BindTimescale)
	EndIf
EndFunc

Func ToggleRateStatic ()
	If $SettingSpeedupScene == 1 Then
		Sleep(200)
		_Send($BindTimescale)
	EndIf
EndFunc

Func SkipToTriggerPoint ()
	WriteLog("Triggering cutscene.")
	_Send($BindLarge)
	Sleep(500)
	_Send($BindNormal)
	Sleep(500)
	Dim $px = PixelGetColor($vinCenter[0], $vinCenter[1] / 2)
	Do
		Sleep(100)
	Until PixelGetColor($vinCenter[0], $vinCenter[1] / 2) <> $px
EndFunc

Func CollectDrops($pickups = 16)
	Dim $i = 0

	_Send($BindPickupDistance)
	For $i = 1 to Int($pickups / 2)
		Sleep(100)
		_Send($Pickup)
	Next
	_Send($BindPickupDistance)
	For $i = 1 to Int($pickups / 2)
		Sleep(100)
		_Send($Pickup)
	Next
	_Send($BindPickupDistance)
EndFunc

Func ReloadMap()
	_Send($BindReloadMap)
EndFunc

Func IdentifyDungeonDisplay ()
	SaveScreen()
	IdentifyDungeon(False)
	WriteDebug("Dungeon: " & $DungeonID & @CRLF & "NextFix: " & $NextFix)
EndFunc

Func GetOathY ($OathIndex)
	If $OathIndex < 20 Then
		Return ($OathIndex * 20) + 212
	Else
		;probably old style
		Return $OathIndex
	EndIf
EndFunc

Func IdentifyDungeon ($Reset = True)
	If $Reset Then
		$DungeonLocPos = 0
		$DungeonVIP = False
		$DungeonID = "Unknown"
		$InMiningDungeon = False
		$InLevelingDungeon = False
		$PartySize = 0
		$DungeonOathPos = 0
		$DungeonNumOaths = 0
	EndIf
	If IsWeepingQueen() Then
		$Skips = 0
		$DungeonID = "The Weeping Queen"
		$DungeonOathPos = 5
		$PartySize = 6
		$DungeonVIP = True
		$DungeonNumOaths = 5
	ElseIf IsDecisiveBattle() Then
		$Skips = 3
		$DungeonID = "Decisive Battle"
		$DungeonOathPos = 3
		$DungeonLocPos = 7
		$PartySize = 4
		$DungeonNumOaths = 4
		$DungeonEnhanced = True
	ElseIf IsTheContract() Then
		$Skips = 3
		$DungeonID = "The Contract"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsTrampledPlains() Then
		$Skips = 3
		$DungeonID = "Trampled Plains"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsBrynnsResearch() Then
		$Skips = 3
		$DungeonID = "Brynn's Research"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsKoboldChief() Then
		$Skips = 3
		$DungeonID = "Kobold Chief"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsDethroneTheWhiteTyrant() Then
		$Skips = 1
		$DungeonID = "Dethrone the White Tyrant"
		$DungeonOathPos = 5
		$PartySize = 6
		$DungeonNumOaths = 6
	ElseIf IsWhiteTyrantsChallenge() Then
		$Skips = 0
		$DungeonID = "White Tyrant's Challenge"
		$DungeonOathPos = 4
		$PartySize = 6
		$DungeonNumOaths = 4
	ElseIf IsDeadEndStreet() Then
		$Skips = 3
		$DungeonID = "Dead End Street"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsBeingFromTheOtherWorld() Then
		$Skips = 3
		$DungeonID = "Being from the Other World"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsRegretsTooLate() Then
		$Skips = 3
		$DungeonID = "Regrets... Too Late"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsTheUnveilingTruth() Then
		$Skips = 3
		$DungeonID = "The Unveiling Truth"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsFriends() Then
		$Skips = 1
		$DungeonID = "Friends?"
		$DungeonOathPos = 1
		$DungeonLocPos = 8
		$PartySize = 4
		$DungeonNumOaths = 2
	ElseIf IsRevenge() Then
		$Skips = 3
		$DungeonID = "Revenge"
		$DungeonOathPos = 4
		$DungeonLocPos = 9
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsFinalSlingshot() Then
		$Skips = 2
		$DungeonID = "Final Slingshot"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsSourceOfTheRumor() Then
		$Skips = 2
		$DungeonID = "Source of the Rumor"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsPrepareForCounterattack() Then
		$Skips = 1
		$DungeonID = "Prepare for Counterattack"
		$DungeonOathPos = 5
		$PartySize = 4
		$DungeonNumOaths = 5
	ElseIf IsCulpritBehindTheDisturbance() Then
		$Skips = 3
		$DungeonID = "Culprit Behind the Disturbance"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsSpiderOverload() Then
		$Skips = 3
		$DungeonID = "Spider Overload"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsWakeUpCall() Then
		$Skips = 2
		$DungeonID = "Wake Up Call"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsDepthsOfAinle() Then
		$Skips = 3
		$DungeonID = "Depths of Ainle"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsBurntPumpkinField() Then
		$Skips = 3
		$DungeonID = "Burnt Pumpkin Field"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsHolyGround() Then
		$Skips = 0
		$DungeonID = "Holy Ground"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsShadowedByDarkness() Then
		$Skips = 1
		$DungeonID = "Shadowed by Darkness"
		$DungeonOathPos = 5
		$PartySize = 6
		$DungeonNumOaths = 6
	ElseIf IsWhereTheLegendSleeps() Then
		$Skips = 3
		$DungeonID = "Where the legend sleeps"
		$DungeonOathPos = 5
		$PartySize = 4
		$DungeonNumOaths = 5
	ElseIf IsFomorianEmblem() Then					;must be before fomorian order
		$Skips = 1
		$DungeonID = "Fomorian Emblem"
		$DungeonOathPos = 1
		$DungeonLocPos = 3
		$PartySize = 4
		$DungeonNumOaths = 2
	ElseIf IsFomorianOrder() Then
		$Skips = 3
		$DungeonID = "Fomorian Order"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsPrairieGnoll() Then
		$Skips = 2
		$DungeonID = "Prairie Gnoll"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsRuinsOfSanctity() Then
		$Skips = 3
		$DungeonID = "Ruins of Sanctity"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsGoliath() Then
		$Skips = 3
		$DungeonID = "Goliath"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsHidden() Then
		$Skips = 1
		$DungeonID = "Hidden"
		$DungeonOathPos = 3
		$PartySize = 6
		$DungeonNumOaths = 3
	ElseIf IsNightmareAtTheRuins() Then
		$Skips = 1
		$DungeonID = "Nightmare at the Ruins"
		$DungeonOathPos = 4
		$PartySize = 8
		$DungeonNumOaths = 4
	ElseIf IsGnollKingRulerOfTheRuins() Then
		$Skips = 3
		$DungeonID = "Gnoll King, Ruler of the Ruins"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsHoarfrostHollowInFlames() Then
		$Skips = 3
		$DungeonID = "Hoarfrost Hollow in Flames"
		$DungeonOathPos = 1
		$DungeonLocPos = 9
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsYetiKing() Then
		$Skips = 3
		$DungeonID = "Yeti King"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsMadness() Then
		$Skips = 3
		$DungeonID = "Madness"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsIrukul() Then
		$Skips = 0
		$DungeonID = "Irukul"
		$DungeonOathPos = 5
		$PartySize = 8
		$DungeonVIP = True
		$DungeonNumOaths = 5
	ElseIf IsRevivedFear() Then
		$Skips = 1
		$DungeonID = "Revived Fear"
		$DungeonOathPos = 5
		$PartySize = 6
		$DungeonVIP = True
		$DungeonNumOaths = 5
	ElseIf IsUnfinishedBusiness() Then
		$Skips = 3
		$DungeonID = "Unfinished Business"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsTheHowlingSoul() Then
		$Skips = 1
		$DungeonID = "The Howling Soul"
		$DungeonOathPos = 5
		$PartySize = 6
		$DungeonNumOaths = 5
	ElseIf IsTwoMoons() Then
		$Skips = 2
		$DungeonID = "Two Moons"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsAppearanceOfASmallBear() Then
		$Skips = 3
		$DungeonID = "Appearance of a Small Bear"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 5
	ElseIf IsSnowmanAlert() Then
		$Skips = 3
		$DungeonID = "Snowman Alert"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 5
	ElseIf IsProofOfCourage() Then
		$Skips = 2
		$DungeonID = "Proof of Courage"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsFightThatMustBeWon() Then
		$Skips = 3
		$DungeonID = "Fight That Must Be Won"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsShadyForest() Then
		$Skips = 1
		$DungeonID = "Shady Forest"
		$DungeonOathPos = 5
		$PartySize = 6
		$DungeonNumOaths = 5
	ElseIf IsWestHilderForest() Then
		$Skips = 3
		$DungeonID = "West Hilder Forest"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsForestRuins() Then
		$Skips = 3
		$DungeonID = "Forest Ruins"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsContact() Then
		$Skips = 3
		$DungeonID = "Contact"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsCadetsChallenge() Then
		$Skips = 3
		$DungeonID = "Cadet's Challenge"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsLostRoad() Then
		$Skips = 3
		$DungeonID = "Lost Road"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsBuriedSorrow() Then
		$Skips = 3
		$DungeonID = "Buried Sorrow"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsRocktunesCabin() Then
		$Skips = 2
		$DungeonID = "Rocktune's Cabin"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsColhenInFlames() Then
		$Skips = 0
		$DungeonID = "Colhen in Flames"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsWesternIcePassage() Then
		$Skips = 2
		$DungeonID = "Western Ice Passage"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsRescue() Then
		$Skips = 2
		$DungeonID = "Rescue"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsStoreroom() Then
		$Skips = 2
		$DungeonID = "Storeroom"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsTheLastFragment() Then
		$Skips = 3
		$DungeonID = "The Last Fragment"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsTheInvestigation() Then
		$Skips = 2
		$DungeonID = "The Investigation"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsInvestigation() Then
		$Skips = 2
		$DungeonID = "Investigation"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsMercenaryTrainingSite() Then
		$Skips = 0
		$DungeonID = "Mercenary Training Site"
		$DungeonOathPos = 0
		$DungeonLocPos = 1
		$PartySize = 4		;it's really 1, but we don't care
		$DungeonNumOaths = 0
	ElseIf IsFruitful() Then
		$Skips = 2
		$DungeonID = "Fruitful"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsPursuit() Then
		$Skips = 2
		$DungeonID = "Pursuit"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsChicanery() Then
		$Skips = 2
		$DungeonID = "Chicanery"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsTheSecret() Then
		$Skips = 3
		$DungeonID = "The Secret"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsTakingInitiative() Then
		$Skips = 3
		$DungeonID = "Taking Initiative"
		$DungeonOathPos = 5
		$PartySize = 4
		$DungeonNumOaths = 5
	ElseIf IsAmbush() Then
		$Skips = 0
		$DungeonID = "Ambush"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 3
	ElseIf IsStrongDrink() Then
		$Skips = 3
		$DungeonID = "Strong Drink"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsWhatTheDeadLeaveBehind() Then
		$Skips = 2
		$DungeonID = "What the Dead Leave Behind"
		$DungeonOathPos = 5
		$PartySize = 4
		$DungeonNumOaths = 5
	ElseIf IsGatekeeperOfTheCatacombs() Then
		$Skips = 2
		$DungeonID = "Gatekeeper of the Catacombs"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 4
	ElseIf IsRedRuins() Then
		$Skips = 1
		$DungeonID = "Red Ruins"
		$DungeonOathPos = 3
		$PartySize = 6
		$DungeonNumOaths = 4
	ElseIf IsAnotherSlingshot() Then
		$Skips = 2
		$DungeonID = "Another Slingshot"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsHoarfrostHollow() Then
		$Skips = 1
		$DungeonID = "Hoarfrost Hollow"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsWindgun() Then
		$Skips = 2
		$DungeonID = "Windgun"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 3
	ElseIf IsGwynnsRequest() Then
		$Skips = 2
		$DungeonID = "Gwynn's Request"
		$DungeonOathPos = 1
		$DungeonLocPos = 5
		$PartySize = 4
		$DungeonNumOaths = 1
	ElseIf IsWhereTheSunDontShine() Then
		$Skips = 2
		$DungeonID = "Where the Sun Don't Shine"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 3
	ElseIf IsWhereTheRoadLeads() Then
		$Skips = 2
		$DungeonID = "Where the Road Leads"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 3
	ElseIf IsHabitatForWildPlants() Then
		$Skips = 3
		$DungeonID = "Habitat for Wild Plants"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
	ElseIf IsGiveABeggarACoin() Then
		$Skips = 2
		$DungeonID = "Give a Beggar a Coin..."
		$PartySize = 4
		$DungeonNumOaths = 5
	ElseIf IsGremlinLair() Then
		$Skips = 3
		$DungeonID = "Gremlin Lair"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 3
	ElseIf IsBandits() Then
		$Skips = 2
		$DungeonID = "Bandits"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsAnotherStoreroom() Then
		$Skips = 2
		$DungeonID = "Another Storeroom"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsHerbLands() Then
		$Skips = 3
		$DungeonID = "Herb Lands"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsRockyWilderness() Then
		$Skips = 3
		$DungeonID = "Rocky Wilderness"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsSewers() Then
		$Skips = 3
		$DungeonID = "Sewers"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 4
	ElseIf IsBeginningOfTheMemory() Then
		$Skips = 2
		$DungeonID = "Beginning of the Memory"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonVIP = True
		$DungeonNumOaths = 3
	ElseIf IsGoldLeather() Then
		$Skips = 2
		$DungeonID = "Gold Leather"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 2
		$DungeonLocPos = 4
	ElseIf IsWindThroughTheRuins() Then
		$Skips = 2
		$DungeonID = "Wind Through The Ruins"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
		$DungeonLocPos = 6
	ElseIf IsFrostStones() Then
		$Skips = 3
		$DungeonID = "Frost Stones"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 3
		$DungeonVIP = True
	ElseIf IsATownEngulfed() Then
		$Skips = 1
		$DungeonID = "A Town Engulfed"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 4
		$DungeonVIP = True
	ElseIf IsHellBeyondTheDoor() Then
		$Skips = 3
		$DungeonID = "Hell Beyond the Door"
		$DungeonOathPos = 4
		$PartySize = 4
		$DungeonNumOaths = 5
		$DungeonVIP = True
	ElseIf IsResenliansLabyrinth() Then
		$Skips = 41
		$DungeonID = "Resenlian's Labyrinth"
		$DungeonOathPos = 0
		$PartySize = 4
		$DungeonNumOaths = 1
	ElseIf IsSouthernRockCliff() Then
		$Skips = 1
		$DungeonID = "Southern Rock Cliff"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 2
		$DungeonVIP = True
	ElseIf IsFriendOrFoe() Then
		$Skips = 2
		$DungeonID = "Friend or Foe"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 3
		$DungeonVIP = True
	ElseIf IsPiercingTheCrescentMoon() Then
		$Skips = 2
		$DungeonID = "Piercing the Crescent Moon"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 3
		$DungeonVIP = True
	ElseIf IsUlchassRelic() Then
		$Skips = 3
		$DungeonID = "Ulchas's Relic"
		$DungeonOathPos = 2
		$PartySize = 4
		$DungeonNumOaths = 3
		$DungeonVIP = True
	ElseIf IsEllissTrust() Then
		$Skips = 2
		$DungeonID = "Ellis's Trust"
		$DungeonOathPos = 1
		$PartySize = 4
		$DungeonNumOaths = 4
		$DungeonVIP = True
	ElseIf IsBloodPrince() Then
		$Skips = 0
		$DungeonID = "Blood Prince"
		$DungeonOathPos = 3
		$PartySize = 4
		$DungeonNumOaths = 4
		$DungeonVIP = True
EndIf
	IdentifyDifficulty()
	WriteLogFile("Dungeon identified as: " & $DungeonID)
	WriteLogFile("Difficulty setting: " & $Difficulty)
EndFunc

Func IdentifyMining ()
	$InMiningDungeon = False
	If IsFruitful() Then
		If (Not $Locked) Then
			$Skips = 1
			$DungeonID = "Fruitful [Mining]"
			$DungeonOathPos = 3
			$PartySize = 4
			$DungeonVIP = True
			$InMiningDungeon = True
		EndIf
	ElseIf IsDethroneTheWhiteTyrant() Then
		$Skips = 0
		$DungeonID = "Dethrone the White Tyrant [Mining]"
		$DungeonOathPos = 3
		$PartySize = 6
		$DungeonVIP = True
		$InMiningDungeon = True
	EndIf
EndFunc

Func IdentifyLeveling ()
	$InLevelingDungeon = False
	If IsResenliansLabyrinth() Then
		$Skips = 40
		$DungeonID = "Resenlian's Labyrinth [Leveling]"
		$DungeonOathPos = 0
		$PartySize = 4
		$DungeonNumOaths = 1
		$InLevelingDungeon = True
	EndIf
EndFunc


Func CheckMiniMap($x, $y)
	WriteLog("Waiting for minimap.")
	Dim $timer = 15000
	Do
		Sleep(250)
		$timer -= 250
	Until (IsColorMatch(PixelGetColor($vinRes[0] - 112, 153), 0x9BE600) Or IsColorMatch(PixelGetColor($vinRes[0] - 110, 153), 0x9BE600) Or IsColorMatch(PixelGetColor($vinRes[0] - 110, 152), 0x9BE500) Or IsColorMatch(PixelGetColor($vinRes[0] - 111, 155), 0x9CE700)) Or ($timer <= 0)
	WriteLog("Checking minimap.")
	_Send("{ALT DOWN}")
	Sleep(200)
	_MouseMove($vinRes[0] - 195, 249, $SettingMouseSpeed)	;bottom left edge of minimap
	Sleep(200)
	Dim $pixel = PixelGetColor($x, $y)
	_Send("{ALT UP}")
	Return $pixel
EndFunc

Func IdentifyDifficulty ()
	Dim $color

	$color = fastPixelGetColor(10, 68)
	Select
		Case IsColorMatch($color, 0x801808)
			$Difficulty = "Hero"
		Case IsColorMatch($color, 0xA16008)
			$Difficulty = "Hard"
		Case IsColorMatch($color, 0x43681B)
			$Difficulty = "Normal"
		Case Else
			$Difficulty = "Hero"
	EndSelect
EndFunc

Func FirstRun ($LogThis = True, $Transform = True, $MineBombs = False, $OHK = True)
	BossRoomPrep($Transform, $MineBombs, $OHK)
	If $LogThis Then
		WriteLog("Sleeping for 10 minutes...")
	EndIf
	Sleep(300000);
	If $LogThis Then
		WriteLog("5 minutes remaining...")
	EndIf
	Sleep(120000);
	If $LogThis Then
		WriteLog("3 minutes remaining...")
	EndIf
	Sleep(60000);
	If $LogThis Then
		WriteLog("2 minutes remaining...")
	EndIf
	Sleep(60000);
	If $LogThis Then
		WriteLog("1 minute remaining...")
	EndIf
	Sleep(60000);
	$BossInProgress =  True
	If $LogThis Then
		WriteLog("Starting boss kill procedure.")
	EndIf
EndFunc

Func RunDungeon ()
	If Not $BossInProgress Then
		WriteLog("Preparing for boss fight.")
	EndIf
	Select
		Case $DungeonID == "The Weeping Queen"					;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				FirstRun(False, False)
				ToggleRateStatic()
				Sleep(13000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				FirstRun(True, False)
			EndIf
		Case $DungeonID == "Decisive Battle"					;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					PremiumMove(-500, 0, 104, 20)
				Else
					FirstRun()
					ToggleRate()
					Dungeon_DecisiveBattle()
					Nuke()
				EndIf
			EndIf
		Case $DungeonID == "The Contract"						;good - Dungeon_BuriedSorrow
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BuriedSorrow()
				Nuke()
			EndIf
		Case $DungeonID == "Trampled Plains"					;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Brynn's Research"					;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Kobold Chief"						;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Dethrone the White Tyrant"			;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				FirstRun(True, False)
				SkipToTriggerPoint()
				ToggleRateStatic()
				Sleep(17000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				Sleep(5000)
				SkipToTriggerPoint()
				_Send($BindSmall)
				Sleep(200)
				ToggleRateStatic()
				Sleep(15000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				ToggleRate()
			EndIf
		Case $DungeonID == "White Tyrant's Challenge"			;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				FirstRun(True, False)
				SkipToTriggerPoint()
				_Send($BindSmall)
				ToggleRateStatic()
				Sleep(17000/$SettingHostTimeScaleStatic)
				If $SettingUseTimeHack == 0 Then
					ToggleRateStatic()
				EndIf
			EndIf
		Case $DungeonID == "Dead End Street"					;good - Dungeon_DeadEndStreet
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DeadEndStreet()
				Nuke()
			EndIf
		Case $DungeonID == "Being from the Other World"			;good - Dungeon_BeingFromTheOtherWorld
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BeingFromTheOtherWorld()
				Nuke()
			EndIf
		Case $DungeonID == "Where the legend Sleeps"			;good - Dungeon_BeingFromTheOtherWorld
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BeingFromTheOtherWorld()
				Nuke()
			EndIf
		Case $DungeonID == "Regrets... Too Late"				;good - Dungeon_RegretsTooLate
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_RegretsTooLate()
				Nuke()
			EndIf
		Case $DungeonID == "The Unveiling Truth"				;good - Dungeon_RegretsTooLate
			If $BossInProgress Then
				SpamKill(1)
				$DungeonTempVar += 1
				If $DungeonTempVar == 30 Then
					FirstRun(False)
					$DungeonTempVar = 0
				EndIf
			Else
				$DungeonTempVar = 0
				FirstRun()
				ToggleRate()
				Dungeon_RegretsTooLate()
				Nuke()
			EndIf
		Case $DungeonID == "Friends?"							;good - Dungeon_DecisiveBattle(30000)
			If $BossInProgress Then
				SpamKill(1)
				;$DungeonTempVar += 1
				;If $DungeonTempVar == 30 Then
				;	FirstRun(False)
				;	$DungeonTempVar = 0
				;EndIf
			Else
				$DungeonTempVar = 0
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle(30000)
				Nuke()
			EndIf
		Case $DungeonID == "Revenge"							;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Final Slingshot"					;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Source of the Rumor"				;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Prepare for Counterattack"			;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
				;$DungeonTempVar += 1
				;If $DungeonTempVar == 30 Then
				;	FirstRun(False)
				;	$DungeonTempVar = 0
				;EndIf
			Else
				$DungeonTempVar = 0
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Culprit Behind the Disturbance"		;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Spider Overload"					;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Wake Up Call"						;good - Dungeon_DecisiveBattle(22500)
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle(22500)
				Nuke()
			EndIf
		Case $DungeonID == "Depths of Ainle"					;good - Dungeon_DeadEndStreet
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DeadEndStreet()
				Nuke()
			EndIf
		Case $DungeonID == "Burnt Pumpkin Field"				;good - Dungeon_BeingFromTheOtherWorld
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BeingFromTheOtherWorld()
				Nuke()
			EndIf
		Case $DungeonID == "Holy Ground"						;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Shadowed by Darkness"				;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				;two methods
				FirstRun(True, False)
				ToggleRate()
				_Send($MoveForwardDown)
				Sleep(10000/$SettingHostTimeScaleUse*$SpeedMod)
				_Send($MoveForwardUp)
			EndIf
		Case $DungeonID == "Where the legend sleeps"			;good - Dungeon_BeingFromTheOtherWorld
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BeingFromTheOtherWorld()
				Nuke()
			EndIf
		Case $DungeonID == "Fomorian Order"						;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Prairie Gnoll"						;good - Dungeon_CadetsChallenge / Dungeon_PrairieGnollB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 95, 215)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_CadetsChallenge()
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")
					FirstRun()
					ToggleRate()
					Dungeon_PrairieGnollB()
					Nuke()
				EndIf
			EndIf
		Case $DungeonID == "Ruins of Sanctity"					;good - Dungeon_RuinsOfSanctityA / Dungeon_RuinsOfSanctityB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 160, 200)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_RuinsOfSanctityA()
						BossRoomPrep()							;dungeon takes about 2 minutes to get through, this will make sure we stay transformed
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_RuinsOfSanctityB()
					Else
						NotSupported()
					EndIf
				EndIf
			EndIf
		Case $DungeonID == "Goliath"							;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Hidden"								;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				ToggleRate()
				Sleep(6000/$SettingHostTimeScaleUse*$SpeedMod)
				ToggleRate()
				FirstRun(True, False)
			EndIf
		Case $DungeonID == "Nightmare at the Ruins"				;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				ToggleRate()
				Sleep(5500/$SettingHostTimeScaleUse*$SpeedMod)
				ToggleRate()
				FirstRun(True, False)
			EndIf
		Case $DungeonID == "Gnoll King, Ruler of the Ruins"		;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Hoarfrost Hollow in Flames"			;good - Dungeon_AnotherSlingshot / Dungeon_Madness
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 180, 160)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					FirstRun()
					ToggleRate()
					Dungeon_AnotherSlingshot()
					Nuke()
				Else
					;generic boss room
					WriteLog("Identified Boss Room B.")
					FirstRun()
					ToggleRate()
					Dungeon_Madness()
					Nuke()
				EndIf
			EndIf
		Case $DungeonID == "Yeti King"							;good - Dungeon_Madness+
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				FirstRun()
				ToggleRate()
				Dungeon_Madness()
				ToggleRate()
				ToggleRateStatic()
				Sleep(11000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				ToggleRate()
				Nuke()
			EndIf
		Case $DungeonID == "Madness"							;good - Dungeon_Madness+
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_Madness()
				ToggleRate()
				ToggleRateStatic()
				Sleep(10500/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				ToggleRate()
				Nuke()
			EndIf
		Case $DungeonID == "Irukul"								;good
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun(False, False)
				SkipToTriggerPoint()
				ToggleRateStatic()
				Sleep(8000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				Sleep(2000)
				SkipToTriggerPoint()
				ToggleRateStatic()
				Sleep(2000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				FirstRun()
				Nuke()
			EndIf
		Case $DungeonID == "Revived Fear"						;good - Dungeon_RevivedFear
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_RevivedFear()
				Nuke()
			EndIf
		Case $DungeonID == "Unfinished Business"				;good - Dungeon_AnotherSlingshot
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_AnotherSlingshot()
				Nuke()
			EndIf
		Case $DungeonID == "The Howling Soul"					;good - Dungeon_Madness
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_Madness()
				Nuke()
			EndIf
		Case $DungeonID == "Two Moons"							;good - Dungeon_Madness
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_Madness()
				Nuke()
			EndIf
		Case $DungeonID == "Appearance of a Small Bear"			;good - Dungeon_AnotherSlingshot
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_AnotherSlingshot()
				Nuke()
			EndIf
		Case $DungeonID == "Snowman Alert"						;good - Dungeon_SnowmanAlert
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_SnowmanAlert()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Proof of Courage"					;good - Dungeon_KoboldChief
			If $BossInProgress Then
				SpamKill(1)
			Else
				$DungeonTempVar = 0
				FirstRun()
				ToggleRate()
				Dungeon_KoboldChief()
				Nuke()
			EndIf
		Case $DungeonID == "Fight That Must Be Won"				;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Shady Forest"						;good
			If $BossInProgress Then
				SpamSpears(5)
			Else
				ToggleRateStatic()
				Sleep(8500/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				Sleep(200)
				ToggleRate()
				FirstRun(True, False)
				Nuke()
			EndIf
		Case $DungeonID == "West Hilder Forest"					;good - Dungeon_WestHilderForest
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_WestHilderForest()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Forest Ruins"						;good - Dungeon_RuinsOfSanctityB / Dungeon_ForestRuinsB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 180, 240)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_RuinsOfSanctityB()
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")
					FirstRun()
					ToggleRate()
					Dungeon_ForestRuinsB()
					Nuke()
				EndIf
			EndIf
		Case $DungeonID == "Contact"							;good - Dungeon_Contact
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_Contact()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Cadet's Challenge"					;good - Dungeon_CadetsChallenge
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_CadetsChallenge()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Lost Road"							;good - Dungeon_BuriedSorrow
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BuriedSorrow()
				Nuke()
			EndIf
		Case $DungeonID == "Buried Sorrow"						;good - Dungeon_BuriedSorrow
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BuriedSorrow()
				Nuke()
			EndIf
		Case $DungeonID == "Rocktune's Cabin"					;good - Dungeon_RocktunesCabin
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_RocktunesCabin()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Colhen in Flames"					;good
			If $BossInProgress Then
				SpamKill(1)
			Else
				ToggleRateStatic()
				Sleep(29000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				ToggleRate()
				FirstRun()
				Nuke()
			EndIf
		Case $DungeonID == "Rescue"								;good
			If $BossInProgress Then
				SpamKill(1)
			Else
				SkipToTriggerPoint()
				_Send("{ESC}")
				FirstRun()
				ToggleRate()
				Nuke()
			EndIf
		Case $DungeonID == "Storeroom"							;good - Dungeon_RocktunesCabin
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_RocktunesCabin()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "The Last Fragment"					;good - Dungeon_BuriedSorrow
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BuriedSorrow()
				Nuke()
			EndIf
		Case $DungeonID == "The Investigation"					;good - Dungeon_TheInvestigationA / Dungeon_TheInvestigationB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 180, 125)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")	;blade room
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_TheInvestigationA()
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")	;falling rocks from rope trap room
					FirstRun()
					ToggleRate()
					Dungeon_TheInvestigationB()
				EndIf
			EndIf
		Case $DungeonID == "Investigation"						;good - Dungeon_RuinsOfSanctityA
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_RuinsOfSanctityA()
					BossRoomPrep()							;dungeon takes about 2 minutes to get through, this will make sure we stay transformed
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Mercenary Training Site"			;good - Dungeon_MercenaryTrainingSite
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					;FirstRun()
					;ToggleRate()
					;Dungeon_MercenaryTrainingSite()
					;BossRoomPrep()								;making sure
					PremiumMove(1522, 2300, 104, 1000)
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Fruitful"							;good - Dungeon_BuriedSorrow / Dungeon_TheFleeingGnollKingA
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 115, 110)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					FirstRun()
					ToggleRate()
					Dungeon_BuriedSorrow()
					Nuke()
				Else
					WriteLog("Identified Boss Room B.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_TheFleeingGnollKingA()
					Else
						NotSupported()
					EndIf
				EndIf
			EndIf
		Case $DungeonID == "Pursuit"							;good - Dungeon_BuriedSorrow / Dungeon_PursuitB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 115, 110)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					FirstRun()
					ToggleRate()
					Dungeon_BuriedSorrow()
					Nuke()
				Else
					WriteLog("Identified Boos Room B.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_PursuitB()
					Else
						NotSupported()
					EndIf
				EndIf
			EndIf
		Case $DungeonID == "Chicanery"							;good - Dungeon_Chicanery
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_Chicanery()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "The Secret"							;good - Dungeon_BuriedSorrow(8000)
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BuriedSorrow(8000)
				Nuke()
			EndIf
		Case $DungeonID == "Taking Initiative"					;good - Dungeon_TakingInitiative+
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_TakingInitiative()
				Sleep(1000)
				_Send("{ESC}")
				Sleep(1000)
				_Send($MoveLeftDown)
				_Send($MoveForwardDown)
				Sleep(3000/$SettingHostTimeScaleUse*$SpeedMod)
				_Send($MoveForwardUp)
				_Send($MoveLeftUp)
				Nuke()
			EndIf
		Case $DungeonID == "Ambush"								;good - Dungeon_Ambush+
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_Ambush()
					ToggleRate()
					ToggleRateStatic()
					Sleep(39000/$SettingHostTimeScaleStatic)
					ToggleRateStatic()
					ToggleRate()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Strong Drink"						;good - Dungeon_StrongDrink
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_StrongDrink()
				Nuke()
			EndIf
		Case $DungeonID == "What the Dead Leave Behind"			;good - [NOTHING] / Dungeon_WhatTheDeadLeaveBehindB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 125, 205)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					WriteLog("This Boss Room is not currently supported.")
					Forfeit()
				Else
					WriteLog("Identified Boss Room B.")
					FirstRun()
					ToggleRate()
					Dungeon_WhatTheDeadLeaveBehindB()
				EndIf
			EndIf
		Case $DungeonID == "Gatekeeper of the Catacombs"		;good - Dungeon_DecisiveBattle(4750)+
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle(4750)
				ToggleRate()
				ToggleRateStatic()
				Sleep(20000/$SettingHostTimeScaleStatic)
				ToggleRateStatic()
				ToggleRate()
				Nuke()
			EndIf
		Case $DungeonID == "Red Ruins"							;good - Dungeon_RedRuins
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_RedRuins()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Fomorian Emblem"					;good - Dungeon_FomorianEmblem+
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					PremiumMove(600, 260, 550, 100)
					;FirstRun()
					;ToggleRate()
					;Dungeon_FomorianEmblem()
					;ToggleRate()
					;ToggleRateStatic()
					;Sleep(10000/$SettingHostTimeScaleStatic)
					;ToggleRateStatic()
					;ToggleRate()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Another Slingshot"					;good - Dungeon_AnotherSlingshot
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_AnotherSlingshot()
				Nuke()
			EndIf
		Case $DungeonID == "Hoarfrost Hollow"					;good - Dungeon_HoarfrostHollow
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HoarfrostHollow()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Windgun"							;good - Dungeon_HoarfrostHollow
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HoarfrostHollow()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Gwynn's Request"					;good - Dungeon_DecisiveBattle
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle()
				Nuke()
			EndIf
		Case $DungeonID == "Where the Sun Don't Shine"			;good - Dungeon_StrongDrink
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_StrongDrink()
				Nuke()
			EndIf
		Case $DungeonID == "Where the Road Leads"				;good - Dungeon_StrongDrink
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_StrongDrink()
				Nuke()
			EndIf
		Case $DungeonID == "Western Ice Passage"				;good - Dungeon_HoarfrostHollow
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HoarfrostHollow()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Habitat for Wild Plants"			;good - Dungeon_HabitatForWildPlants
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HabitatForWildPlants()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Give a Beggar a Coin..."			;good - Dungeon_GiveABeggarACoinA / [NOTHING]
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 108, 138)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_GiveABeggarACoinA()
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Gremlin Lair"						;good - Dungeon_TheFleeingGnollKingA
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_TheFleeingGnollKingA()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Bandits"							;good - Dungeon_TheFleeingGnollKingA / Dungeon_Chicanery
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 188, 224)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_TheFleeingGnollKingA()
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_Chicanery()
					Else
						NotSupported()
					EndIf
				EndIf
			EndIf
		Case $DungeonID == "Another Storeroom"					;good - Dungeon_CadetsChallenge / Dungeon_AnotherStoreroomB
			If $BossInProgress Then
				SpamKill(1)
			Else
				Dim $pixel = CheckMiniMap($vinRes[0] - 188, 224)
				If $pixel > 3000000 And $pixel < 5000000 Then
					WriteLog("Identified Boss Room A.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_CadetsChallenge()
					Else
						NotSupported()
					EndIf
				Else
					WriteLog("Identified Boss Room B.")
					If $IsPremium Then
						FirstRun()
						ToggleRate()
						Dungeon_AnotherStoreroomB()
					Else
						NotSupported()
					EndIf
				EndIf
			EndIf
		Case $DungeonID == "Herb Lands"							;good - Dungeon_CadetsChallenge
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_CadetsChallenge()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Rocky Wilderness"
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_AnotherStoreroomB()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID = "Beginning of the Memory"
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_BeginningOfTheMemory()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID = "Gold Leather"
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_GoldLeather()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID = "Wind Through The Ruins"
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_WindThroughTheRuins()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID = "Frost Stones"
			If $BossInProgress Then
				SpamSpears(5)
			Else
				FirstRun(False, False, False, False)
				ToggleRate()
				Dungeon_FrostStones()
				If $SettingKeyboardMode == 0 Then
					_MouseMove($vinCenter[0] - 90, $vinCenter[1])
					Sleep(100)
				Else
					Sleep(500)
					_Send($MoveLeftDown)
					Sleep(1665)
					_Send($MoveLeftUp)
				EndIf
				SpamSpears(150)
				_Send($BindOHK)
			EndIf
		Case $DungeonID == "A Town Engulfed"								;good - Dungeon_ATimeEngulfed
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_ATownEngulfed()
					ToggleRate()
					ToggleRateStatic()
					Sleep(12200/$SettingHostTimeScaleStatic)
					ToggleRateStatic()
					ToggleRate()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID = "Hell Beyond the Door"
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HellBeyondTheDoor()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID = "Resenlian's Labyrinth"
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle(5000)
				Nuke()
			EndIf
		Case $DungeonID = "Resenlian's Labyrinth [Leveling]"
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_DecisiveBattle(5000)
				Nuke()
			EndIf
		Case $DungeonID == "Southern Rock Cliff"				;good - Dungeon_HoarfrostHollow
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HoarfrostHollow()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Friend or Foe"						;good - Dungeon_HoarfrostHollow
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_FriendOrFoe()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Piercing the Crescent Moon"			;good - Dungeon_ATownEngulfed
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_ATownEngulfed()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Ulchas's Relic"						;good - Dungeon_HellBeyondTheDoor
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_HellBeyondTheDoor()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Ellis's Trust"
			If $BossInProgress Then
				SpamKill(1)
			Else
				If $IsPremium Then
					FirstRun()
					ToggleRate()
					Dungeon_EllissTrust()
				Else
					NotSupported()
				EndIf
			EndIf
		Case $DungeonID == "Blood Prince"
			If $BossInProgress Then
				SpamKill(1)
			Else
				FirstRun()
				ToggleRate()
				Dungeon_BloodPrince()
			EndIf
		Case Else
			WriteLog("This dungeon is not supported.")
			Begin(True)
	EndSelect
EndFunc

Func RunLeveling()
	Select
		Case $DungeonID == "Resenlian's Labyrinth [Leveling]"
			FirstRun()
			ToggleRate()
			Dungeon_DecisiveBattle(5000)
			Nuke()
			;SpamSkill(10)
			Sleep(1000)
			$Runs += 1
			WriteLog("Completed leveling run #" & $Runs & ".")
	EndSelect
EndFunc

Func RunMining ()
	Select
		Case $DungeonID == "Fruitful [Mining]"
			FirstRun(False, True, True)
			MoveTo_Fruitful()
			_Send($FireSecondary)
			If $SettingKeyboardMode == 0 Then
				_MouseMove($vinCenter[0] - 50, $vinCenter[1] - 10)
				Sleep(100)
				_MouseClick("left", $vinCenter[0], $vinCenter[1], 1, 0)
			Else
				_Send($FireSecondary)
				Sleep(500)
				_Send($MoveLeftDown)
				Sleep(925)
				_Send($MoveLeftUp)
				_Send("{S}")
			EndIf
			_Send($MoveForwardDown)
			Sleep(3000)
			_Send($MoveForwardUp)
			Sleep(500)
			CollectDrops(20)
			$Runs += 1
			WriteLog("Completed mining run #" & $Runs & ".")
		Case $DungeonID = "Dethrone the White Tyrant [Mining]"
			FirstRun(False, False, True)
			MoveTo_DethroneTheWhiteTyrant()
			_Send($FireSecondary)
			If $SettingKeyboardMode == 0 Then
				_MouseMove($vinCenter[0] - 81, $vinCenter[1] + 10)
				Sleep(100)
				_MouseClick("left", $vinCenter[0], $vinCenter[1], 1, 0)
			Else
				Sleep(500)
				_Send($MoveLeftDown)
				Sleep(1499)
				_Send($MoveLeftUp)
				_Send("{S}")
			EndIf
			CollectDrops(20)
			$Runs += 1
			WriteLog("Completed mining run #" & $Runs)
	EndSelect
EndFunc

Func LetterBoxCheck($x, $y)
	Return PixelGetColor((($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2) + ((($vinRes[0] - ((($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2) * 2)) / 1024) * $x), ($vinRes[1] / 768) * $y)
EndFunc

Func NotSupported()
	WriteLog("This Boss Room is not currently supported.")
	Forfeit()
EndFunc

Func Zoom($x, $y, $z)
	If $IsPremium Then
		;SkipToTriggerPoint()
		SendCommandPosition($x, $y, $z)
	EndIf
EndFunc

Func BreakTriggerThreshold ($size)
	If $IsPremium Then
		Dim $px = SendCommandSize($size)
		;Dim $px = PixelGetColor($vinCenter[0], $vinCenter[1] / 2)
		Sleep(500)
		_Send($BindNormal)
		Sleep(500)

		;Do
		;	Sleep(100)
		;Until PixelGetColor($vinCenter[0], $vinCenter[1] / 2) <> $px
	EndIf
EndFunc

Func PremiumMove($x, $y, $z, $size)
	FirstRun()
	BreakTriggerThreshold($size)
	Zoom($x, $y, $z)
	Sleep(500)
EndFunc

