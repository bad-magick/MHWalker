#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ScreenCapture.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <Date.au3>

Dim $clientPos[2]
Dim $clientSize[2]

Func IsColorMatch($color1, $color2)
	If (Sqrt(((BitShift(BitAND($color1, 0xFF0000), 0x10) - BitShift(BitAND($color2, 0xFF0000), 0x10))^2) + ((BitShift(BitAnd($color1, 0x00FF00), 0x08) - BitShift(BitAnd($color2, 0x00FF00), 0x08))^2) + ((BitAND($color1, 0x0000FF) - BitAND($color2, 0x0000FF))^2)) <= 32) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func UpdatePosition()
	Dim $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", 0)
	DllStructSetData($tPoint, "Y", 0)
	_WinAPI_ClientToScreen(WinGetHandle("[Class:Valve001; Title:Vindictus]"), $tPoint)
	Dim $x = DllStructGetData($tPoint, "X")
	Dim $y = DllStructGetData($tPoint, "Y")
	$clientPos[0] = $x
	$clientPos[1] = $y
	$clientSize = WinGetClientSize("[Class:Valve001; Title:Vindictus]")
	WinActivate("[Class:Valve001; Title:Vindictus]")
	AutoItSetOption("MouseCoordMode", 2)
	AutoItSetOption("PixelCoordMode", 2)
	AutoItSetOption("SendKeyDelay", 1)
	HotKeySet("{F11}", "Stop")
EndFunc

Func Stop()
	Exit
EndFunc

Func HasItems()
	Dim $x
	Dim $y
	For $x = 1 To 6
		For $y = 1 To 8
			If IsColorMatch(PixelGetColor($clientSize[0] - 315 + (43 * $x), 64 + (43 * $y)), 0xD6B639) Then
				Return TRUE
			EndIf
		Next
	Next
	Return FALSE
EndFunc

Dim $runs = 0
Dim $startTime = 0

UpdatePosition()
$startTime = _Date_Time_GetTickCount()
While(1)
	MouseClick("left", 302, 172, 2, 3)
	;Sleep(250)
	MouseClick("left", 233, 452, 1, 3)
	Sleep(250)
	Send("4800", 1)
	;Sleep(500)
	MouseClick("left", $clientSize[0] / 2 - 28, $clientSize[1] / 2 + 63, 5, 3)
	Sleep(500)
	Send("{ENTER 10}")
	Dim $x = 0
	Dim $y = 0
	While (HasItems())
		For $x = 1 To 6
			For $y = 1 To 8
				If IsColorMatch(PixelGetColor($clientSize[0] - 315 + (43 * $x), 64 + (43 * $y)), 0xD6B639) Then
					MouseClick("right", $clientSize[0] - 315 + (43 * $x), 64 + (43 * $y), 1, 1)
					Send("{ENTER 10}")
					;Sleep(30)
				EndIf
			Next
		Next
	WEnd
	;Sleep(500)
	$runs += 1
	ConsoleWrite("Average Time: " & ((_Date_Time_GetTickCount() - $startTime) / $runs) & "ms in " & $runs & " runs" & @CRLF)
WEnd
