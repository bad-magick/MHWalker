#include-once
#include "Utils.au3"
#include "Donator.au3"

Dim $seed = "5380C73022AB8D66199042BC5E128DF4F03B1D4A79962B2FC14FA61B494AED0E4A09604DB9659529E3F37559E42480E00D8291E8A85B8E88D58EC27251121AB9A8E75BF2E6B79DC9D3E89CF4A7D27F042B68661D7C2B95DCF05A6827275FC9F68392D1A061837B1B54F9A8EF16D6AF8F21C03FDAD6738BDB4D5559F0C0DAAA0DE9AAB23D5FC01DAED26E40A7FAF88EF49942219139E955B0F7A78E50125A5A5116E156329DB83847EE5542ED5D6E5E89E463B78D8FCB8473C96F4A73909D86EA6E8375461500B6582310B6686DE72AEA766A31522CC4400CB7532E71D65EC53D0CBBF8D1E0F252B316C36CC4A4AE199DA2F00036562C4A2930CF986C6E8872B1D93F0436B8607AC659EFB33BD67E2775D3CD552A29DDC82C1090814AE4334464C22E8492E696FA096B584D87928E8BACAC3D59EDC174287A8C57C4F4ABD1DC9474D771B0650A370F324F9A3BD491DB6BCF82186E17EC36DBB6E71739688FD75ACE8DC578BD51ED95387B388AD941E62889C14897778E1A9CA62874A1FC4997EF45549134F95A1D257B8E41B08E27669B5F6EE7AB53B0D3788CD02291570B0E4733E5361CC6889E995F7F851D5A2ACEAF63A8311D64323CF8F8FC15CC56305C41A421974F93A47E990498F55C2D0DFD6EA143B3B7DA0C3572A66E6F7455D49E49FDD66841DD0C8D2ADE312C2240004806880E73AF7C9F6F7C0BA1CEB16C26CE0D"

Global $SettingsFile

Global $KeyShutDown = "{END}"
Global $KeyPause = "{PAUSE}"
Global $KeyStart = "{INS}"
Global $KeyLegend = "{DEL}"
Global $KeyPauseAfterRun = "{HOME}"

Global $BindGod = ""
Global $BindOHK = ""
Global $BindSmall = ""
Global $BindLarge = ""
Global $BindNormal = ""
Global $BindTrans1 = ""
Global $BindTrans2 = ""
Global $BindTenticle = ""
Global $BindTimescale = ""
Global $BindSkipMap = ""
Global $BindSpears = ""
Global $BindShipList = ""
Global $BindLBBypass = ""
Global $BindCSBypass = ""
Global $BindColhan = ""
Global $BindRocheste = ""
Global $BindMineBombs = ""
Global $BindPickupDistance = ""
Global $BindReloadMap = ""
Global $BindMailbox = "{F5}"
Global $BindShop = "{F6}"
Global $BindCloseWindow = "{F7}"
Global $BindCloseAlchemy = "{F8}"
Global $BindIK = "{NUMPADMULT}"
Global $BindBreak = "{NUMPAD1}"
Global $BindWharf = "/"
Global $BindGravity = "{NUMPADMULT}"	;TODO
Global $BindNuke = "{NUMPADDOT}"
Global $BindKill1 = "{NUMPAD2}"

Global $DelayToTownLag = 15000			;internal
Global $DelayErrorWait = 60000			;TODO
Global $DelayDungeonComplete = 300000
Global $DelayMakeBoatWaitMax = 30000	;TODO
Global $DelayLeavePartyWaitMax = 10000	;TODO
Global $DelayToTownWaitMax = 20000		;TODO
Global $DelayReplayWait = 15000			;TODO

Global $SettingWriteLogFile = 1
Global $SettingLogSize = 10
Global $SettingDeleteLogFile = 0
Global $SettingSpendAP = 1
Global $SettingSpendAPRuns = 10
;Global $SettingPauseOnLoseFocus = 0
Global $SettingOnLoseFocus = 0
Global $SettingMaxRuns = 0
Global $SettingKeyboardMode = 0
Global $SettingEU = 0
Global $SettingUseEU = 0				;Do not write into settings file
Global $SettingUseTimeHack = 0
Global $SettingHostTimeScale = 5
Global $SettingHostTimeScaleUse = 1
Global $SettingNonWindowMode = 0
Global $SettingFastBattleCleared = 1
Global $SettingSlowMouse = 0
Global $SettingSpeedupScene = 1
Global $SettingChangeChannel = 1
Global $SettingChannelMin = 160
Global $SettingChannelMax = 190
Global $SettingCloseBattleCleared = 1
Global $SettingLogoutTime = 5
Global $SettingLogout = 1
Global $SettingPickItems = 1
Global $SettingBreakItems = 1

Global $SettingMouseSpeed = 5			;internal
Global $SettingHostTimeScaleStatic = 1	;internal
Global $SettingPauseOnLoseFocus = 0		;internal
Global $SettingForceOnLoseFocus = 0		;internal

Global $LoginUserID = ""
Global $LoginPassword = ""
Global $LoginServer = ""
Global $LoginCharIndex = ""

Global $MerchantOn = 0
Global $MerchantNoScrolls = 1
Global $MerchantNoEmpowered = 1
Global $MerchantNoEpic = 1
Global $MerchantNoMagicPowder = 1
Global $MerchantNoBlessedPowder = 1
Global $MerchantChests[8]
Global $MerchantRuns = 1

Global $WebServerOn = 0
Global $WebServerPort = 8187

Global $WindowX = 0
Global $WindowY = 0

Global $MoveForward = "w"
Global $MoveForwardDown = "{W DOWN}"
Global $MoveForwardUp = "{W UP}"
Global $MoveBackward = "s"
Global $MoveBackwardDown = "{S DOWN}"
Global $MoveBackwardUp = "{S UP}"
Global $MoveLeft = "a"
Global $MoveLeftDown = "{A DOWN}"
Global $MoveLeftUp = "{A UP}"
Global $MoveRight = "d"
Global $MoveRightDown = "{D DOWN}"
Global $MoveRightUp = "{D UP}"
Global $FireSecondary = "f"
Global $Pickup = "e"
Global $UIInventory = "i"
Global $UISkills = "v"
Global $UIBattles = "n"

;Advanced Section - DO NOT WRITE TO FILE
Global $ColorDelta = 16
Global $ColorYUV = 1
Global $SettingIdentifyAttempts = 3
Global $DelayMiningTime = 3300000
Global $WebServerMaxConnections = 15

Func SaveWindow ($hWnd)
	Dim $pos
	$pos = WinGetPos($hWnd)
	If IsOnScreen($pos[0], $pos[1]) Then
		IniWrite($SettingsFile, "Window", "X", $pos[0])
		IniWrite($SettingsFile, "Window", "Y", $pos[1])
	Else
		IniWrite($SettingsFile, "Window", "X", "100")
		IniWrite($SettingsFile, "Window", "Y", "100")
	EndIf
EndFunc

Func SaveSettings ()
	IniWrite($SettingsFile, "HotKeys", "Exit", $KeyShutDown)
	IniWrite($SettingsFile, "HotKeys", "Pause", $KeyPause)
	IniWrite($SettingsFile, "HotKeys", "Start", $KeyStart)
	IniWrite($SettingsFile, "HotKeys", "Legend", $KeyLegend)
	IniWrite($SettingsFile, "HotKeys", "PauseAfter", $KeyPauseAfterRun)
	IniWrite($SettingsFile, "Binds", "God", $BindGod)
	IniWrite($SettingsFile, "Binds", "OHK", $BindOHK)
	IniWrite($SettingsFile, "Binds", "Small", $BindSmall)
	IniWrite($SettingsFile, "Binds", "Large", $BindLarge)
	IniWrite($SettingsFile, "Binds", "Normal", $BindNormal)
	IniWrite($SettingsFile, "Binds", "Paladin1", $BindTrans1)
	IniWrite($SettingsFile, "Binds", "Paladin2", $BindTrans2)
	IniWrite($SettingsFile, "Binds", "Tenticle", $BindTenticle)
	IniWrite($SettingsFile, "Binds", "Timescale", $BindTimescale)
	IniWrite($SettingsFile, "Binds", "SkipMap", $BindSkipMap)
	IniWrite($SettingsFile, "Binds", "Spears", $BindSpears)
	IniWrite($SettingsFile, "Binds", "ShipList", $BindShipList)
	IniWrite($SettingsFile, "Binds", "LBBypass", $BindLBBypass)
	IniWrite($SettingsFile, "Binds", "CSBypass", $BindCSBypass)
	IniWrite($SettingsFile, "Binds", "Colhan", $BindColhan)
	IniWrite($SettingsFile, "Binds", "Rocheste", $BindRocheste)
	IniWrite($SettingsFile, "Binds", "Mines", $BindMineBombs)
	IniWrite($SettingsFile, "Binds", "Pickup", $BindPickupDistance)
	IniWrite($SettingsFile, "Binds", "Reload", $BindReloadMap)
	IniWrite($SettingsFile, "Binds", "Mailbox", $BindMailbox)
	IniWrite($SettingsFile, "Binds", "Shop", $BindShop)
	IniWrite($SettingsFile, "Binds", "CloseWindow", $BindCloseWindow)
	IniWrite($SettingsFile, "Binds", "CloseAlchemy", $BindCloseAlchemy)
	IniWrite($SettingsFile, "Binds", "Nuke", $BindNuke)
	If $IsPremium Then IniWrite($SettingsFile, "Binds", "Kill1", $BindKill1)
	;IniWrite($SettingsFile, "Binds", "IK", $BindIK)
	;IniWrite($SettingsFile, "Binds", "Break", $BindBreak)
	IniWrite($SettingsFile, "Binds" , "Wharf", $BindWharf)
	IniWrite($SettingsFile, "Delays", "ToTownLag", $DelayToTownLag)
	IniWrite($SettingsFile, "Delays", "DungeonComplete", $DelayDungeonComplete)
	IniWrite($SettingsFile, "Options", "SpendAP", $SettingSpendAP)
	IniWrite($SettingsFile, "Options", "APRuns", $SettingSpendAPRuns)
	IniWrite($SettingsFile, "Options", "Logfile", $SettingWriteLogFile)
	IniWrite($SettingsFile, "Options", "LogSize", $SettingLogSize)
	IniWrite($SettingsFile, "Options", "DeleteLog", $SettingDeleteLogFile)
	IniWrite($SettingsFile, "Options", "MaxRuns", $SettingMaxRuns)
	IniWrite($SettingsFile, "Options", "OnUnfocus", $SettingOnLoseFocus)
	IniWrite($SettingsFile, "Options", "KeyboardMode", $SettingKeyboardMode)
	IniWrite($SettingsFile, "Options", "UseTimeHack", $SettingUseTimeHack)
	IniWrite($SettingsFile, "Options", "HostTimeScale", $SettingHostTimeScale)
	IniWrite($SettingsFile, "Options", "NonWindow", $SettingNonWindowMode)
	IniWrite($SettingsFile, "Options", "FastBattleCleared", $SettingFastBattleCleared)
	IniWrite($SettingsFile, "Options", "SlowMouse", $SettingSlowMouse)
	IniWrite($SettingsFile, "Options", "ChangeChannel", $SettingChangeChannel)
	IniWrite($SettingsFile, "Options", "ChannelMin", $SettingChannelMin)
	IniWrite($SettingsFile, "Options", "ChannelMax", $SettingChannelMax)
	IniWrite($SettingsFile, "Options", "CloseBattleCleared", $SettingCloseBattleCleared)
	IniWrite($SettingsFile, "Options", "FastCutscene", $SettingSpeedupScene)
	IniWrite($SettingsFile, "Options", "LogoutTime", $SettingLogoutTime)
	IniWrite($SettingsFile, "Options", "Relog", $SettingLogout)
	IniWrite($SettingsFile, "Options", "PickItems", $SettingPickItems)
	;IniWrite($SettingsFile, "Options", "BreakItems", $SettingBreakItems)
	IniWrite($SettingsFile, "Local", "EU", $SettingEU)
	IniWrite($SettingsFile, "Merchant", "On", $MerchantOn)
	IniWrite($SettingsFile, "Merchant", "NoScrolls", $MerchantNoScrolls)
	IniWrite($SettingsFile, "Merchant", "NoEmpowered", $MerchantNoEmpowered)
	IniWrite($SettingsFile, "Merchant", "NoEpic", $MerchantNoEpic)
	IniWrite($SettingsFile, "Merchant", "NoMagicPowder", $MerchantNoMagicPowder)
	IniWrite($SettingsFile, "Merchant", "NoBlessedPowder", $MerchantNoBlessedPowder)
	IniWrite($SettingsFile, "Merchant", "Chest2", $MerchantChests[0])
	IniWrite($SettingsFile, "Merchant", "Chest3", $MerchantChests[1])
	IniWrite($SettingsFile, "Merchant", "Chest4", $MerchantChests[2])
	IniWrite($SettingsFile, "Merchant", "Chest5", $MerchantChests[3])
	IniWrite($SettingsFile, "Merchant", "Chest6", $MerchantChests[4])
	IniWrite($SettingsFile, "Merchant", "Chest7", $MerchantChests[5])
	IniWrite($SettingsFile, "Merchant", "Chest8", $MerchantChests[6])
	IniWrite($SettingsFile, "Merchant", "Chest9", $MerchantChests[7])
	IniWrite($SettingsFile, "Merchant", "Runs", $MerchantRuns)
	;write login information
	Dim $user = ""
	Dim $pass = ""
	If ($LoginUserID <> "") And ($LoginPassword <> "") Then
		$user = __StringEncrypt(1, $LoginUserID, $seed, 6)
		$pass = __StringEncrypt(1, $LoginPassword, $seed, 5)
	EndIf
	IniWrite($SettingsFile, "Login", "UserID", $user)
	IniWrite($SettingsFile, "Login", "Pass", $pass)
	IniWrite($SettingsFile, "Login", "Server", $LoginServer)
	IniWrite($SettingsFile, "Login", "Char", $LoginCharIndex)

	;web server
	IniWrite($SettingsFile, "WebServer", "Use", $WebServerOn)
	IniWrite($SettingsFile, "WebServer", "Port", $WebServerPort)
EndFunc

Func ReadSettings ()
	$KeyShutDown = IniRead($SettingsFile, "HotKeys", "Exit", "{END}")
	$KeyPause = IniRead($SettingsFile, "HotKeys", "Pause", "{PAUSE}")
	$KeyStart = IniRead($SettingsFile, "HotKeys", "Start", "{INS}")
	$KeyLegend = IniRead($SettingsFile, "HotKeys", "Legend", "{DEL}")
	$KeyPauseAfterRun = IniRead($SettingsFile, "HotKeys", "PauseAfter", "{HOME}")
	$BindGod = IniRead($SettingsFile, "Binds", "God", "{NUMPAD0}")
	$BindOHK = IniRead($SettingsFile, "Binds", "OHK", "{NUMPADSUB}")
	$BindSmall = IniRead($SettingsFile, "Binds", "Small", "{NUMPAD4}")
	$BindLarge = IniRead($SettingsFile, "Binds", "Large", "[")
	$BindNormal = IniRead($SettingsFile, "Binds", "Normal", "{NUMPAD5}")
	$BindTrans1 = IniRead($SettingsFile, "Binds", "Paladin1", "{NUMPAD8}")
	$BindTrans2 = IniRead($SettingsFile, "Binds", "Paladin2", "{NUMPAD2}")
	$BindTenticle = IniRead($SettingsFile, "Binds", "Tenticle", "{NUMPADADD}")
	$BindTimescale = IniRead($SettingsFile, "Binds", "Timescale", "{NUMPADDIV}")
	$BindSkipMap = IniRead($SettingsFile, "Binds", "SkipMap", "{NUMPAD6}")
	$BindSpears = IniRead($SettingsFile, "Binds", "Spears", "{NUMPAD7}")
	$BindShipList = IniRead($SettingsFile, "Binds", "ShipList", "=")
	$BindLBBypass = IniRead($SettingsFile, "Binds", "LBBypass", "l")
	$BindCSBypass = IniRead($SettingsFile, "Binds", "CSBypass", "-")
	$BindColhan = IniRead($SettingsFile, "Binds", "Colhan", ",")
	$BindRocheste = IniRead($SettingsFile, "Binds", "Rocheste", ".")
	$BindIK = IniRead($SettingsFile, "Binds", "IK", "{NUMPADMULT}")
	$BindBreak = IniRead($SettingsFile, "Binds", "Break", "{NUMPAD1}")
	$BindWharf = IniRead($SettingsFile, "Binds", "Wharf", "/")
	$BindWharf = IniRead($SettingsFile, "Binds", "Mailbox", "{F5}")
	$BindWharf = IniRead($SettingsFile, "Binds", "Shop", "{F6}")
	$BindWharf = IniRead($SettingsFile, "Binds", "CloseWindow", "{F7}")
	$BindWharf = IniRead($SettingsFile, "Binds", "CloseAlchemy", "{F8}")
	If $IsPremium Then IniRead($SettingsFile, "Binds", "Kill1", "{NUMPAD2}")

	$BindMineBombs = IniRead($SettingsFile, "Binds", "Mines", "{NUMPAD9}")
	$BindPickupDistance = IniRead($SettingsFile, "Binds", "Pickup", "{]}")
	$BindReloadMap = IniRead($SettingsFile, "Binds", "Reload", "{NUMPAD3}")
	$BindNuke = IniRead($SettingsFile, "Binds", "Nuke", "{NUMPADDOT}")

	$DelayToTownLag = Int(IniRead($SettingsFile, "Delays", "ToTownLag", "15000"))
	$DelayDungeonComplete = Int(IniRead($SettingsFile, "Delays", "DungeonComplete", "300000"))
	$SettingSpendAP = Int(IniRead($SettingsFile, "Options", "SpendAP", "1"))
	$SettingSpendAPRuns = Int(IniRead($SettingsFile, "Options", "APRuns", "10"))
	$SettingWriteLogFile = Int(IniRead($SettingsFile, "Options", "LogFile", "1"))
	$SettingLogSize = Int(IniRead($SettingsFile, "Options", "LogSize", "10"))
	$SettingDeleteLogFile = Int(IniRead($SettingsFile, "Options", "DeleteLog", "0"))
	$SettingMaxRuns = Int(IniRead($SettingsFile, "Options", "MaxRuns", "0"))
	$SettingOnLoseFocus = Int(IniRead($SettingsFile, "Options", "OnUnfocus", "1"))
	$SettingKeyboardMode = Int(IniRead($SettingsFile, "Options", "KeyboardMode", "0"))
	$SettingUseTimeHack = Int(IniRead($SettingsFile, "Options", "UseTimeHack", "0"))
	$SettingHostTimeScale = Int(IniRead($SettingsFile, "Options", "HostTimeScale", "5"))
	$SettingNonWindowMode = Int(IniRead($SettingsFile, "Options", "NonWindow", "0"))
	$SettingFastBattleCleared = Int(IniRead($SettingsFile, "Options", "FastBattleCleared", "1"))
	$SettingSlowMouse = Int(IniRead($SettingsFile, "Options", "SlowMouse", "0"))
	$SettingChangeChannel = Int(IniRead($SettingsFile, "Options", "ChangeChannel", "1"))
	$SettingChannelMin = Int(IniRead($SettingsFile, "Options", "ChannelMin", "160"))
	$SettingChannelMax = Int(IniRead($SettingsFile, "Options", "ChannelMax", "190"))
	$SettingCloseBattleCleared = Int(IniRead($SettingsFile, "Options", "CloseBattleCleared", "1"))
	$SettingSpeedupScene = Int(IniRead($SettingsFile, "Options", "FastCutscene", "1"))
	$SettingLogoutTime = Int(IniRead($SettingsFile, "Options", "LogoutTime", "5"))
	$SettingLogout = Int(IniRead($SettingsFile, "Options", "Relog", "5"))
	$SettingPickItems = Int(IniRead($SettingsFile, "Options", "PickItems", "1"))
	$SettingBreakItems = Int(IniRead($SettingsFile, "Options", "BreakItems", "1"))
	If ($SettingSlowMouse == 1) Then
		$SettingMouseSpeed = 10
	Else
		$SettingMouseSpeed = 5
	EndIf
	$SettingEU = IniRead($SettingsFile, "Local", "EU", 0)
	;merchant
	$MerchantOn = Int(IniRead($SettingsFile, "Merchant", "On", "1"))
	$MerchantNoScrolls = Int(IniRead($SettingsFile, "Merchant", "NoScrolls", "1"))
	$MerchantNoEmpowered = Int(IniRead($SettingsFile, "Merchant", "NoEmpowered", "1"))
	$MerchantNoEpic = Int(IniRead($SettingsFile, "Merchant", "NoEpic", "1"))
	$MerchantNoMagicPowder = Int(IniRead($SettingsFile, "Merchant", "NoMagicPowder", "1"))
	$MerchantNoBlessedPowder = Int(IniRead($SettingsFile, "Merchant", "NoBlessedPowder", "1"))
	$MerchantChests[0] = Int(IniRead($SettingsFile, "Merchant", "Chest2", "1"))
	$MerchantChests[1] = Int(IniRead($SettingsFile, "Merchant", "Chest3", "1"))
	$MerchantChests[2] = Int(IniRead($SettingsFile, "Merchant", "Chest4", "1"))
	$MerchantChests[3] = Int(IniRead($SettingsFile, "Merchant", "Chest5", "1"))
	$MerchantChests[4] = Int(IniRead($SettingsFile, "Merchant", "Chest6", "1"))
	$MerchantChests[5] = Int(IniRead($SettingsFile, "Merchant", "Chest7", "1"))
	$MerchantChests[6] = Int(IniRead($SettingsFile, "Merchant", "Chest8", "1"))
	$MerchantChests[7] = Int(IniRead($SettingsFile, "Merchant", "Chest9", "1"))
	$MerchantRuns = Int(IniRead($SettingsFile, "Merchant", "Runs", "10"))
	;login info
	Dim $user = IniRead($SettingsFile, "Login", "UserID", "")
	Dim $pass = IniRead($SettingsFile, "Login", "Pass", "")
	If ($user <> "") And ($pass <> "") Then
		$LoginUserID = __StringEncrypt(0, $user, $seed, 6)
		$LoginPassword = __StringEncrypt(0, $pass, $seed, 5)
	Else
		$LoginUserID = ""
		$LoginPassword = ""
	EndIf
	$LoginServer = IniRead($SettingsFile, "Login", "Server", "East")
	$LoginCharIndex = Int(IniRead($SettingsFile, "Login", "Char", "1"))

	$WindowX = Int(IniRead($SettingsFile, "Window", "X", "192"))
	$WindowY = Int(IniRead($SettingsFile, "Window", "Y", "124"))

	;web server
	$WebServerOn = Int(IniRead($SettingsFile, "WebServer", "Use", "0"))
	$WebServerPort = Int(IniRead($SettingsFile, "WebServer", "Port", Random (1000, 10000, 1)))

	;Advanced Settings (DO NOT WRITE TO SETTINGS)
	$ColorDelta = Int(IniRead($SettingsFile, "Advanced", "ColorDelta", "8"))
	$SettingIdentifyAttempts = Int(IniRead($SettingsFile, "Advanced", "IdentifyAttempts", "3"))
	$DelayMiningTime = Int(IniRead($SettingsFile, "Advanced", "MiningTime", "3300000"))
	$ColorYUV = Int(IniRead($SettingsFile, "Advanced", "YUV", "1"))
	$WebServerMaxConnections = Int(IniRead($SettingsFile, "Advanced", "WebServerMaxConnections", "15"))
EndFunc

Func SaveBattleInfo($Name, $Oath, $Difficulty, $Slider, $Party, $DungeonLocation, $NumOaths)
	IniWrite($SettingsFile, "Battle", "Name", $Name)
	IniWrite($SettingsFile, "Battle", "Mode", $Difficulty)
	IniWrite($SettingsFile, "Battle", "OIndex", $Oath)
	IniWrite($SettingsFile, "Battle", "BIndex", $Slider)
	IniWrite($SettingsFile, "Battle", "LIndex", $DungeonLocation)
	IniWrite($SettingsFile, "Battle", "OSize", $NumOaths)
	IniWrite($SettingsFile, "Battle", "PSize", $Party)
EndFunc

Func GetBattleInfo()
	Dim $a[7]

	$a[0] = IniRead($SettingsFile, "Battle", "Name", "Unknown")
	$a[1] = Int(IniRead($SettingsFile, "Battle", "OIndex", 0))
	$a[2] = IniRead($SettingsFile, "Battle", "Mode", "Hero")
	$a[3] = Int(IniRead($SettingsFile, "Battle", "BIndex", 0))
	$a[4] = Int(IniRead($SettingsFile, "Battle", "PSize", 0))
	$a[5] = Int(IniRead($SettingsFile, "Battle", "LIndex", 0))
	$a[6] = Int(IniRead($SettingsFile, "Battle", "OSize", 0))
	Return $a
EndFunc
