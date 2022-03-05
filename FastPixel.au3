#include-once
#include <ScreenCapture.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include "Settings.au3"

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

Func ColorCompare($color, $test, $percent)
	Dim $pct = 255 * (100 / $percent)
	Dim $r = GetRed($color)
	Dim $g = GetGreen($color)
	Dim $b = GetBlue($color)
	Dim $rh = $r + $pct
	Dim $rl = $r - $pct

	Dim $gh = $g + $pct
	Dim $gl = $g - $pct

	Dim $bh = $b + $pct
	Dim $bl = $b - $pct

	Dim $tr = GetRed($test)
	Dim $tg = GetGreen($test)
	Dim $tb = GetBlue($test)

	If ($tr >= $rl) And ($tr <= $rh) And ($tg >= $gl) And ($tg <= $gh) And ($tb >= $bl) And ($tb <= $bh) Then
		Return True
	Else
		Return False
	EndIf
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

Func RGBtoYUV($color)
	Dim $YUV[3]
	$YUV[0] = 0.299 * GetRed($color) + 0.587 * GetGreen($color) + 0.114 * GetBlue($color)
	$YUV[1] = (GetBlue($color) - $YUV[0]) * 0.565
	$YUV[2] = (GetRed($color) - $YUV[0]) * 0.713
	Return $YUV
EndFunc

Func YUVtoRGB($color)
	Dim $RGB[3]
	$RGB[0] = Int($color[0] + 1.403 * $color[2])
 	$RGB[1] = Int($color[0] - 0.344 * $color[1] - 0.714 * $color[2])
	$RGB[2] = Int($color[0] + 1.770 * $color[1])
	Dim $tmp
	Return BitOr(BitAND(BitShift($RGB[0], -16), 0xFF0000), BitAND(BitShift($RGB[1], -8), 0x00FF00), BitAND($RGB[2], 0x0000FF))
EndFunc

Func _ColorDistanceYUV($color1, $color2)
	Return Sqrt((($color1[0] - $color2[0])^2) + (($color1[1] - $color2[1])^2) + (($color1[2] - $color2[2])^2))
EndFunc

Func ColorDistanceRGB($color1, $color2)
	Return Sqrt(((GetRed($color1) - GetRed($color2))^2) + ((GetGreen($color1) - GetGreen($color2))^2) + ((GetBlue($color1) - GetBlue($color2))^2))
EndFunc

Func ColorDistanceYUV($color1, $color2)
	Return _ColorDistanceYUV(RGBtoYUV($color1), RGBtoYUV($color2))
EndFunc

Func IsColorMatch($color1, $color2)
	If $ColorYUV == 1 Then
		If (ColorDistanceYUV($color1, $color2) <= $ColorDelta) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If (ColorDistanceRGB($color1, $color2) <= $ColorDelta) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc

