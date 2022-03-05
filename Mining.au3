#include-once
#include "Settings.au3"

If Not IsDeclared("$SpeedMod") Then
	Global $SpeedMod = 1
EndIf

Func GCD($a, $b)
	If $b == 0 Then
		Return $a
	Else
		Return GCD($b, Mod($a, $b))
	EndIf
EndFunc

Func GetAspectRatio($width, $height)
	Dim $r = GCD($width, $height)
	Dim $ret[2]
	$ret[0] = $width / $r
	$ret[1] = $height / $r
	Return $ret
EndFunc

Func MoveTo_Fruitful()
	Send($MoveForwardDown)
	Sleep(6943/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(1312/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(1616/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(9631/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(1440/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(1392/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(816/$SettingHostTimeScaleUse*$SpeedMod)
	Send($MoveRightDown)
	Sleep(416/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(1584/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(1392/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(784/$SettingHostTimeScaleUse*$SpeedMod)
	Send($MoveForwardUp)
	Sleep(608/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(464/$SettingHostTimeScaleUse*$SpeedMod)
	Send($MoveRightUp)
	Sleep(1519/$SettingHostTimeScaleUse*$SpeedMod)
	SpamSkill(1, 0)
	Sleep(112/$SettingHostTimeScaleUse*$SpeedMod)
EndFunc

Func MoveTo_DethroneTheWhiteTyrant()
	_Send($MoveLeftDown)
	Sleep(960/$SettingHostTimeScaleUse)
	_Send($MoveForwardDown)
	Sleep(80/$SettingHostTimeScaleUse)
	_Send($MoveLeftUp)
	Sleep(1552/$SettingHostTimeScaleUse)
	_Send($MoveLeftDown)
	Sleep(1088/$SettingHostTimeScaleUse)
	_Send($MoveLeftUp)
	Sleep(480/$SettingHostTimeScaleUse)
	_Send($MoveLeftDown)
	Sleep(1199/$SettingHostTimeScaleUse)
	_Send($MoveForwardUp)
	Sleep(480/$SettingHostTimeScaleUse)
	_Send($MoveForwardDown)
	Sleep(512/$SettingHostTimeScaleUse)
	_Send($MoveForwardUp)
	Sleep(2128/$SettingHostTimeScaleUse)
	_Send($MoveBackwardDown)
	Sleep(272/$SettingHostTimeScaleUse)
	_Send($MoveLeftUp)
	Sleep(416/$SettingHostTimeScaleUse)
	_Send($MoveLeftDown)
	Sleep(96/$SettingHostTimeScaleUse)
	_Send($MoveBackwardUp)
	Sleep(400/$SettingHostTimeScaleUse)
	_Send($MoveLeftUp)
EndFunc
