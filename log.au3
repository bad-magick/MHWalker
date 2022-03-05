#include <GUIConstantsEx.au3>
#Include <GuiEdit.au3>

$Form1 = GUICreate("Form1", 600, 400, 150, 150)
Dim $editctrl = GUICtrlCreateEdit("", 10, 10, 400, 330)

GUISetState(@SW_SHOW)

Func WriteLog ($sValue)
	_GUICtrlEdit_AppendText($editctrl, $sValue & @CRLF)
EndFunc
