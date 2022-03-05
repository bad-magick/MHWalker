#include-once

AutoItSetOption("WinTitleMatchMode", 2)

Dim $ConsoleExists = False
Dim $ConsoleHandle = 0
Dim $ConsoleTitle = ""
Dim $ConsoleName = ""
Dim $ConsoleIsBad = False
Dim $ConsoleGodmode = False
Dim $ConsoleControl = ""
Dim $ConsoleExtras = False

Func _CmdAttachConsole($pCmd)
    Local $hConsole
    DllCall( "Kernel32.dll", "int", "AttachConsole", "int", $pCmd )
    If @error Then Return SetError(1, 0, -1)
    $hConsole = DllCall( "Kernel32.dll", "hwnd", "CreateFile","str","CONOUT$", "int", 0xC0000000 _
                       , "int", 7, "int", 0, "int", 3, "int", 0, "int", 0 )
    If $hConsole = -1 Then Return SetError( 2, 0, -1 )
    Return $hConsole
EndFunc

Func WriteToConsole ($hConsole, $sText)
	Dim $ret = 0
	Local $aRet = DllCall("kernel32.dll", "int", "WriteConsoleInputA", "hwnd", $hConsole, Ptr($sText), StringLen($sText) + 2, Ptr($ret))
	MsgBox(0, "", $aRet)
EndFunc

Func DetectConsole()
	AutoItSetOption("WinTitleMatchMode", 2)
	If WinExists("[Class:ConsoleWindowClass; Title:VIP DankSole]") Then
		$ConsoleTitle = "[Class:ConsoleWindowClass; Title:VIP DankSole]"
		$ConsoleExists = True
		$ConsoleHandle = WinGetHandle($ConsoleTitle)
		$ConsoleName = "VIP DankSole 3.0"
		$ConsoleIsBad = False
		$ConsoleGodmode = False
		$ConsoleControl = ""
	ElseIf WinExists("[Class:ConsoleWindowClass; Title:Pub Console by Hell_Demon & Nico]") Then
		$ConsoleTitle = "[Class:ConsoleWindowClass; Title:Pub Console by Hell_Demon & Nicdel]"
		$ConsoleExists = True
		$ConsoleHandle = WinGetHandle($ConsoleTitle)
		$ConsoleName = "Pub Console by Hell_Demon & Nicdel"
		$ConsoleIsBad = False
		$ConsoleGodmode = True
		$ConsoleControl = ""
	ElseIf WinExists("[Class:#32770; Title:Console by Hell_Demon]") Then
		$ConsoleTitle = "[Class:#32770; Title:Console by Hell_Demon]"
		$ConsoleExists = True
		$ConsoleHandle = WinGetHandle($ConsoleTitle)
		$ConsoleName = "Hell_Demon[VIP Edition 4.0]"
		$ConsoleIsBad = False
		$ConsoleGodmode = True
		$ConsoleControl = "[Class:Edit; Instance:1]"
	ElseIf WinExists("[Class:ConsoleWindowClass; Title:MHConsole v]") Then
		$ConsoleTitle = "[Class:ConsoleWindowClass; Title:MHConsole v]"
		$ConsoleExists = True
		$ConsoleHandle = WinGetHandle($ConsoleTitle)
		$ConsoleName = "MHConsole by l2noob2"
		$ConsoleIsBad = False
		$ConsoleGodmode = False
		$ConsoleExtras = True
	ElseIf WinExists("[Class:ConsoleWindowClass; Title:l2noob2]") Then
		$ConsoleTitle = "[Class:ConsoleWindowClass; Title:l2noob2]"
		$ConsoleExists = True
		$ConsoleHandle = WinGetHandle($ConsoleTitle)
		$ConsoleName = "Pub Console by l2boob2"
		$ConsoleIsBad = False
		$ConsoleGodmode = False
	EndIf
	AutoItSetOption("WinTitleMatchMode", 1)
EndFunc

Func DankSoleWrite($text)
	Dim $command = StringReplace($text, Chr(0x22) & Chr(0x22), Chr(0x22))
	If $ConsoleExists Then
		If Not WinActive($ConsoleTitle) Then
			WinActivate($ConsoleTitle)
		EndIf
		ControlSend($ConsoleHandle, "", $ConsoleControl, $command & @CRLF)
	EndIf
EndFunc

Func HDWrite($text)
	DankSoleWrite($text)
	MinimizeConsole()
EndFunc

Func DankSoleWriteDebug()
	DankSoleWrite("cl_showfps 2")
	DankSoleWrite("cl_showpos 1")
EndFunc

Func MinimizeConsole()
	WinSetState($ConsoleHandle, "", @SW_MINIMIZE)
EndFunc

DetectConsole()

;MsgBox (0, "", $ConsoleExists)
