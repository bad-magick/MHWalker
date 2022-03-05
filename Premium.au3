#include-once

Dim $filename;

Func InitPremium()
	$filename = @TempDir & "\a8dc570da319.tmp"
EndFunc

Func SendCommandSize($size)
	Dim $px = PixelGetColor($vinCenter[0], $vinCenter[1] / 2)
	Dim $file = FileOpen($filename, 2)
	FileWriteLine($file, "cc_change_figure_height " & $size & @CRLF)
	FileClose($file)

	While (FileExists($filename))
		Sleep(100)
	WEnd
	Return $px
EndFunc

Func SendCommandPosition($x, $y, $z)
	Dim $file = FileOpen($filename, 2)
	FileWriteLine($file, "origin " & $x & " " & $y & " " & $z & " 0 0 0" & @CRLF)
	FileClose($file)

	While (FileExists($filename))
		Sleep(100)
	WEnd
EndFunc