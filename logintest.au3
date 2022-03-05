AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseCoordMode", 2)

Dim $wWindow = "[Class:Valve001; Title:Vindictus]"
Dim $vinRes = WinGetClientSize($wWindow)
Dim $vin43Offset = (($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2)
ConsoleWrite($vin43Offset & @CRLF)

WinActivate($wWindow)

Dim $s = ""
$s = $s & Hex(OffsetCheck(783, 473), 6) & @CRLF
$s = $s & Hex(OffsetCheck(913, 549), 6) & @CRLF
$s = $s & Hex(OffsetCheck(788, 335), 6) & @CRLF
$s = $s & Hex(OffsetCheck(788, 375), 6) & @CRLF

MsgBox(0, "Results", $s)

Func OffsetCheck($x, $y)
	ConsoleWrite(($vin43Offset + ((($vinRes[0] - ($vin43Offset * 2)) / 1024) * $x) & "x" & ($vinRes[1] / 768) * $y) & @CRLF)
	Return PixelGetColor($vin43Offset + ((($vinRes[0] - ($vin43Offset * 2)) / 1024) * $x), ($vinRes[1] / 768) * $y)
EndFunc

Func LetterBoxCheck($x, $y)
	Return PixelGetColor((($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2) + ((($vinRes[0] - ((($vinRes[0] - ($vinRes[1] / 3 * 4)) / 2) * 2)) / 1024) * $x), ($vinRes[1] / 768) * $y)
EndFunc

