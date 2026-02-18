@echo off
title Win7Games Installer

:: ============================
:: ADMIN CHECK
:: ============================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo The Win7Games installer could not continue because it was NOT run as Administrator.
    echo.
    echo Please right-click this file and choose "Run as administrator".
    pause
    exit /b
)

:: ============================
:: SAFETY WARNING
:: ============================
cls
echo Are You Sure You Want To Do This?
echo THE OWNER IS NOT RESPONSIBLE FOR ANY DAMAGES!
echo.
set /p confirm=Type YES to continue: 
if /I not "%confirm%"=="YES" (
    echo Cancelled.
    pause
    exit /b
)

:: ============================
:: PING TEST
:: ============================
echo.
echo Pinging google.com...
ping google.com -n 1 >nul 2>&1

if %errorlevel% neq 0 (
    echo ERROR: No internet connection detected.
    echo Please reconnect and try again.
    pause
    exit /b
)

echo Internet OK!
echo.

:: ============================
:: INSTALL PROCESS
:: ============================
echo Installing...
echo DO NOT DISCONNECT FROM ETHERNET OR WIFI OR SHUT DOWN YOUR SYSTEM.
echo.

:: Create install directory
set "INSTALLDIR=%ProgramFiles%\Win7Games"
if not exist "%INSTALLDIR%" mkdir "%INSTALLDIR%"

:: ============================
:: DOWNLOAD (URL placeholder)
:: ============================
set "DOWNLOAD_URL=https://dn710008.ca.archive.org/0/items/windows7games-for-windows-11-10-8/Windows7Games_for_Windows_11_10_8.zip"
set "ZIPFILE=%temp%\win7games.zip"

echo Downloading from: %DOWNLOAD_URL%
echo.

:: NOTE: This uses PowerShell for safe downloading
powershell -command "(New-Object Net.WebClient).DownloadFile('%DOWNLOAD_URL%', '%ZIPFILE%')" 2>nul

if not exist "%ZIPFILE%" (
    echo ERROR: Download failed.
    echo Check the URL or your connection.
    pause
    exit /b
)

echo Download complete!
echo.

:: ============================
:: UNZIP IF NEEDED
:: ============================
echo Unzipping...
powershell -command "Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%INSTALLDIR%' -Force" 2>nul

if %errorlevel% neq 0 (
    echo ERROR: Could not unzip the file.
    echo Please unzip manually:
    echo %ZIPFILE%
    pause
    exit /b
)

echo Unzip complete!
echo.

:: ============================
:: FINISH
:: ============================
echo Downloaded!
echo Please run the installer file located in:
echo %INSTALLDIR%
echo.
pause
exit /b