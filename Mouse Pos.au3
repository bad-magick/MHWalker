#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("MouseGetter -Nunya", 215, 144, 192, 124)
$StartB = GUICtrlCreateButton("Start", 5, 5, 200, 24)
$Label1 = GUICtrlCreateLabel("Left Clicks Recorded - Right Click to copy all info to Clipboard and stop recording. Only In-Game Clicks are Recorded." &@LF&@LF& "HOME, END, DELETE, PAGEDOWN - will move the mouse 1 pixel. INSERT Will copy all info to Clipboard", 5, 33, 200, 100, $SS_CENTER)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

WinSetOnTop("MouseGetter -Nunya", "", 1)
Global $wWindow = "[Title:Guild Wars 2]" ; Name class of $wWindow
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)
HotKeySet("{HOME}", "MovUp")
HotKeySet("{END}", "MovDn")
HotKeySet("{Delete}", "MovLt")
HotKeySet("{PGDN}", "MovRT")
HotKeySet("{F1}", "copydata")


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $StartB
			Start()
	EndSwitch
WEnd

Func Start()
WinActivate($wWindow)
$dll = DllOpen("user32.dll")
Global $numClicks = 0

While 1
sleep(10)
	While 1
	sleep(10)
		If WinActive($wWindow) and _IsPressed("01", $dll) Then
			While _IsPressed("01", $dll)
				sleep(1)
			Wend
			$numClicks += 1
			ExitLoop 1
		EndIf
		If _IsPressed("02", $dll) Then
			clipput("IsColorMatch(fastPixelGetColor(" & $Pos[0] & ", " & $Pos[1] & "), " & $colHex & ")")
			ExitLoop 2
		EndIf
		If _IsPressed("2D", $dll) Then
			clipput("IsColorMatch(fastPixelGetColor(" & $Pos[0] & ", " & $Pos[1] & "), " & $colHex & ")")
		EndIf
		If WinActive($wWindow,"") then
			$Pos = MouseGetPos()
			$col = PixelGetColor ($Pos[0], $Pos[1])
			$colHex = stringreplace(hex($col),2,"x")
			tooltip("X-" & $Pos[0] & " / " & "Y-" & $Pos[1] & " / " & "Color-" & $colHex & " (" & $col & ") / Clicks " & $numclicks, 0, 0)
			global $data = "X-" & $Pos[0] & " / Y-" & $Pos[1] & " / Color-" & $colHex & " / Clicks " & $numclicks
		EndIf
		If GuiGetMsg() = $GUI_EVENT_CLOSE Then
			Exit
		EndIf
	Wend
WEnd
DllClose($dll)
EndFunc

Func MovUp()
	$Pos = MouseGetPos()
	mousemove($Pos[0], $Pos[1] - 1)
EndFunc

Func MovDn()
	$Pos = MouseGetPos()
	mousemove($Pos[0], $Pos[1] + 1)
EndFunc

Func MovLt()
	$Pos = MouseGetPos()
	mousemove($Pos[0] -1, $Pos[1])
EndFunc

Func MovRt()
	$Pos = MouseGetPos()
	mousemove($Pos[0] + 1, $Pos[1])
EndFunc

Func copydata()
	clipput("IsColorMatch(fastPixelGetColor(" & $Pos[0] & ", " & $Pos[1] & "), " & $colHex & ")")
EndFunc
