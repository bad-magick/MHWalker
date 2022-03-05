#include-once

#include <WinAPI.au3>
#include <WindowsConstants.au3>

Const $SM_VIRTUALWIDTH = 78
Const $SM_VIRTUALHEIGHT = 79

Global $OperationHwnd = 0
Global $ForceHwnd = 0
Global $ControlMode = 0

Func Singleton($semaphore)
    Local $ERROR_ALREADY_EXISTS = 183
    DllCall("kernel32.dll", "int", "CreateSemaphore", "int", 0, "long", 1, "long", 1, "str", $semaphore)
    Local $lastError = DllCall("kernel32.dll", "int", "GetLastError")
    If $lastError[0] = $ERROR_ALREADY_EXISTS Then
		Return False
	Else
		Return True
	EndIf
EndFunc

Func _Sleep($T)
    Local $dll, $T0 = TimerInit()
    If not (IsNumber($T)) Then Return 0
    $dll = DllOpen("kernel32.dll")
    If $T - TimerDiff($T0) > 16 Then DllCall($dll, "none", "Sleep", "long", $T - 16)
    While TimerDiff($T0) < $T - .03
        DllCall($dll, "none", "Sleep", "long", 0)
    WEnd
    DllClose($dll)
    Return TimerDiff($T0)
EndFunc

;===============================================================================
;
; Function Name:    __StringEncrypt()
; Description:      RC4 Based string encryption/decryption
; Parameter(s):     $i_Encrypt - 1 to encrypt, 0 to decrypt
;                   $s_EncryptText - string to encrypt
;                   $s_EncryptPassword - string to use as an encryption password
;                   $i_EncryptLevel - integer to use as number of times to encrypt string
; Requirement(s):   None
; Return Value(s):  On Success - Returns the encrypted string
;                   On Failure - Returns a blank string and sets @error = 1
; Author(s):        (Original _StringEncrypt) Wes Wolfe-Wolvereness <Weswolf at aol dot com>
;                   (Modified __StringEncrypt) PsaltyDS at www.autoitscript.com/forum
;                   (RC4 function) SkinnyWhiteGuy at www.autoitscript.com/forum
;===============================================================================
;  1.0.0.0  |  03/08/08  |  First version posted to Example Scripts Forum
;===============================================================================
Func __StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
    Local $RET, $sRET = "", $iBinLen, $iHexWords

    ; Sanity check of parameters
    If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
        SetError(1)
        Return ''
    ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
        SetError(1)
        Return ''
    EndIf
    If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1

    ; Encrypt/Decrypt
    If $i_Encrypt Then
        ; Encrypt selected
        $RET = $s_EncryptText
        For $n = 1 To $i_EncryptLevel
            If $n > 1 Then $RET = Binary(Random(0, 2 ^ 31 - 1, 1)) & $RET & Binary(Random(0, 2 ^ 31 - 1, 1)) ; prepend/append random 32bits
            $RET = rc4($s_EncryptPassword, $RET) ; returns binary
        Next

        ; Convert to hex string
        $iBinLen = BinaryLen($RET)
        $iHexWords = Int($iBinLen / 4)
        If Mod($iBinLen, 4) Then $iHexWords += 1
        For $n = 1 To $iHexWords
            $sRET &= Hex(BinaryMid($RET, 1 + (4 * ($n - 1)), 4))
        Next
        $RET = $sRET
    Else
        ; Decrypt selected
        ; Convert input string to primary binary
        $RET = Binary("0x" & $s_EncryptText) ; Convert string to binary

        ; Additional passes, if required
        For $n = 1 To $i_EncryptLevel
            If $n > 1 Then
                $iBinLen = BinaryLen($RET)
                $RET = BinaryMid($RET, 5, $iBinLen - 8) ; strip random 32bits from both ends
            EndIf
            $RET = rc4($s_EncryptPassword, $RET)
        Next
        $RET = BinaryToString($RET)
    EndIf

    ; Return result
    Return $RET
EndFunc

; -------------------------------------------------------
; Function:  rc4
; Purpose:  An encryption/decryption RC4 implementation in AutoIt
; Syntax:  rc4($key, $value)
;   Where:  $key = encrypt/decrypt key
;       $value = value to be encrypted/decrypted
; On success returns encrypted/decrypted version of $value
; Author:  SkinnyWhiteGuy on the AutoIt forums at www.autoitscript.com/forum
; Notes:  The same function encrypts and decrypts $value.
; -------------------------------------------------------
Func rc4($key, $value)
    Local $S[256], $i, $j, $c, $t, $x, $y, $output
    Local $keyLength = BinaryLen($key), $valLength = BinaryLen($value)
    For $i = 0 To 255
        $S[$i] = $i
    Next
    For $i = 0 To 255
        $j = Mod($j + $S[$i] + Dec(StringTrimLeft(BinaryMid($key, Mod($i, $keyLength) + 1, 1), 2)), 256)
        $t = $S[$i]
        $S[$i] = $S[$j]
        $S[$j] = $t
    Next
    For $i = 1 To $valLength
        $x = Mod($x + 1, 256)
        $y = Mod($S[$x] + $y, 256)
        $t = $S[$x]
        $S[$x] = $S[$y]
        $S[$y] = $t
        $j = Mod($S[$x] + $S[$y], 256)
        $c = BitXOR(Dec(StringTrimLeft(BinaryMid($value, $i, 1), 2)), $S[$j])
        $output = Binary($output) & Binary('0x' & Hex($c, 2))
    Next
    Return $output
EndFunc

 Func __MouseClick($Button = "left", $X = "", $Y = "", $Clicks = 1, $Speed = 0)
	If $ControlMode == 0 Then
		MouseClick($Button, $X, $Y, $Clicks, $Speed)
	Else
		Local $MK_LBUTTON       =  0x0001
		Local $WM_LBUTTONDOWN   =  0x0201
		Local $WM_LBUTTONUP     =  0x0202

		Local $MK_RBUTTON       =  0x0002
		Local $WM_RBUTTONDOWN   =  0x0204
		Local $WM_RBUTTONUP     =  0x0205

		Local $WM_MOUSEMOVE     =  0x0200

		Local $i                = 0

		Select
			Case $Button = "left"
				$Button     =  $MK_LBUTTON
				Local $ButtonDown =  $WM_LBUTTONDOWN
				Local $ButtonUp   =  $WM_LBUTTONUP
			Case $Button = "right"
				$Button     =  $MK_RBUTTON
				Local $ButtonDown =  $WM_RBUTTONDOWN
				Local $ButtonUp   =  $WM_RBUTTONUP
		EndSelect

		If $X = "" OR $Y = "" Then
			Local $MouseCoord = MouseGetPos()
			$X = $MouseCoord[0]
			$Y = $MouseCoord[1]
		EndIf

		For $i = 1 to $Clicks
			DllCall("user32.dll", "int", "SendMessage", _
				"hwnd",  $OperationHwnd, _
				"int",   $WM_MOUSEMOVE, _
				"int",   0, _
				"long",  _MakeLong($X, $Y))

			DllCall("user32.dll", "int", "SendMessage", _
				"hwnd",  $OperationHwnd, _
				"int",   $ButtonDown, _
				"int",   $Button, _
				"long",  _MakeLong($X, $Y))

			DllCall("user32.dll", "int", "SendMessage", _
				"hwnd",  $OperationHwnd, _
				"int",   $ButtonUp, _
				"int",   $Button, _
				"long",  _MakeLong($X, $Y))
			Next
	EndIf
 EndFunc

Func __MouseMove($X = "", $Y = "", $Speed = 0)
	If $ControlMode == 0 Then
		MouseMove($X, $y, $Speed)
	Else
		Local $MK_LBUTTON       =  0x0001
		Local $WM_LBUTTONDOWN   =  0x0201
		Local $WM_LBUTTONUP     =  0x0202

		Local $MK_RBUTTON       =  0x0002
		Local $WM_RBUTTONDOWN   =  0x0204
		Local $WM_RBUTTONUP     =  0x0205

		Local $WM_MOUSEMOVE     =  0x0200

		Local $i                = 0

		If $X = "" OR $Y = "" Then
			Local $MouseCoord = MouseGetPos()
			$X = $MouseCoord[0]
			$Y = $MouseCoord[1]
		EndIf

		DllCall("user32.dll", "int", "SendMessage", _
			"hwnd",  $OperationHwnd, _
			"int",   $WM_MOUSEMOVE, _
			"int",   0, _
			"long",  _MakeLong($X, $Y))
	EndIf
 EndFunc

 Func _MakeLong($LoWord,$HiWord)
    Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc

Func _MouseClick($button, $x, $y, $clicks = 1, $speed = 5)
	If ($ForceHwnd) And (_WinAPI_GetForegroundWindow() <> $OperationHwnd) Then
		WinActivate($OperationHwnd)
	EndIf
	If $ControlMode == 0 Then
		MouseClick($button, $x, $y, $clicks, $speed)
	Else
		Dim $oldHwnd = 0
		If Not WinActive($OperationHwnd) Then
			$oldHwnd = _WinAPI_GetForegroundWindow()
		EndIf
		WinActivate($OperationHwnd)
		ControlClick($OperationHwnd, "", "", $button, 2, $x, $y)
		If $oldHwnd <> 0 Then
			WinActivate($oldHwnd)
		EndIf
	EndIf
EndFunc

Func _MouseMove($x, $y, $speed = 10)
	If ($ForceHwnd) And (_WinAPI_GetForegroundWindow() <> $OperationHwnd) Then
		WinActivate($OperationHwnd)
	EndIf
	If $ControlMode == 0 Then
		MouseMove($x, $y, $speed)
	Else
		;nothing yet
	EndIf
EndFunc

Func _Send($text, $flag = 0)
	If ($ForceHwnd) And (_WinAPI_GetForegroundWindow() <> $OperationHwnd) Then
		WinActivate($OperationHwnd)
	EndIf
	If $ControlMode == 0 Then
		Send($text, $flag)
	Else
		ControlSend($OperationHwnd, "", "", $text)
	EndIf
EndFunc

Func IsOnScreen($x, $y)
	Dim $left = DLLCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_XVIRTUALSCREEN)
	Dim $top = DLLCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_YVIRTUALSCREEN)
	Dim $width = DLLCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_VIRTUALWIDTH)
	Dim $height = DLLCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_VIRTUALHEIGHT)

	If ($x >= $left[0]) And ($x <= ($left[0] + $width[0])) And ($y >= $top[0]) And ($y <= ($top[0] + $height[0])) Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func _TimeGetStamp()
	Local $av_Time
	$av_Time = DllCall('CrtDll.dll', 'long:cdecl', 'time', 'ptr', 0)
	If @error Then
		SetError(99)
		Return False
	EndIf
	Return $av_Time[0]
EndFunc
