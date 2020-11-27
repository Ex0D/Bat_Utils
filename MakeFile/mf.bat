@echo off
if "%1"=="" goto:usage
set file=%1
copy /y nul %file%>nul
echo %file% has been created in this folder
exit /b

:usage
cls
echo [Usage] ► mf script.extension
exit /b