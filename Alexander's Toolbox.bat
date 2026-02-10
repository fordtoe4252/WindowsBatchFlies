@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Oops, Sorry! You must run this tool as Administrator!
    pause
    exit /b
)

:menu
cls
echo ================================
echo       ALEXANDER'S TOOLBOX
echo ================================
echo.
echo 1. Open System Information
echo 2. Open Device Manager
echo 3. Open Programs and Features
echo 4. Clear Temp Files
echo 5. Open Windows Update
echo 6. Open Task Manager
echo 7. Restart Explorer
echo 8. Exit
echo.
set /p choice=Choose an option: 

if "%choice%"=="1" goto sysinfo
if "%choice%"=="2" goto devmgr
if "%choice%"=="3" goto programs
if "%choice%"=="4" goto cleartemp
if "%choice%"=="5" goto winupdate
if "%choice%"=="6" goto taskmgr
if "%choice%"=="7" goto restartexplorer
if "%choice%"=="8" exit /b
goto menu

:sysinfo
start msinfo32
goto menu

:devmgr
start devmgmt.msc
goto menu

:programs
start appwiz.cpl
goto menu

:cleartemp
echo Clearing temp files...
del /q /f %temp%\* >nul 2>&1
echo Done!
pause
goto menu

:winupdate
start ms-settings:windowsupdate
goto menu

:taskmgr
start taskmgr
goto menu

:restartexplorer
echo Restarting Explorer...
taskkill /f /im explorer.exe
start explorer.exe
goto menu
