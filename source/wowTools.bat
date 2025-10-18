@echo off
REM Load config.txt from the same folder as the script
for /f "usebackq tokens=1,* delims==" %%A in ("%~dp0config.txt") do (
    set "%%A=%%B"
)
if /i "%CONFIGURED%"=="Y" (
    rem Do nothing
) else (
    echo.
    echo !! You have attempted to run WoW Tool while unconfigured! Please follow this setup before trying to open it again !!
    setup.bat
)

color A
:::                         __              __    
:::  _      ______ _      __/ /_____  ____  / /____
::: | | /| / / __ \ | /| / / __/ __ \/ __ \/ / ___/ 
::: | |/ |/ / /_/ / |/ |/ / /_/ /_/ / /_/ / (__  ) 
::: |__/|__/\____/|__/|__/\__/\____/\____/_/____/  
::: -----------------------------------------------

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A  
echo. WOTLK server management made easy - Version %VERSION%
echo. Created by Lisoft Software Solutions 
echo.
echo Please select an option from the list below!   
echo.
echo. (1) Start game server
echo. (2) Stop Server
echo. (3) Start SQL Database   
echo. (4) Start Apache Server
echo. (5) Start SQL and Apache
echo. (6) Open Warcraft Client
echo. (7) Release Notes
echo. (8) Exit
echo.    
choice /c:123456789 /M "Select option :" /N
set _choice=%errorlevel%
if %_choice% == 1 goto opone
if %_choice% == 2 goto optwo
if %_choice% == 3 goto opthree
if %_choice% == 4 goto opfour
if %_choice% == 5 goto opfive
if %_choice% == 6 goto opsix
if %_choice% == 7 goto opseven
if %_choice% == 8 goto opeight

:: Option one
:: Start SQL, authserver and worldserver 
:opone
echo. 
cls 
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 
echo.
echo. (1) Starting game server
echo. 
echo. Starting game server... Please wait for a notification
echo.
cd %SERVERDIR%
cd "_Server"
echo. [INFO] Starting SQL Server
start "" mysql\bin\mysqld --defaults-file=mysql\bin\my.cnf  
echo. [LOG] SQL Server Started Successfully!
cd %SERVERDIR%
cd Core
echo.
echo. [INFO] Starting Authentication Server
start authserver.exe
echo. [LOG] Authentication Server Started Successfully!
echo. 
echo. [INFO] Starting Game Server
start worldserver.exe
echo. [LOG] Game Server Started Successfully
timeout /t 20 /nobreak
cd %~dp0
:alert1
cscript //nologo "%~dp0alert1.vbs" "%CLIENTDIR%"
cls
"WoW Tools.bat"

:: Option two
:: Killing tasks for SQL, authserver and worldserver
:optwo
echo. 
echo. (2) Stopping Server
echo. 
echo. [INFO] Closing Authentication Server
taskkill /F /IM authserver.exe /T  
echo. [LOG] Authentication Server Successfully Closed!
echo.
echo. [INFO] Closing Game Server
taskkill /F /IM worldserver.exe /T
echo. [LOG] Game Server Successfully Closed!
echo.
echo. [INFO] Closing SQL Server   
taskkill /F /IM mysqld.exe /T  
echo. [LOG] SQL Server Successfully Closed! 
echo. 
echo. Server has been shutdown!
cd "%~dp0"
timeout /t 5 /nobreak
cls
"WoW Tools.bat"

:: Option three
:: Starts MySQL.bat // SQL Server
:opthree
echo.
echo. (3) Starting SQL Database
cd %SERVERDIR%
cd "_Server"
start MySQL.bat
echo.
echo. [LOG] SQL Database has started successfully
cd /d "%~dp0"
cls
"WoW Tools.bat"

:: Option four
:: Starts Apache.bat // Web server
:opfour
echo.
echo. (4) Starting Apache Server
cd %SERVERDIR%"
cd "_Server"
start Apache.bat
echo.
echo. [LOG] Apache Server has started successfully. View the web interface on 127.0.0.1
cd /d "%~dp0"
cls
"WoW Tools.bat"

:: Option five
:: Starts MySQL.bat + Apache.bat // SQL Database and Web server
:opfive
echo.
echo. (5) Starting SQL Database and Apache Server
cd /d "%WOW%"
cd "_Server"
start Apache.bat
start MySQL.bat
echo.
echo. Successfully started Apache Server and SQL Database!
cd /d "%~dp0"
cls
"WoW Tools.bat"

:: Option six
:: Starts the game client - !! This is being teprimental at the moment !!
:opsix
echo. 
echo. (6) Starting the wowlk client
cd %CLIENTDIR%
%CLIENTMOUNTPATH%
start Wow.exe
echo.
echo. Started wowlk client!
cd /d "%~dp0"
cls
timeout /t 3 /nobreak>nul
"WoW Tools.bat"

:: Option seven
:: Prints the release notes in the terminal
:: Relies on releasenotes.txt
:opseven
cls
cd "%~dp0\.."
type "releasenotes.txt"
pause
cd %~dp0
cls
"WoW Tools.bat"

echo.

:: Option nine
:: Closes wowTools
:opnine
