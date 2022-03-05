#include-once
#include "Utils.au3"

Global $IsDonator = False
Global $DonatorName = ""
Global $DonatorEmail = ""
Global $Edition = "Public"
Global $DonatorDate = ""
Global $DonatorMessage = ""
Global $IsPremium = False

Dim $key = "5380C73022AB8D6A299042BC5E128DF4F03B1D4A79962B2FC14FA61B494AED0E4A09604DB9659529E3F37559E42480E00D8291E8A85B8E88D58EC27251121AB9A8E75BF2E6B79DC9D3E89CF4A7D27F042B68661D7C2B95DCF05A6827275FC9F68392D1A061837B1B54F9A8EF16D6AF8F21C03FDAD6738BDB4D5559F0C0DAAA0DE9AAB23D5FC01DAED26E40A7FAF88EF49942219139E955B0F7A78E50125A5A5116E156329DB83847EE5542ED5D6E5E89E463B78D8FCB8473C96F4A73909D86EA6E8375461500B6582310B6686DE72AEA766A31522CC4400CB7532E71D65EC53D0CBBF8D1E0F252B316C36CC4A4AE199DA2F00036562C4A2930CF986C6E8872B1D93F0436B8607AC659EFB33BD67E2775D3CD552A29DDC82C1090814AE4334464C22E8492E696FA096B584D87928E8BACAC3D59EDC174287A8C57C4F4ABD1DC9474D771B0650A370F324F9A3BD491DB6BCF82186E17EC36DBB6E71739688FD75ACE8DC578BD51ED95387B388AD941E62889C14897778E1A9CA62874A1FC4997EF45549134F95A1D257B8E41B08E27669B5F6EE7AB53B0D3788CD02291570B0E4733E5361CC6889E995F7F851D5A2ACEAF63A8311D64323CF8F8FC15CC56305C41A421974F93A47E990498F55C2D0DFD6EA143B3B7DA0C3572A66E6F7455D49E49FDD66841DD0C8D2ADE312C2240004806880E73AF7C9F6F7C0BA1CEB16C26CE0D"
Dim $seed1 = "MHWalker1"
Dim $seed2 = "MHWalker2"

Func GetSpecialMessage ()
	If $DonatorName == "NS" Then
		Return "For Fufu, from Sweetcheeks."
	ElseIf $DonatorName == "AB" Then
		Return "For our fearless leader."
	ElseIf $DonatorName == "l2noob2" Then
		Return "I'm ready for my first lesson."
	EndIf
	Return ""
EndFunc

Func VerifyLicense ($filename = "MHWalker.lic")
	Dim $encLic = __StringEncrypt(1, $key, $seed1, 3)

	Dim $file = FileOpen($filename, 0)
	Dim $myEmail = FileReadLine($file)
	Dim $myLic = FileReadLine($file)
	Dim $myName = FileReadLine($file)
	Dim $myDate = FileReadLine($file)
	Dim $myMsg = FileReadLine($file)
	FileClose($file)

	Dim $thisName = __StringEncrypt(0, $myName, $seed1, 6)
	Dim $thisEmail = __StringEncrypt(0, $myEmail, $thisName, 5)
	Dim $thisLic = __StringEncrypt(0, $myLic, $seed1 & $thisName & $thisEmail, 4)
	Dim $thisDate = __StringEncrypt(0, $myDate, $thisEmail & $thisName, 5)
	Dim $thisMsg = __StringEncrypt(0, $myMsg, $seed1 & $thisDate & $thisName, 6)
	If $thisLic == ($key) Then
		$IsPremium = False
		$IsDonator = True
		$DonatorName = $thisName
		$DonatorEmail = $thisEmail
		$Edition = "VIP"
		$DonatorDate = $thisDate
		$DonatorMessage = $thisMsg
	Else
		$IsPremium = False
		$IsDonator = False
		$DonatorName = ""
		$DonatorEmail = ""
		$Edition = "Public"
		$DonatorDate = ""
		$DonatorMessage = ""
	EndIf
EndFunc

Func VerifyLicense2 ($filename = "MHWalker.lic")
	Dim $encLic = __StringEncrypt(1, $key, $seed2, 3)

	Dim $file = FileOpen($filename, 0)
	Dim $myEmail = FileReadLine($file)
	Dim $myLic = FileReadLine($file)
	Dim $myName = FileReadLine($file)
	Dim $myDate = FileReadLine($file)
	Dim $myMsg = FileReadLine($file)
	FileClose($file)

	Dim $thisName = __StringEncrypt(0, $myName, $seed2, 6)
	Dim $thisEmail = __StringEncrypt(0, $myEmail, $thisName, 5)
	Dim $thisLic = __StringEncrypt(0, $myLic, $seed2 & $thisName & $thisEmail, 4)
	Dim $thisDate = __StringEncrypt(0, $myDate, $thisEmail & $thisName, 5)
	Dim $thisMsg = __StringEncrypt(0, $myMsg, $seed2 & $thisDate & $thisName, 6)
	If $thisLic == ($key) Then
		$IsPremium = True
		$IsDonator = True
		$DonatorName = $thisName
		$DonatorEmail = $thisEmail
		$Edition = "Premium"
		$DonatorDate = $thisDate
		$DonatorMessage = $thisMsg
	EndIf
EndFunc

VerifyLicense()
VerifyLicense2()
