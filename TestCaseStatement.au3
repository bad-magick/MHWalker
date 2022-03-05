$msg = ""
$szName = InputBox(Default, "Please enter a word.", "", " M", Default, Default, Default, Default, 10)
Select
	Case $szName == "a"
		$snName = "toby"
	Case $szName == "toby"
		MsgBox(0, "", $szName)
EndSelect