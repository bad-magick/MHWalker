#include-once

#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include "FastPixel.au3"
#include "MHZip.au3"

Func _GDIPlus_BitmapSetPixel($_hBitmap, $iX, $iY, $iARGB = 0xFF000000)
    Local $aRet
    $aRet = DllCall($ghGDIPDll, "int", "GdipBitmapSetPixel", "hwnd", $_hBitmap, "int", $iX, "int", $iY, "dword", $iARGB)
    Return
EndFunc

Func _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight, $iStride = 0, $iPixelFormat = 0x0026200A, $pScan0 = 0)
    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iWidth, "int", $iHeight, "int", $iStride, "int", $iPixelFormat, "ptr", $pScan0, "int*", 0)
    If @error Then Return SetError(@error, @extended, 0)
    Return $aResult[6]
EndFunc

Func DrawRect($_hBitmap, $x1, $y1, $x2, $y2)
	Dim $x = 0
	Dim $y = 0

	For $x = $x1 To $x2
		For $y = $y1 To $y2
			_GDIPlus_BitmapSetPixel($_hBitmap, $x, $y)
		Next
	Next
EndFunc

Func GetNextErrorIndex()
	DirCreate("Error Reports")
	Dim $i = -1
	Do
		$i += 1
	Until (Not FileExists("Error Reports\Report" & StringFormat("%03u", $i) & ".zip"))
	Return StringFormat("%03u", $i)
EndFunc

Func SaveScreenCapture($fileSpec, $x1, $y1, $x2, $y2)
	Dim $hBMP = _ScreenCapture_Capture("", $x1, $y1, $x2, $y2, False)
	Dim $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)
	Dim $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

	;Dim $hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	;_GDIPlus_GraphicsFillRect($hContext, 2, 184, 144, 199, $hBrush)
	;_GDIPlus_GraphicsFillRect($hContext, 250, 250, 2, 2, $hBrush)
    DrawRect($hBitmap, 2, 184, 144, 200)	;block name on party list
    DrawRect($hBitmap, (($x2 - $x1) / 2) - 80, (($y2 - $y1) / 2) - 96, (($x2 - $x1) / 2) + 80, (($y2 - $y1) / 2) - 75)	;block name at standard character position

	_GDIPlus_ImageSaveToFile($hBitmap, $fileSpec)

	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_ImageDispose($hContext)
	_WinAPI_DeleteObject($hBMP)
EndFunc

Func SaveData($fileSpec, $Edition, $WaitingForEx, $ErrorCondition, $NextFix, $OathMode, $MiningMode, $MailMode, $Slider, $UseEU)
	IniWrite($fileSpec, "Report", "Edition", $Edition)
	IniWrite($fileSpec, "Report", "WaitingFor", $WaitingForEx)
	IniWrite($fileSpec, "Report", "ErrorCond", $ErrorCondition)
	IniWrite($fileSpec, "Report", "NextFix", $NextFix)
	IniWrite($fileSpec, "Report", "Oath", $OathMode)
	IniWrite($fileSpec, "Report", "Mine", $MiningMode)
	IniWrite($fileSpec, "Report", "Mail", $MailMode)
	IniWrite($fileSpec, "Report", "Slider", $Slider)
	IniWrite($fileSpec, "Report", "EU", $UseEU)
EndFunc

Func BuildReport($suffix, $screen, $data, $settings)
	Dim $zip = @WorkingDir & "\Error Reports\Report" & $suffix & ".zip"
	_Zip_Create($zip)
	_Zip_AddFile($zip, $screen)
	_Zip_AddFile($zip, $data)
	_Zip_AddFile($zip, $settings)
EndFunc
