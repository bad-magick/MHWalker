#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=bin\Mail Grabber x86.exe
#AutoIt3Wrapper_Outfile_x64=bin\Mail Grabber x64.exe
#AutoIt3Wrapper_Compile_Both=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region
#EndRegion

Global $Var0000, $Var0001, $Var0002, $Var0003, $Var0004, $Var0005, $Var0006, $Var0007, $Var0008, $Var0009, $Var000A, $Var000B, $Var000C, $Var000D, $Var000E, $Var000F
Global $Var0010, $Var0011, $Var0012, $Var0013, $Var0014, $Var0015, $Var0016, $Var0017, $Var0018, $Var0019, $Var001A, $Var001B, $Var001C, $Var001D, $Var001E
HotKeySet("g", "Fn0000")
HotKeySet("j", "Fn000C")
HotKeySet("h", "Fn000E")
$Var0019 = False
$Var001A = 0
$Var0005 = 0x0190
$Var0006 = 0x00C8
$Var0007 = 0x00EA
$Var0008 = 0x010C
$Var0009 = 0x012E
$Var000A = 0x0150
$Var000B = 0x0172
$Var000C = 0x0194
$Var000D = 0x01B6
$Var000E = 0x01D8
$Var001F = 0x0037
$Var0002 = 0x017C
$Var0003 = 0x01F9
$Var001B = ((@DesktopWidth / 2) - 0x0028)
$Var001C = ((@DesktopHeight / 2) + 0x0041)
$Var001D = ((@DesktopWidth / 2) - 0x000F)
$Var001E = ((@DesktopWidth / 2) + 0x000F)
$Var0000 = 0x0035
$Var0001 = 0x00A5
ToolTip('Mail Grabber will start once the ""G"" key is pressed.' & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
While 1 = 1
	If $Var0019 = False Then
		Sleep(0x03E8)
	Else
		Call("Fn0001")
	EndIf
WEnd

Func Fn0000()
	$Var0019 = True
	$Var0004 = PixelGetColor($Var0005, $Var0006)
	ToolTip("Starting process.", 0x0032, 0x0032)
	Call("Fn0001")
EndFunc

Func Fn0001()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var0006)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var0006, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var0006)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0010 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0010 = False
	EndIf
	ToolTip("Clearing Slot 1 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 1 = " & $Var0010 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0002")
EndFunc

Func Fn0002()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var0007)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var0007, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var0007)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0011 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0011 = False
	EndIf
	ToolTip("Clearing Slot 2 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 2 = " & $Var0011 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0003")
EndFunc

Func Fn0003()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var0008)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var0008, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var0008)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0012 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0012 = False
	EndIf
	ToolTip("Clearing Slot 3 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 3 = " & $Var0012 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0004")
EndFunc

Func Fn0004()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var0009)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var0009, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var0009)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0013 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0013 = False
	EndIf
	ToolTip("Clearing Slot 4 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 4 = " & $Var0013 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0005")
EndFunc

Func Fn0005()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var000A)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var000A, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var000A)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0014 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0014 = False
	EndIf
	ToolTip("Clearing Slot 5 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 5 = " & $Var0014 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0006")
EndFunc

Func Fn0006()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var000B)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var000B, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var000B)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0015 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0015 = False
	EndIf
	ToolTip("Clearing Slot 6 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 6 = " & $Var0015 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0007")
EndFunc

Func Fn0007()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var000C)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var000C, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var000C)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0016 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0016 = False
	EndIf
	ToolTip("Clearing Slot 7 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 7 = " & $Var0016 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0008")
EndFunc

Func Fn0008()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var000D)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var000D, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var000D)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0017 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0017 = False
	EndIf
	ToolTip("Clearing Slot 8 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 8 = " & $Var0017 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn0009")
EndFunc

Func Fn0009()
	Local $Var0020
	$Var0020 = PixelGetColor($Var0005, $Var000E)
	If $Var0020 = $Var0004 Then
		Do
			MouseClick("left", $Var0005, $Var000E, 1, 5)
			Sleep(0x01F4)
			$Var0020 = PixelGetColor($Var0005, $Var000E)
			Call("Fn000D")
		Until $Var0020 <> $Var0004
		$Var0018 = True
	ElseIf $Var0020 <> $Var0004 Then
		$Var0018 = False
	EndIf
	ToolTip("Clearing Slot 9 of cycle #" & $Var001A & @CRLF & "Check number is " & $Var0020 & " and Mail number is " & $Var0004 & @CRLF & "Mail was found in Slot 9 = " & $Var0018 & @CRLF & 'Mail Grabber will end once ""J"" key is pressed.' & @CRLF & 'To pause Mail Grabber, please press the ""H"" key.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	Call("Fn000B")
EndFunc

Func Fn000A()
	Local $Var0020, $Var0021
	Sleep(0x03E8)
	Call("Fn000D")
	If $Var0010 = True And $Var0011 = True And $Var0012 = True And $Var0013 = True And $Var0014 = True And $Var0015 = True And $Var0016 = True And $Var0017 = True And $Var0018 = True Then
		MouseClick("left", $Var0000, $Var0001, 1, 5)
	Else
		If $Var0010 = True Then
			MouseClick("left", $Var001F, $Var0006, 1, 5)
		EndIf
		If $Var0011 = True Then
			MouseClick("left", $Var001F, $Var0007, 1, 5)
		EndIf
		If $Var0012 = True Then
			MouseClick("left", $Var001F, $Var0008, 1, 5)
		EndIf
		If $Var0013 = True Then
			MouseClick("left", $Var001F, $Var0009, 1, 5)
		EndIf
		If $Var0014 = True Then
			MouseClick("left", $Var001F, $Var000A, 1, 5)
		EndIf
		If $Var0015 = True Then
			MouseClick("left", $Var001F, $Var000B, 1, 5)
		EndIf
		If $Var0016 = True Then
			MouseClick("left", $Var001F, $Var000C, 1, 5)
		EndIf
		If $Var0017 = True Then
			MouseClick("left", $Var001F, $Var000D, 1, 5)
		EndIf
		If $Var0018 = True Then
			MouseClick("left", $Var001F, $Var000E, 1, 5)
		EndIf
	EndIf
	MouseClick("left", $Var0002, $Var0003, 1, 5)
	Sleep(0x01F4)
	MouseClick("left", $Var001B, $Var001C, 1, 5)
	Sleep(0x01F4)
	$Var001A = $Var001A + 1
EndFunc

Func Fn000B()
	If $Var0010 = False And $Var0011 = False And $Var0012 = False And $Var0013 = False And $Var0014 = False And $Var0015 = False And $Var0016 = False And $Var0017 = False And $Var0018 = False Then
		MsgBox(0x0040, "Mailgrabber", "Mail box emptied" & @LF & $Var001A & " pages of mail collected and deleted" & @LF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.")
		Exit
	Else
		Call("Fn000A")
	EndIf
EndFunc

Func Fn000C()
	MsgBox(0x0040, "Mailgrabber", "Mail box emptied" & @LF & $Var001A & " pages of mail collected and deleted" & @LF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.")
	Exit
EndFunc

Func Fn000D()
	Local $Var0022, $Var0023, $Var0024
	$Var0022 = PixelGetColor($Var001D, $Var001C)
	$Var0023 = PixelGetColor($Var001E, $Var001C)
	If $Var0022 < 0x0007A120 And $Var0023 < 0x0007A120 Then
		Do
			MouseClick("left", $Var001D, $Var001C, 1, 5)
			Sleep(0x03E8)
			$Var0024 = PixelGetColor($Var001D, $Var001C)
		Until $Var0024 <> $Var0022
	EndIf
EndFunc

Func Fn000E()
	$Var000F = Not $Var000F
	While $Var000F
		Sleep(0x00FA)
		ToolTip('Mail Grabber has been paused. Press ""H"" again to resume from where you paused.' & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
	WEnd
	ToolTip("MailGrabber has been unpaused." & @CRLF & "Mail Grabber was made by [MPGH]'s Zaiakunokami.", 0x0032, 0x0032)
EndFunc
