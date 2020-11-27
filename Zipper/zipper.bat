cls
@echo off
chcp 65001>nul
title zipper
if "%1"=="" goto:usage

setlocal
set TMPDIR=%TMP%\zipper
set INPUT=%1
set OUTPUT=%2.zip

if "%2"=="" set OUTPUT=%1.zip

echo Set objArgs = Wscript.Arguments > zipper.vbs
echo InputDir = objArgs(0) >> zipper.vbs
echo ZipFile = objArgs(1) >> zipper.vbs
echo Set fso = Wscript.CreateObject("Scripting.FileSystemObject") >> zipper.vbs
echo Set objZipFile = fso.CreateTextFile(ZipFile , True) >> zipper.vbs
echo objZipFile.Write "PK" ^& Chr(5) ^& Chr(6) ^& String(18, vbNullChar) >> zipper.vbs
echo objZipFile.Close >> zipper.vbs
echo Set objShell = Wscript.CreateObject("Shell.Application") >> zipper.vbs
echo Set source = objShell.NameSpace(InputDir).Items >> zipper.vbs
echo Set objZip = objShell.NameSpace(fso.GetAbsolutePathName(ZipFile)) >> zipper.vbs
echo if not (objZip is nothing) then >> zipper.vbs
echo    objZip.CopyHere(source) >> zipper.vbs
echo    wScript.Sleep 1000 >> zipper.vbs
echo end if >> zipper.vbs

mkdir %TMPDIR%
xcopy /y /s %INPUT% %TMPDIR% 
wscript zipper.vbs %TMPDIR% %OUTPUT%
del zipper.vbs
rmdir /s /q %TMPDIR%

echo %INPUT% has been well compressed in this folder into %INPUT%.zip
title cmd.exe
exit /b

:noInput
echo [Usage] ► zipper input (optionnal output)
exit /b