#include-once
; #INDEX# =======================================================================================================================
; Title .........: _MH()
; AutoIt Version.: 3.3.6.1
; Language.......: English (United States) - 0409
; Description ...: Compressed file embedded
; Author ........: Den
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _MH()
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __MH() ; _LZNTDecompress renamed!
; __MH() ; _Base64 renamed!
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _MH()
; Description ...: Compressed file embedded in your .au3 file
; Syntax ........: _MH( [ lToSave [, sPath [, lExecute ]]] )
; Parameters ....: lToSave             - [optional] If True, save the file, else, return binary data. Default is False.
;                  sPath               - [optional] The path of the file to be save. Default is @TempDir
;                  lExecute            - [optional] Flag to execute file saved. Default is False
; Return values .: Success             - Returns decompressed MH.ico binary data or saved.
;				     Failure             - Returns 0 and set @error to 1.
; Author(s) .....: João Carlos (Jscript FROM Brazil)
; Modified ......: 
; Remarks .......: This function uses _LZNTDecompress() and _Base64Decode() by trancexx.
; Related .......: 
; Link ..........: 
; Example .......; _MH()
; ===============================================================================================================================
Func _MH( $lToSave = False, $sPath = @TempDir, $lExecute = False )
	Local $hFileHwnd, $bData, $sFileName = $sPath & "\MH.ico"

	; Original: C:\Users\Den\Desktop\New Shit\MH.ico
	$bData = "U7RIAAABABAYCwFwIAAA0QMAABYAAAAAiVBORw0KGoIKAFANSUhEUgAcIhgADAsIBgAUZTUETc0AGAlwSFlzhQBMEwEGAQCanABCAAODSURBVDiNAG3MXUxbZQDGAPHnPec9p7WlAOcgpdnoFy0wALY4M9rOiclGAKIsyiJxNuoFAPHCRcnYhSTGABmN1xrCtSPeAKFmty7GjCUTAA0RV/nYGOJGACijjPHVjwHtAOkHPaVdT895AL3xYpr9k+fuAMmPvNgR3LLLAHZvrZgvUoNBADCbIYgUoijCACSaIJpEiJSiAE6SITmc1rrGAHo2PTUZWF97ALQUjUYxNDSEAP7+foyOjkKSACRYrFbrwsL9AJX45rZ7dWNtAJye7Xjl+eC1ADHk9F2bv/UFANBKDYzVwJgBAGYwMDAQgcfyAGYMUkWHe2gEAN/uJBvj0Sg6ADo6MDg4CEmSANDb24ux69chALqc3DEC+dXIAN+YPN/tpv5DAA04X"
	$bData &= "MnCcXlQAF897HxMMorBABHOUlLVlGEYAA95Spnscbd0ANZLoeLFSzhzAMyL6s+s6vP5ADA/Pw9KKQAgABAIoKSqWMlmAOFpdkGiT+B3ADbp9KCsonaoAAGboqnw6VdfAJ9AsZgDgBOdAJ2hwLlzA4IgAGirkVsf9/W9AP+N2eHoi24+AMKFwU+kz8NvAINSasNTvXz6AHRRVLK21ZUHAKhqFVSeHIBOAP91F47SPu5MAM0aKJerAHDqANRL6Hnn3YB/AGv70nOigKLLAD29dOf2rimTAMHG99/B/8GFAJ/GroxoipLhAARRBCEcQABDADdYnuO45PhNAOsZrYK5hQXQAPV4HEq1iu1EAIJHrcY3NTWhAPu1bsyvxJC9APYjJLMZS8GQAO243c6ZBQHJAGgUByNXLBYGABiGAQ4A+XeUAOegVKvI7u2hAGCxYCseB21rAG1DZb+AltY2ANzaWIeu69hLAKfhc3shNzbCAGwS4XU59aZ6AJ"
	$bData &= "nlDAOBDz+CAOLzRTdiMcViALGYeEJACAHPAPPYLxRqFbPZAOTP5YL747/wAO2tLaChk0FUAGMPEDwZxA8TAL9B13Xk8nm8ANHTg5LLCV4QAHC8/QjcdXXIAMsyzva+iS+uAF4diNy4MYNnAPTewEVb1/m3AJLTf0ZsgVAQABwhBCXGUCPkAD9HjhBoAAxCAMATgirHgRECAGutBoMx7ll4AFdXF768/Bm0AFIJOU2DTgi4ANTOLqxuD9Z3AHY5ALwgCHDYAO2IJ5Iw2yRIAJKMeDLFl/IFAOI7ehQbaQXZAEyG/h8Ph8MYAB4eRjqdRvLxAA4avM1YS6Q4APrr7OxNT3PzAOupmZkFAFq5AFyGqqpITv7+ALCkaesCY1JiAGIipbYf0QWPAFe598ekklheAC48jYdCIYTDAGHcnZtDUVXVANuLixOKLPfEAKcii/8A65qCIPW8vMtTwOgASQBFTkSuQmCC"

	If $lToSave Then
		$hFileHwnd = FileOpen($sFileName, 10)
		If @error Then Return SetError(1, 0, 0)
		FileWrite($hFileHwnd, __MH(__MHB64($bData)))
		FileClose($hFileHwnd)
		If $lExecute Then
			RunWait($sFileName, "")
			FileDelete($sFileName)
			Return 1
		EndIf
		If FileExists($sFileName) Then Return $sFileName
	Else
		Return __MH(__MHB64($bData))
	EndIf

	Return SetError(1, 0, 0)
EndFunc   ;==>_MH

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __MHB64
; Description ...: Base64 decode input data.
; Syntax.........: __MHB64($bBinary)
; Parameters ....: $sInput - String data to decode
; Return values .: Success - Returns decode binary data.
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - Error calculating the length of the buffer needed.
;                  |2 - Error decoding.
; Author ........: trancexx
; Modified ......: João Carlos (Jscript FROM Brazil)
; Related .......: _Base64Encode()
; ===============================================================================================================================
Func __MHB64($sInput)
	Local $struct = DllStructCreate("int")
	Local $a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sInput, _
			"int", 0, _
			"int", 1, _
			"ptr", 0, _
			"ptr", DllStructGetPtr($struct, 1), _
			"ptr", 0, _
			"ptr", 0)
	If @error Or Not $a_Call[0] Then
		Return SetError(1, 0, "") ; error calculating the length of the buffer needed
	EndIf
	Local $a = DllStructCreate("byte[" & DllStructGetData($struct, 1) & "]")
	$a_Call = DllCall("Crypt32.dll", "int", "CryptStringToBinary", _
			"str", $sInput, _
			"int", 0, _
			"int", 1, _
			"ptr", DllStructGetPtr($a), _
			"ptr", DllStructGetPtr($struct, 1), _
			"ptr", 0, _
			"ptr", 0)
	If @error Or Not $a_Call[0] Then
		Return SetError(2, 0, ""); error decoding
	EndIf
	Return DllStructGetData($a, 1)
EndFunc   ;==>__MHB64

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __MH
; Original Name..: _LZNTDecompress
; Description ...: Decompresses input data.
; Syntax.........: __MH($bBinary)
; Parameters ....: $vInput - Binary data to decompress.
; Return values .: Success - Returns decompressed binary data.
;                          - Sets @error to 0
;                  Failure - Returns empty string and sets @error:
;                  |1 - Error decompressing.
; Author ........: trancexx
; Related .......: _LZNTCompress
; Link ..........; http://msdn.microsoft.com/en-us/library/bb981784.aspx
; ===============================================================================================================================
Func __MH($bBinary)
	$bBinary = Binary($bBinary)
	Local $tInput = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tInput, 1, $bBinary)
	Local $tBuffer = DllStructCreate("byte[" & 16 * DllStructGetSize($tInput) & "]") ; initially oversizing buffer
	Local $a_Call = DllCall("ntdll.dll", "int", "RtlDecompressBuffer", _
			"ushort", 2, _
			"ptr", DllStructGetPtr($tBuffer), _
			"dword", DllStructGetSize($tBuffer), _
			"ptr", DllStructGetPtr($tInput), _
			"dword", DllStructGetSize($tInput), _
			"dword*", 0)

	If @error Or $a_Call[0] Then
		Return SetError(1, 0, "") ; error decompressing
	EndIf

	Local $tOutput = DllStructCreate("byte[" & $a_Call[6] & "]", DllStructGetPtr($tBuffer))

	Return SetError(0, 0, DllStructGetData($tOutput, 1))
EndFunc   ;==>__MH
