@echo off
rem Note: if this code fails to execute or asks for a login name and password
rem you need to modify your source safe ini file to point to the source safe
rem database on the network, rather than your local machine. To do this,
rem modify C:\Program Files\Microsoft\Visual Studio\Common\VSS\srcsafe.ini
rem Data_Path = \\WinTech-Svr3\vss\data
rem Temp_Path = \\\WinTech-Svr3\vss\temp
rem Users_Path = \\\WinTech-Svr3\vss\users
rem Users_Txt = \\\WinTech-Svr3\vss\users.txt

rem stop Norton AntiVirus Auto-Protect
rem ----------------------------------
rem net stop "NAV Auto-Protect" /y

REM ----- starting menu choice
REM echo .................... compile menu ....................  
REM echo 1.  System Components
REM echo 2.  Logical Business Components
REM echo 3.  Logical User Components
REM echo 4.  Physical Business Components
REM echo 5.  Physical User Components
REM echo 6.  Application Components
REM echo 7.  Production Components
REM choice /c:1234567  /n  /t:1,30
REM if errorlevel 7 GOTO prod
REM if errorlevel 6 GOTO appl
REM if errorlevel 5 GOTO phyuser
REM if errorlevel 4 GOTO pybusn
REM if errorlevel 3 GOTO loguser
REM if errorlevel 2 GOTO logbusn
REM if errorlevel 1 GOTO system

REM ----- system object
:system
CALL CompilePgm.bat C WinTech  WinTech  wtSystem

REM ----- logical data components
:logdata
CALL CompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logData

REM ----- logical business components
:logbusn
CALL CompilePgm.bat C WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logBusn

REM ----- logical user components
:loguser
CALL CompilePgm.bat C WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logUser

REM ----- physical data components
:phydata
REM CALL CompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyData

REM ----- physical business components
:phybusn
REM CALL CompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyBusn
REM CALL CompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_phyBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_phyBusn

REM ----- physical user components
:phyuser
REM CALL CompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyUser
REM CALL CompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_phyUser
CALL CompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_phyUser

REM ----- applications
:appl
CALL CompilePgm.bat C WinTech\ILingual\wtiApplication  WinTech/ILingual/wtiApplication  wtiAppl_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiApplication  WinTech/ILingual/wtiApplication  wtiAppl_logUser
CALL CompilePgm.bat A WinTech\ILingual  WinTech/ILingual  wtiLingual

REM ----- production components
:prod
CALL CompilePgm.bat C WinTech\ILingual  WinTech/ILingual  wtiWeb

rem start Norton AntiVirus Auto-Protect
rem ----------------------------------
rem net start "NAV Auto-Protect" /y

:end
echo .................... end of script ....................  
pause
