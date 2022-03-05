#include-once

Global $CommandAutoStart = 0
Global $CommandTrial = 0
Global $CommandUnlock = 0

Dim $i = 0
For $i = 1 To $CmdLine[0]
	Switch StringLower($CmdLine[$i])
		Case "/start"
			$CommandAutoStart = 1
		Case "/a76123f165ac716292f00"
			$CommandTrial = 1
		Case "/78bc3d610ee123f12c54a"
			$CommandUnlock = 1
	EndSwitch
Next
