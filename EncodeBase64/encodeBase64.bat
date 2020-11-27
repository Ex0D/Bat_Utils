@echo off
chcp 65001>nul
setlocal EnableDelayedExpansion

if not "%1" == "" goto:convert
goto:usage

:convert
set base64output=%2
if "%base64output%" == "" set base64output=con

(
    set base64temp=base64.tmp
    certutil -encode "%1" !base64temp! > nul
    findstr /v /c:- !base64temp!
    erase !base64temp!
) > %base64output%
echo [Done] ► %base64output% has been created !
exit /b

:usage
cls
echo [Usage] ► encodeBase64 (file) [output_file]
exit /b