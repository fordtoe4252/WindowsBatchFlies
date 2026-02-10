@echo off
title Alexander's Device & Network Toolbox

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Oops, Sorry! You must run this tool as Administrator!
    pause
    exit /b
)

:menu
cls
echo ==========================================
echo     ALEXANDER'S DEVICE & NETWORK TOOLBOX
echo ==========================================
echo.
echo 1. Show Device Information
echo 2. Show Logged-In User Info
echo 3. Test Internet Connection (Ping)
echo 4. Show Network & IP Info
echo 5. Show Disk Information
echo 6. Show System Uptime
echo 7. Exit
echo.
set /p choice=Choose an option: 

if "%choice%"=="1" goto deviceinfo
if "%choice%"=="2" goto userinfo
if "%choice%"=="3" goto pingtest
if "%choice%"=="4" goto netinfo
if "%choice%"=="5" goto diskinfo
if "%choice%"=="6" goto uptime
if "%choice%"=="7" exit /b
goto menu

:deviceinfo
cls
echo ============================
echo       DEVICE INFORMATION
echo ============================
echo.
echo CPU:
wmic cpu get Name
echo ----------------------------
echo GPU:
wmic path win32_VideoController get Name
echo ----------------------------
echo RAM:
wmic memorychip get capacity
echo ----------------------------
echo Windows Version:
ver
echo ----------------------------
echo System Model:
wmic computersystem get model
echo.
pause
goto menu

:userinfo
cls
echo ============================
echo       USER INFORMATION
echo ============================
echo.
echo Username: %USERNAME%
echo Computer Name: %COMPUTERNAME%
echo User Profile Path: %USERPROFILE%
echo.
echo Account Type:
whoami /groups | find "S-1-5-32-544" >nul && echo Administrator || echo Standard User
echo.
pause
goto menu

:pingtest
cls
echo ============================
echo     INTERNET PING TEST
echo ============================
echo.
echo Pinging Google DNS (8.8.8.8)...
echo.
ping 8.8.8.8
echo.
pause
goto menu

:netinfo
cls
echo ============================
echo     NETWORK INFORMATION
echo ============================
echo.
ipconfig /all
echo.
pause
goto menu

:diskinfo
cls
echo ============================
echo       DISK INFORMATION
echo ============================
echo.
wmic logicaldisk get name,freespace,size,filesystem
echo.
pause
goto menu

:uptime
cls
echo ============================
echo        SYSTEM UPTIME
echo ============================
echo.
net statistics workstation | find "Statistics since"
echo.
pause
goto menu
