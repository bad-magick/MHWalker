#include "Settings.au3"

Local $aSocket[$WebServerMaxConnections]
Local $sBuffer[$WebServerMaxConnections]

Dim $sServerName = "MHWalker"

For $x = 0 to UBound($aSocket)-1
    $aSocket[$x] = -1
Next

Global $iMainSocket

Func WebServerStart($IP, $Port)
	TCPStartup()
	$iMainSocket = TCPListen($IP,$Port)
	If @error Then
		Return False
	Else
		Return True
	EndIf
EndFunc

Func WebServerStop()
	TCPShutdown()
EndFunc

Func WebServerLoop()
    Dim $iNewSocket = TCPAccept($iMainSocket)

    If $iNewSocket >= 0 Then
		Dim $x = 0
        For $x = 0 to UBound($aSocket)-1
            If $aSocket[$x] = -1 Then
                $aSocket[$x] = $iNewSocket
                ExitLoop
            EndIf
        Next
    EndIf

    For $x = 0 to UBound($aSocket)-1
        If $aSocket[$x] = -1 Then Return
        Dim $sNewData = TCPRecv($aSocket[$x],1024)
        If @error Then
            $aSocket[$x] = -1
        ElseIf $sNewData Then
            $sBuffer[$x] &= $sNewData
            If StringInStr(StringStripCR($sBuffer[$x]),@LF&@LF) Then
                Dim $sFirstLine = StringLeft($sBuffer[$x],StringInStr($sBuffer[$x],@LF))
                Dim $sRequestType = StringLeft($sFirstLine,StringInStr($sFirstLine," ")-1)
                If $sRequestType = "GET" Then
					_HTTP_SendLog($aSocket[$x])
                EndIf
                $sBuffer[$x] = ""
                $aSocket[$x] = -1
            EndIf
        EndIf
    Next
EndFunc

Func _HTTP_SendLog($hSocket)
	Dim $text = "<title>MHWalker Log</title><center><h1>MHWalker Log</h1></center><br>" & @CRLF & "<p>" & @CRLF
	Dim $f = FileOpen("MHWalker.log", 0)
	Dim $dat = FileRead($f)
	FileClose($f)
	Dim $a = StringSplit($dat, @CR)
	Dim $i = 0
	Dim $min = 0
	If $a[0] <= 50 Then
		$min = 1
	Else
		$min = $a[0] - 50
	EndIf
	For $i = $a[0] To $min Step - 1
		$a[$i] = StringReplace($a[$i], @CR, "")
		$a[$i] = StringReplace($a[$i], @LF, "")
		$text = $text & $a[$i] & "<br/>" & @CRLF
	Next
	$text = $text & "</p>" & @CRLF
	_HTTP_SendData($hSocket, Binary($text), "text/html", "200 OK")
EndFunc

Func _HTTP_SendData($hSocket, $bData, $sMimeType, $sReply = "200 OK")
	Dim $sPacket = Binary("HTTP/1.1 " & $sReply & @CRLF & _
    "Server: " & $sServerName & @CRLF & _
	"Connection: close" & @CRLF & _
	"Content-Lenght: " & BinaryLen($bData) & @CRLF & _
    "Content-Type: " & $sMimeType & @CRLF & _
    @CRLF)
    TCPSend($hSocket,$sPacket)

    While BinaryLen($bData)
        Dim $a = TCPSend($hSocket, $bData)
        $bData = BinaryMid($bData, $a+1, BinaryLen($bData)-$a)
    WEnd

    $sPacket = Binary(@CRLF & @CRLF)
    TCPSend($hSocket,$sPacket)

	TCPCloseSocket($hSocket)
EndFunc

