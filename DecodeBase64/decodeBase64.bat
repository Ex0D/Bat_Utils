@echo off
chcp 65001>nul
setlocal EnableDelayedExpansion

if not "%1" == "" goto:decode
goto:usage

:decode
set base64output=%2
if "%base64output%" == "" set base64output=con

certutil -decode "%1" %base64output%>nul
echo [Done] ► %1 has been decoded and %base64output% has been created
exit /b

:usage
cls
echo [Usage] ► decodeBase64 (file) [output_file]
exit /b