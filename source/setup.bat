@echo off
setlocal enabledelayedexpansion
rem --- CONFIG FILE ---
set "configFile=%~dp0config.txt"
set "tempFile=%~dp0config.tmp"

color A

echo. wowTools 5 - Setup Utility
echo.
echo. To setup WoW Tools you will need to specify a few directories to ensure it can interact with your server!
echo. If you are unsure please read the release notes to be guided on how to use this setup!
echo. 
echo. What folder contains your server? (E.G. C:\WoW Server)

rem --- PROMPT FOR NEW VALUES ---
set /p newServerDir=Enter Folder : 
echo. 
echo. What is the drive letter of the drive that has your game client in? (E.G. D:) 
set /p newDRIVE=Enter Letter : 
echo. 
echo. What folder contains your game? (E.G. D:\"WoW Wrath of the Lich King")
set /p newClientDir=Enter Folder : 

rem --- PROCESS FILE ---
> "%tempFile%" (
    for /f "usebackq delims=" %%A in ("%configFile%") do (
        set "line=%%A"
        set "updated=0"

        rem --- Update SERVERDIR ---
        if defined newServerDir if "!line:~0,10!"=="SERVERDIR=" (
            echo SERVERDIR=!newServerDir!
            set "updated=1"
        )

   rem --- Update 22 ---
        if defined newDRIVE if "!line:~0,5!"=="DRIVE=" (
            echo DRIVE=!newDRIVE!
            set "updated=1"
        )

        

        rem --- Update CLIENTDIR ---
        if !updated! equ 0 if defined newClientDir if "!line:~0,10!"=="CLIENTDIR=" (
            echo CLIENTDIR=!newClientDir!
            set "updated=1"
        )

        rem --- Update CONFIGURED ---
        if !updated! equ 0 if "!line:~0,10!"=="CONFIGURED" (
            echo CONFIGURED=Y
            set "updated=1"
        )

        rem --- Leave unchanged if not updated ---
        if !updated! equ 0 echo !line!
    )
)

rem --- REPLACE ORIGINAL FILE ---
move /y "%tempFile%" "%configFile%"
Notification2
exit
