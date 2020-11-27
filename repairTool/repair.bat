cls
@echo off
chcp 65001>nul
title Check if you have admin right

net session >nul 2>&1
if %errorlevel% == 0 (
    goto main
) else (
    goto errorAdmin
)

:main
cls
color c 
title WARNING !
echo                                                Are you sure you want to run this program? 
echo                                    If yes then please be aware that hardware/software damage may occur. 
echo                                  The author of this script (ex_ode or Ex0D) absolves himself of any responsibility 
echo                                             although it is very unlikely that this will happen.
echo.
echo.
set /p choice="Type y in if you understand the charges > "
if %choice%==Y goto startRepair
if %choice%==y goto startRepair
goto noOption

:startRepair
cls
color f 
title Advert !
echo While the program is running , do not close the window !
echo.
echo Press any key to start
pause>nul
title Program running ... Do not close this window !
:: SFC part ► Scans the integrity of all protected system files and repair the damaged files
cls
sfc /scannow
timeout /t 1 /nobreak>nul

:: CHKDSK part ► Checks and corrects errors on the disk
cls
chkdsk /F /R
timeout /t 1 /nobreak>nul

:: NETSH / IPCONFIG part ► Reset all network interfaces
cls
netsh int ip reset
netsh winsock reset
ipconfig /flushdns
ipconfig /release
timeout /t 1 /nobreak>nul
ipconfig /renew
timeout /t 2 /nobreak>nul
cls
title Done !
echo The program completed these commands perfectly !
echo.
echo Will close in 5 seconds...
timeout /t 5>nul
exit /b

:errorAdmin
cls
title Failure !
color c
echo Failure : Current permission inadequate , please run this program with admin right !
pause>nul 
exit /b

:noOption
exit /b