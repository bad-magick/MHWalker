;#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
AutoItSetOption("MustDeclareVars", 1)
#include <array.au3>
; ------------------------------------------------------------------------------
;
; AutoIt Version: 3.2
; Language:       English
; Description:    ZIP Functions.
; Author:		  torels_
;
; ------------------------------------------------------------------------------

;===============================================================================
;
; Function Name:    _Zip_Create()
; Description:      Create Empty ZIP file.
; Parameter(s):     $hFilename - Complete path to zip file that will be created
; Requirement(s):   none.
; Return Value(s):  Returns the Zip file path (to be used as a handle - even though it's not necessary)
; Author(s):        torels_
;
;===============================================================================
Func _Zip_Create($hFilename)
	Dim $hFp = FileOpen($hFilename, 26)
	Dim $sString = Chr(80) & Chr(75) & Chr(5) & Chr(6) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0)
	FileWrite($hFp, $sString)
	If @error Then Return SetError(1,0,0)
	FileClose($hFp)

	While Not FileExists($hFilename)
		Sleep(10)
	Wend
	Return $hFilename
EndFunc   ;==>_Zip_Create

;===============================================================================
;
; Function Name:    _Zip_AddFile()
; Description:      Add a file to a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$hFile2Add - Complete path to the file that will be added
;					$flag = 1
;					- 0 ProgressBox
;					- 1 no progress box
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
;                   On Failure - Returns False
; Author(s):        torels_
; Notes:			The return values will be given once the compressing process is ultimated... it takes some time with big files
;
;===============================================================================
Func _Zip_AddFile($hZipFile, $hFile2Add, $flag = 1)
	Local $DLLChk = _Zip_DllChk()
	Local $files = _Zip_Count($hZipFile)
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0);no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	Dim $oApp = ObjCreate("Shell.Application")
	Dim $copy = $oApp.NameSpace($hZipFile).CopyHere($hFile2Add)
	While 1
		If $flag = 1 then _Hide()
		If _Zip_Count($hZipFile) = ($files+1) Then ExitLoop
		Sleep(10)
	WEnd
	Return SetError(0,0,1)
EndFunc   ;==>_Zip_AddFile

;===============================================================================
;
; Function Name:    _Zip_AddFolder()
; Description:      Add a folder to a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$hFolder - Complete path to the folder that will be added (possibly including "\" at the end)
;					$flag = 1
;					- 1 no progress box
;					- 0 progress box
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
; Notes:			The return values will be given once the compressing process is ultimated... it takes some time with big files
;
;===============================================================================
Func _Zip_AddFolder($hZipFile, $hFolder, $flag = 1)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0);no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	If StringRight($hFolder, 1) <> "\" Then $hFolder &= "\"
	Dim $files = _Zip_Count($hZipFile)
	Dim $oApp = ObjCreate("Shell.Application")
	Dim $oCopy = $oApp.NameSpace($hZipFile).CopyHere($oApp.Namespace($hFolder))
	While 1
		If $flag = 1 then _Hide()
		If _Zip_Count($hZipFile) = ($files+1) Then ExitLoop
		Sleep(10)
	WEnd
	Return SetError(0,0,1)
EndFunc   ;==>_Zip_AddFolder

;===============================================================================
;
; Function Name:    _Zip_AddFolderContents()
; Description:      Add a folder to a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$hFolder - Complete path to the folder that will be added (possibly including "\" at the end)
;					$flag = 1
;					- 1 no progress box
;					- 0 progress box
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
; Notes:			The return values will be given once the compressing process is ultimated... it takes some time with big files
;
;===============================================================================
Func _Zip_AddFolderContents($hZipFile, $hFolder, $flag = 1)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0);no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	If StringRight($hFolder, 1) <> "\" Then $hFolder &= "\"
	Dim $files = _Zip_Count($hZipFile)
	Dim $oApp = ObjCreate("Shell.Application")
	Dim $oFolder = $oApp.NameSpace($hFolder)
	Dim $oCopy = $oApp.NameSpace($hZipFile).CopyHere($oFolder.Items)
	Dim $oFC = $oApp.NameSpace($hFolder).items.count
	While 1
		If $flag = 1 then _Hide()
		If _Zip_Count($hZipFile) = ($files+$oFC) Then ExitLoop
		Sleep(10)
	WEnd
	Return SetError(0,0,1)
EndFunc   ;==>_Zip_AddFolderContents

;===============================================================================
;
; Function Name:    _Zip_Delete()
; Description:      Delete a file from a ZIP Archive.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$hFolder - Complete path to the folder that will be added (possibly including "\" at the end)
;					$flag = 1
;					- 1 no progress box
;					- 0 progress box
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
; Notes:			none
;
;===============================================================================
Func _Zip_Delete($hZipFile, $hFilename, $flag = 1)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0);no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	Dim $list = _Zip_List($hZipFile)
	Dim $dir = @TempDir & "\tmp" & Floor(Random(0,100))
	For $i = 1 to $list[0]
		If $list[$i] <> $hFilename Then _Zip_Unzip($hZipFile,$list[$i],$dir, $flag)
	Next
	FileDelete($hZipFile)
	_Zip_Create($hZipFile)
	_Zip_AddFolderContents($hZipFile, $dir, $flag)
	DirRemove($dir)
EndFunc

;===============================================================================
;
; Function Name:    _Zip_UnzipAll()
; Description:      Extract all files contained in a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$hDestPath - Complete path to where the files will be extracted
;					$flag = 1
;					- 1 no progress box
;					- 0 progress box
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
; Notes:			The return values will be given once the extracting process is ultimated... it takes some time with big files
;
;===============================================================================
Func _Zip_UnzipAll($hZipFile, $hDestPath, $flag = 1)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0);no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(2, 0, 0) ;no zip file
	If Not FileExists($hDestPath) Then DirCreate($hDestPath)
	Local $aArray[1]
	Dim $oApp = ObjCreate("Shell.Application")
	$oApp.Namespace($hDestPath).CopyHere($oApp.Namespace($hZipFile).Items)
	For $item In $oApp.Namespace($hZipFile).Items
		_ArrayAdd($aArray, $item)
	Next
	While 1
		If $flag = 1 then _Hide()
		If FileExists($hDestPath & "\" & $aArray[UBound($aArray) - 1]) Then
			Return SetError(0, 0, 1)
			ExitLoop
		EndIf
		Sleep(500)
	WEnd
EndFunc   ;==>_Zip_UnzipAll

;===============================================================================
;
; Function Name:    _Zip_Unzip()
; Description:      Extract a single file contained in a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$hFilename - Name of the element in the zip archive ex. "hello_world.txt"
;					$hDestPath - Complete path to where the files will be extracted
;					$flag = 1
;					- 1 no progress box
;					- 0 progress box
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
; Notes:			The return values will be given once the extracting process is ultimated... it takes some time with big files
;
;===============================================================================
Func _Zip_Unzip($hZipFile, $hFilename, $hDestPath, $flag = 1)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0) ;no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	If Not FileExists($hDestPath) Then DirCreate($hDestPath)
	Dim $oApp = ObjCreate("Shell.Application")
	Dim $hFolderitem = $oApp.NameSpace($hZipFile).Parsename($hFilename)
	$oApp.NameSpace($hDestPath).Copyhere($hFolderitem)
	While 1
		If $flag = 1 then _Hide()
		If FileExists($hDestPath & "\" & $hFilename) Then
			return SetError(0, 0, 1)
			ExitLoop
		EndIf
		Sleep(500)
	WEnd
EndFunc   ;==>_Zip_Unzip

;===============================================================================
;
; Function Name:    _Zip_Count()
; Description:      Count files contained in a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
;
;===============================================================================
Func _Zip_Count($hZipFile)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0) ;no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	Dim $items = _Zip_List($hZipFile)
	Return UBound($items) - 1
EndFunc   ;==>_Zip_Count

;===============================================================================
;
; Function Name:    _Zip_CountAll()
; Description:      Count All files contained in a ZIP Archive (including Sub Directories)
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_, Smashly
;
;===============================================================================
Func _Zip_CountAll($hZipFile)
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0) ;no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
    Dim $oApp = ObjCreate("Shell.Application")
    Dim $oDir = $oApp.NameSpace(StringLeft($hZipFile, StringInStr($hZipFile, "\", 0, -1)))
    Dim $sZipInf = $oDir.GetDetailsOf($oDir.ParseName(StringTrimLeft($hZipFile, StringInStr($hZipFile, "\", 0, -1))), -1)
    Return StringRight($sZipInf, StringLen($sZipInf) - StringInStr($sZipInf, ": ") - 1)
EndFunc

;===============================================================================
;
; Function Name:    _Zip_List()
; Description:      Returns an Array containing of all the files contained in a ZIP Archieve.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1~3
;					@error = 1 no Zip file
;					@error = 2 no dll
;					@error = 3 dll isn't registered
; Author(s):        torels_
;
;===============================================================================
Func _Zip_List($hZipFile)
	local $aArray[1]
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0) ;no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	Dim $oApp = ObjCreate("Shell.Application")
	Dim $hList = $oApp.Namespace($hZipFile).Items
	For $item in $hList
		_ArrayAdd($aArray,$item.name)
	Next
	$aArray[0] = UBound($aArray) - 1
	Return $aArray
EndFunc   ;==>_Zip_List

;===============================================================================
;
; Function Name:    _Zip_Search()
; Description:      Search files in a ZIP Archive.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$sSearchString - name of the file to be searched
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1 (no file found)
; Author(s):        torels_
; Notes:			none
;
;===============================================================================
Func _Zip_Search($hZipFile, $sSearchString)
	local $aArray
	Local $DLLChk = _Zip_DllChk()
	If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0) ;no dll
	If not _IsFullPath($hZipFile) then Return SetError(4,0) ;zip file isn't a full path
	If Not FileExists($hZipFile) Then Return SetError(1, 0, 0) ;no zip file
	Dim $list = _Zip_List($hZipFile)
	for $i = 0 to UBound($list) - 1
		if StringInStr($list[$i],$sSearchstring) > 0 Then
			_ArrayAdd($aArray, $list[$i])
		EndIf
	Next
	if UBound($aArray) - 1 = 0 Then
		Return SetError(1,0,0)
	Else
		Return $aArray
	EndIf
EndFunc ;==> _Zip_Search

;===============================================================================
;
; Function Name:    _Zip_SearchInFile()
; Description:      Search files in a ZIP Archive's File.
; Parameter(s):     $hZipFile - Complete path to zip file that will be created (or handle if existant)
;					$sSearchString - name of the file to be searched
; Requirement(s):   none.
; Return Value(s):  On Success - 0
;                   On Failure - sets @error 1 (no file found)
; Author(s):        torels_
; Notes:			none
;
;===============================================================================
Func _Zip_SearchInFile($hZipFile, $sSearchString)
	local $aArray
	Dim $list = _Zip_List($hZipFile)
	for $i = 1 to UBound($list) - 1
		_Zip_Unzip($hZipFile, $list[$i], @TempDir & "\tmp_zip.file")
		Dim $read = FileRead(@TempDir & "\tmp_zip.file")
		if StringInStr($read,$sSearchstring) > 0 Then
			_ArrayAdd($aArray, $list[$i])
		EndIf
	Next
	if UBound($aArray) - 1 = 0 Then
		Return SetError(1,0,1)
	Else
		Return $aArray
	EndIf
EndFunc ;==> _Zip_Search

;===============================================================================
;
; Function Name:    _Zip_DllChk()
; Description:      Internal error handler.
; Parameter(s):     none.
; Requirement(s):   none.
; Return Value(s):  Failure - @extended = 1
; Author(s):        smashley
;
;===============================================================================
Func _Zip_DllChk()
	If Not FileExists(@SystemDir & "\zipfldr.dll") Then Return 2
	If Not RegRead("HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}", "") Then Return 3
	Return 0
EndFunc   ;==>_Zip_DllChk

;===============================================================================
;
; Function Name:    _GetIcon()
; Description:      Internal Function.
; Parameter(s):     $file - File form which to retrieve the icon
;					$ReturnType - IconFile or IconID
; Requirement(s):   none.
; Return Value(s):  Icon Path/ID
; Author(s):        torels_
;
;===============================================================================
Func _GetIcon($file, $ReturnType = 0)
	Dim $FileType = StringSplit($file, ".")
	Dim $FileType = $FileType[UBound($FileType)-1]
	Dim $FileParam = RegRead("HKEY_CLASSES_ROOT\." & $FileType, "")
	Dim $DefaultIcon = RegRead("HKEY_CLASSES_ROOT\" & $FileParam & "\DefaultIcon", "")

	If Not @error Then
		Dim $IconSplit = StringSplit($DefaultIcon, ",")
		ReDim $IconSplit[3]
		Dim $Iconfile = $IconSplit[1]
		Dim $IconID = $IconSplit[2]
	Else
		Dim $Iconfile = @SystemDir & "\shell32.dll"
		Dim $IconID = -219
	EndIf

	If $ReturnType = 0 Then
		Return $Iconfile
	Else
		Return $IconID
	EndIf
EndFunc

;===============================================================================
;
; Function Name:    _IsFullPath()
; Description:      Internal Function.
; Parameter(s):     $path - a zip path
; Requirement(s):   none.
; Return Value(s):  success - True.
;					failure - False.
; Author(s):        torels_
;
;===============================================================================
Func _IsFullPath($path)
    if StringInStr($path,":\") then
        Return True
    Else
        Return False
    EndIf
Endfunc

;===============================================================================
;
; Function Name:    _Hide()
; Description:      Internal Function.
; Parameter(s):     none
; Requirement(s):   none.
; Return Value(s):  none.
; Author(s):        torels_
;
;===============================================================================
Func _Hide()
	If ControlGetHandle("[CLASS:#32770]", "", "[CLASS:SysAnimate32; INSTANCE:1]") <> "" And WinGetState("[CLASS:#32770]") <> @SW_HIDE	Then ;The Window Exists
		Dim $hWnd = WinGetHandle("[CLASS:#32770]")
		WinSetState($hWnd, "", @SW_HIDE)
	EndIf
EndFunc