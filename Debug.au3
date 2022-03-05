#include-once

#include <Array.au3>
#include "FastPixel.au3"
#include "Signatures.au3"
#include "DetectUI.au3"

Local $EndX = 265
Local $EndY = 140
Local $StartX = 0
Local $StartY = 75

Dim $clientPos[2]
Dim $clientSize[2]

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
	AutoItSetOption("PixelCoordMode", 2)
EndFunc

Func GetMaxColor()
	Dim $px = 0
	Dim $x = 0
	Dim $y = 0
	For $x = 0 To ($EndX - $StartX - 1)
		For $y = 0 to ($EndY - $StartY - 1)
			If fastPixelGetColor($x, $y) > $px Then
				$px = fastPixelGetColor($x, $y)
			EndIf
		Next
	Next
	Return $px
EndFunc

Func DisolveDungeonTag()
	UpdatePosition()
	CaptureScreen($clientPos[0] + $StartX, $clientPos[1] + $StartY, $clientPos[0] + $EndX, $clientPos[1] + $EndY)
	Dim $maxColor = GetMaxColor()

	Dim $pixels[1]
	Dim $point = 0

	Dim $x = 0
	Dim $y = 0
	For $x = 1 To ($EndX - $StartX - 1)
		For $y = 0 to ($EndY - $StartY - 1)
			If (fastPixelGetColor($x, $y) == $maxColor) Then
				_ArrayAdd($pixels, $x + $StartX)
				_ArrayAdd($pixels, $y + $StartY)
				$point += 1
			EndIf
		Next
	Next

	Dim $pxcount = 0
	Dim $sig = "][2] = ["
	For $x = 1 To (Ubound($pixels) - 1) Step 2
		$pxcount += 1
		If $pxcount <= 300 Then
			$sig = $sig & "[" & $pixels[$x] & ", " & $pixels[$x + 1] & "]"
			If ($x <> (Ubound($pixels) - 2)) And ($pxcount < 300) Then
				$sig = $sig & ", "
			EndIf
		EndIf
	Next
	If $pxcount > 300 Then $pxcount = 300
	$sig = "[" & $pxcount & $sig & "]"
	ClipPut($sig)

	ReleaseScreen()
	MsgBox(0, "Done", "Copied to clipboard.")
	;CaptureScreen($clientPos[0], $clientPos[1], $clientPos[0] + $clientSize[0], $clientPos[1] + $clientSize[1])
EndFunc

Func SignatureMatches($sig)
	UpdatePosition()
	CaptureScreen($clientPos[0], $clientPos[1], $clientPos[0] + $clientSize[0], $clientPos[1] + $clientSize[1])

	Dim $x

	For $x = 0 to Ubound($sig) - 1
		If fastPixelGetColor($sig[$x][0], $sig[$x][1]) < 0xC0C0C0 Then
			ReleaseScreen()
			Return False
		EndIf
	Next
	ReleaseScreen()
	Return True
EndFunc

Func GetItemPixel($x, $y)
	UpdatePosition()
	Return "0x" & Hex(PixelGetColor($clientSize[0] - 315 + (43 * $x), 129 + (43 * $y)), 6)
EndFunc

fastPixelStartup()
UpdatePosition()
MsgBox(0, "", "0x" & Hex(PixelGetColor($clientSize[0] - 160, $clientSize[1] - 63)));
;DisolveDungeonTag()
fastPixelShutdown()
;MsgBox(0, "", SignatureMatches($sig_FomorianOrder))
;MsgBox(0, "", HasSignature($sig_DialogLeaveParty))
;MsgBox(0, "", GetItemPixel(1, 1))
