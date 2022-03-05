#include "Utils.au3"
#include "FastPixel.au3"

Dim $consoletitle = "[Class:ConsoleWindowClass; Title:DankSole]"
Dim $vindititle = "[Class:Valve001; Title:Vindictus]"

$OperationHwnd = WinGetHandle($vindititle)
$ControlMode = 1

ConsoleWrite("Color Distance: " & ColorDistance(0xF10000, 0xF30000) & @CRLF)

