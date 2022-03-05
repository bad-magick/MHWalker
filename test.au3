#include "Signatures.au3"
#include "FastPixel.au3"
#include "DetectUI.au3"

AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseCoordMode", 2)

WinActivate("[Class:Valve001]")

Func SignatureMatchesMod($sig)
	Dim $x
	Dim $t

	For $x = 0 to Ubound($sig) - 1
		If PixelGetColor($sig[$x][0], $sig[$x][1]) < 0xC0C0C0 Then
			$t = $t & "(" & $sig[$x][0] & ", " & $sig[$x][1] & ")"
		EndIf
	Next
	MsgBox(0, "Missing Pixels", $t)
EndFunc

SignatureMatchesMod($sig_GwynnsRequest)

