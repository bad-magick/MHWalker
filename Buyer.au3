#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ScreenCapture.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <Date.au3>

Dim $clientPos[2]
Dim $clientSize[2]

Global $hBMP
Global $hBitmap
Global $BitmapData
Local $Stride
Local $Scan0

Dim $hasCap = False

Func fastPixelStartup()
	_GDIPlus_Startup()
EndFunc

Func fastPixelShutdown()
	ReleaseScreen()
	_GDIPlus_Shutdown()
EndFunc

Func CaptureScreen ($x1, $y1, $x2, $y2)
	If $hasCap Then
		ReleaseScreen()
	EndIf
	$hBMP = _ScreenCapture_Capture("", $x1, $y1, $x2, $y2, False)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)
	$BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, _GDIPlus_ImageGetWidth($hBitmap), _GDIPlus_ImageGetHeight($hBitmap), BitOR($GDIP_ILMREAD, $GDIP_ILMWRITE), $GDIP_PXF32RGB)
	$Stride = DllStructGetData($BitmapData, "Stride")
	$Scan0 = DllStructGetData($BitmapData, "Scan0")
	$hasCap = True
EndFunc

Func ReleaseScreen()
	If $hasCap Then
		_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
		_GDIPlus_ImageDispose($hBitmap)
		_WinAPI_DeleteObject($hBMP)
		$hasCap = False
	EndIf
EndFunc

Func fastPixelGetColor ($x, $y)
	If (($x == 0) And ($y == 0)) Then
		Return 0
	EndIf
	Dim $pixel = DllStructCreate("dword", $Scan0 + ($y * $Stride) + ($x * 4))
	Return BitAnd(DllStructGetData($pixel, 1), 0x00FFFFFF)
EndFunc

Func GetRed($color)
	Return BitShift(BitAND($color, 0xFF0000), 0x10)
EndFunc

Func GetGreen($color)
	Return BitShift(BitAnd($color, 0x00FF00), 0x08)
EndFunc

Func GetBlue($color)
	Return BitAND($color, 0x0000FF)
EndFunc

Func ColorDistanceRGB($color1, $color2)
	Return Sqrt(((GetRed($color1) - GetRed($color2))^2) + ((GetGreen($color1) - GetGreen($color2))^2) + ((GetBlue($color1) - GetBlue($color2))^2))
EndFunc

Func IsColorMatch($color1, $color2)
	If (ColorDistanceRGB($color1, $color2) <= 8) Then
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
	AutoItSetOption("SendKeyDelay", 1)
	HotKeySet("{F11}", "Stop")
EndFunc

Func Stop()
	ReleaseScreen()
	fastPixelShutdown()
	Exit
EndFunc

Func HasItems()
	CaptureScreen($clientPos[0], $clientPos[1], $clientPos[0] + $clientSize[0], $clientPos[1] + $clientSize[1])
	Dim $x
	Dim $y
	For $x = 1 To 6
		For $y = 1 To 8
			If IsColorMatch(fastPixelGetColor($clientSize[0] - 315 + (43 * $x), 64 + (43 * $y)), 0xD6B639) Then
				Return TRUE
			EndIf
		Next
	Next
	Return FALSE
EndFunc

Dim $runs = 0
Dim $startTime = 0

UpdatePosition()
fastPixelStartUp()
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
				If IsColorMatch(fastPixelGetColor($clientSize[0] - 315 + (43 * $x), 64 + (43 * $y)), 0xD6B639) Then
					MouseClick("right", $clientSize[0] - 315 + (43 * $x), 64 + (43 * $y), 1, 1)
					Send("{ENTER 5}")
					;Sleep(35)
				EndIf
			Next
		Next
	WEnd
	;Sleep(500)
	$runs += 1
	ConsoleWrite("Average Time: " & ((_Date_Time_GetTickCount() - $startTime) / $runs) & "ms in " & $runs & " runs" & @CRLF)
WEnd
