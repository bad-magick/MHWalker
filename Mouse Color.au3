#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("ColorGet", 215, 144, 192, 124)
$Input1 = GUICtrlCreateInput("X-Coord", 35, 90, 52, 21)
$Input2 = GUICtrlCreateInput("Y-Coord", 120, 90, 52, 21)
$Label1 = GUICtrlCreateLabel("Press 'insert' To copy color to Clipboard" &@LF&@LF& "You can press End or click the X to exit" , 5, 33, 200, 55, $SS_CENTER)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

WinSetOnTop($Form1, "", 1)
Global $wWindow = "[Class:Valve001]" ; Name class of $wWindow
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)



HotKeySet("{INSERT}", "Copy")
;HotKeySet("{End}", "End")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func Copy()
	$xcoord = guictrlread($input1)
	$ycoord = guictrlread($input2)
	WinActivate($wWindow)
	WinWaitActive($wWindow)
	If WinActive($wWindow,"") Then
		$col = PixelGetColor ($xcoord, $ycoord)
		$colHex = stringreplace(hex($col),2,"x")
		clipput($colHex)
		tooltip("Color Copied - " & $colHex)
	EndIf
EndFunc

Func End()
	Exit
EndFunc