#include-once

#include "Utils.au3"
#include "FastPixel.au3"
#include "Signatures.au3"

;*********************** UTILS ***********************
Func PressAndWait($key, $x1, $y1, $color1, $x2 = 0, $y2 = 0, $color2 = 0, $x3 = 0, $y3 = 0, $color3 = 0, $waitTime = 5000, $attempts = 3)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_Send($key)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($i >= $attempts)
	If  ((IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func PressAndWaitArray($key, $array, $waitTime = 5000, $attempts = 3)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_Send($key)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($i >= $attempts)
	If  ((IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func PressAndWaitNot($key, $x1, $y1, $color1, $x2 = 0, $y2 = 0, $color2 = 0, $x3 = 0, $y3 = 0, $color3 = 0, $waitTime = 5000, $attempts = 3)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_Send($key)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((Not IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (Not IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (Not IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((Not IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (Not IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (Not IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($i >= $attempts)
	If  ((Not IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (Not IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (Not IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func PressAndWaitArrayNot($key, $array, $waitTime = 5000, $attempts = 3)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_Send($key)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((Not IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (Not IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (Not IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((Not IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (Not IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (Not IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($i >= $attempts)
	If  ((Not IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (Not IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (Not IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func ClickAndWait($button, $xPos, $yPos, $x1, $y1, $color1, $x2 = 0, $y2 = 0, $color2 = 0, $x3 = 0, $y3 = 0, $color3 = 0, $waitTime = 5000, $attempts = 3)
	_MouseMove($xPos, $yPos, $SettingMouseSpeed)
	Sleep(100)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_MouseClick($button, $xPos, $yPos, 1, $SettingMouseSpeed)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($i >= $attempts)
	If  ((IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func ClickAndWaitArray($button, $xPos, $yPos, $array, $waitTime = 5000, $attempts = 3)
	_MouseMove($xPos, $yPos, $SettingMouseSpeed)
	Sleep(100)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_MouseClick($button, $xPos, $yPos, 1, $SettingMouseSpeed)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($i >= $attempts)
	If  ((IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func ClickAndWaitNot($button, $xPos, $yPos, $x1, $y1, $color1, $x2 = 0, $y2 = 0, $color2 = 0, $x3 = 0, $y3 = 0, $color3 = 0, $waitTime = 5000, $attempts = 3)
	_MouseMove($xPos, $yPos, $SettingMouseSpeed)
	Sleep(100)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_MouseClick($button, $xPos, $yPos, 1, $SettingMouseSpeed)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((Not IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (Not IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (Not IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((Not IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (Not IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (Not IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Or ($i >= $attempts)
	If  ((Not IsColorMatch(fastPixelGetColor($x1, $y1), $color1)) And (Not IsColorMatch(fastPixelGetColor($x2, $y2), $color2)) And (Not IsColorMatch(fastPixelGetColor($x3, $y3), $color3))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func ClickAndWaitArrayNot($button, $xPos, $yPos, $array, $waitTime = 5000, $attempts = 3)
	_MouseMove($xPos, $yPos, $SettingMouseSpeed)
	Sleep(100)
	Dim $count = 0
	Dim $i = 0
	Do
		$count = 0
		$i += 1
		_MouseClick($button, $xPos, $yPos, 1, $SettingMouseSpeed)
		Do
			$count += 1
			Sleep(100)
			SaveScreen()
		Until ((Not IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (Not IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (Not IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($count >= ($waitTime / 100))
		SaveScreen()
	Until ((Not IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (Not IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (Not IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Or ($i >= $attempts)
	If  ((Not IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2])) And (Not IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2])) And (Not IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func ClickArray($button, $array)
	_MouseMove($array[0], $array[1], $SettingMouseSpeed)
	Sleep(100)
	_MouseClick($button, $array[0], $array[1], 1, $SettingMouseSpeed)
EndFunc

Func ClickArrayIfSig($button, $array, $sig)
	If HasSignature($sig) Then ClickArray($button, $array)
EndFunc

Func ClickArrayIfSigLive($button, $array, $sig)
	If HasSignatureLive($sig) Then ClickArray($button, $array)
EndFunc

Func HasSignature($array)
	Return (IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2]) And IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2]) And IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))
EndFunc

Func HasSignatureLive($array)
	SaveScreen()
	Return (IsColorMatch(fastPixelGetColor($array[0][0], $array[0][1]), $array[0][2]) And IsColorMatch(fastPixelGetColor($array[1][0], $array[1][1]), $array[1][2]) And IsColorMatch(fastPixelGetColor($array[2][0], $array[2][1]), $array[2][2]))
EndFunc

;*********************** OPEN WINDOWS ***********************
Func OpenWindowBattle()
	Return PressAndWaitArray($UIBattles, $sig_WindowBattle)
EndFunc

Func OpenWindowSkills()
	Return PressAndWaitArray($UISkills, $sig_WindowSkills)
EndFunc

Func OpenWindowMailBox()
	Return PressAndWaitArray($BindMailbox, $sig_WindowMailbox)
EndFunc

Func OpenWindowShop()
	Return PressAndWaitArray($BindShop, $sig_WindowShop)
EndFunc

Func OpenShipList()
	Return PressAndWaitArray($BindShipList, $sig_WindowShipList)
EndFunc

Func OpenCreateParty()
	Return ClickAndWaitArray("left", $click_CreatePartyShipList[0], $click_CreatePartyShipList[1], $sig_WindowCreateParty)
EndFunc

;*********************** CONFIRMATION ***********************
Func ClearForfeit()
	_Send("{ALT DOWN}")
	Sleep(200)
	ClickAndWaitArray("left", $click_Forfeit[0], $click_Forfeit[1], $sig_DialogForfeit)
	ClearOkOkCancel()
	_Send("{ALT UP}")
EndFunc

Func ClearOkOkCancel()
	_Send("{ALT DOWN}")
	Sleep(200)
	Return ClickAndWaitArrayNot("left", $click_OkOkCancel[0], $click_OkOkCancel[1], $sig_DialogOkCancel)
	_Send("{ALT UP}")
EndFunc

Func ClearOkOnly()
	_Send("{ALT DOWN}")
	Sleep(200)
	Return ClickAndWaitArrayNot("left", $click_OkOnly[0], $click_OkOnly[1], $sig_DialogOkOnly)
	_Send("{ALT UP}")
EndFunc

;*********************** SCREENS ***********************
Func HasBattleStats()
	Return HasSignature($sig_ScreenBattleStats)
EndFunc

Func HasBattleStatsLive()
	Return HasSignatureLive($sig_ScreenBattleStats)
EndFunc

Func HasDeadScreen()
	Return (HasSignature($sig_ScreenDead1) And HasSignature($sig_ScreenDead2))
EndFunc

Func ClearDeadScreen()
	_Send("{ALT DOWN}")
	Sleep(200)
	ClickAndWaitArray("left", $click_ReturnToTownScreenDead[0], $click_ReturnToTownScreenDead[1], $sig_DialogOkCancel)
	ClearOkOkCancel()
	_Send("{ALT UP}")
EndFunc

Func HasBattleCleared()
	Return HasSignatureLive($sig_ScreenBattleCleared)
EndFunc

Func ClearBattleCleared()
	_Send("{ALT DOWN}")
	Sleep(200)
	ClickAndWaitArrayNot("left", $click_BattleClearedClose[0], $click_BattleClearedClose[1], $sig_ScreenBattleCleared, 1000, 5)
	_Send("{ALT UP}")
EndFunc

Func ClearBattleClearedReplay()
	_Send("{ALT DOWN}")
	Sleep(200)
	ClickAndWaitArrayNot("left", $click_BattleClearedReplay[0], $click_BattleClearedReplay[1], $sig_ScreenBattleCleared, 1000, 5)
	_Send("{ALT UP}")
EndFunc

;*********************** SCREENS ***********************
Func HasChatBox()
	Return HasSignature($sig_UIChatBox)
EndFunc

Func HasChatBoxLive()
	Return HasSignatureLive($sig_UIChatBox)
EndFunc

;*********************** UTILS ***********************
Func SaveScreen()
	CaptureScreen($vinClient[0], $vinClient[1], $vinClient[0] + $vinRes[0], $vinClient[1] + $vinRes[1])
EndFunc

Func DisplaySignature($sig)
	Dim $t = ""
	$t = $t & "(" & $sig[0][0] & ", " & $sig[0][1] & ") Expected=0x" & Hex($sig[0][2], 6) & " Actual=0x" & Hex(PixelGetColor($sig[0][0], $sig[0][1]), 6) & " Match=" & IsColorMatch($sig[0][2], PixelGetColor($sig[0][0], $sig[0][1])) & @CRLF
	$t = $t & "(" & $sig[1][0] & ", " & $sig[1][1] & ") Expected=0x" & Hex($sig[1][2], 6) & " Actual=0x" & Hex(PixelGetColor($sig[1][0], $sig[1][1]), 6) & " Match=" & IsColorMatch($sig[1][2], PixelGetColor($sig[1][0], $sig[1][1])) & @CRLF
	$t = $t & "(" & $sig[2][0] & ", " & $sig[2][1] & ") Expected=0x" & Hex($sig[2][2], 6) & " Actual=0x" & Hex(PixelGetColor($sig[2][0], $sig[2][1]), 6) & " Match=" & IsColorMatch($sig[2][2], PixelGetColor($sig[2][0], $sig[2][1])) & @CRLF
	$t = $t & @CRLF
	$t = $t & "HasSignature reports: " & HasSignature($sig)
	MsgBox(0, "Signature Report", $t)
EndFunc
