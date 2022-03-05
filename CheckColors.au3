#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
$classPaint = "[Class:MSPaintApp]"
$classVindictus = "[Class:Valve001]"
$hWnd = WinGetHandle($classPaint)

AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseCoordMode", 2)

MsgBox(0, "", PixelGetColor(151, 109, $hWnd) & @CRLF)
MsgBox(0, "", PixelGetColor(116, 108, $hWnd) & @CRLF)
MsgBox(0, "", PixelGetColor(148, 121, $hWnd) & @CRLF)