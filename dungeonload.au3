WinActivate("[Class:Valve001]")

AutoItSetOption("PixelCoordMode", 2)
Dim $vinRes = WinGetClientSize("[Class:Valve001]")

Dim $color1 = PixelGetColor($vinRes[0] - 160, $vinRes[1] - 63)
Dim $color2 = PixelGetColor($vinRes[0] - 134, $vinRes[1] - 63)
Dim $color3 = PixelGetColor($vinRes[0] - 221, $vinRes[1] - 63)
Dim $color4 = PixelGetColor($vinRes[0] - 455, $vinRes[1] - 63)
Dim $color5 = PixelGetColor($vinRes[0] - 23, $vinRes[1] - 246)

Dim $text = "Resolution: " & $vinRes[0] & "x" & $vinRes[1] & @CRLF
$text = $text & "Color 1: 0x" & Hex($color1, 6) & @CRLF
$text = $text & "Color 2: 0x" & Hex($color2, 6) & @CRLF
$text = $text & "Color 3: 0x" & Hex($color3, 6) & @CRLF
$text = $text & "Color 4: 0x" & Hex($color4, 6) & @CRLF
$text = $text & "Color 5: 0x" & Hex($color5, 6)

ClipPut($text)

$text = $text & @CRLF & @CRLF & "Copied to clipboard."
MsgBox(0, "Colors", $text)
