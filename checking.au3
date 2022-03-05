#include <WinAPI.au3>

AutoItSetOption("MouseCoordMode", 1)
Dim $tPoint = DllStructCreate("int X;int Y")
DllStructSetData($tPoint, "X", 0)
DllStructSetData($tPoint, "Y", 0)
_WinAPI_ClientToScreen(WinGetHandle("[Class:Valve001]"), $tPoint)
Dim $x = DllStructGetData($tPoint, "X")
Dim $y = DllStructGetData($tPoint, "Y")

ControlClick("[Class:Valve001]", "", "", "left", 1, $x+1135, $y+560)