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

REM ----- system object
:system
CALL LocalCompilePgm.bat C WinTech  WinTech  wtSystem

REM ----- logical data components
:logdata
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logData

REM ----- logical business components
:logbusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logBusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logBusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logBusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_logBusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logBusn

REM ----- logical user components
:loguser
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logUser
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logUser
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logUser
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_logUser
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logUser

REM ----- physical data components
:phydata
REM CALL LocalCompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyData

REM ----- physical business components
:phybusn
REM CALL LocalCompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyBusn
REM CALL LocalCompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_phyBusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_phyBusn

REM ----- physical user components
:phyuser
REM CALL LocalCompilePgm.bat C WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyUser
REM CALL LocalCompilePgm.bat C WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_phyUser
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_phyUser

REM ----- applications
:appl
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiApplication  WinTech/ILingual/wtiApplication  wtiAppl_logBusn
CALL LocalCompilePgm.bat C WinTech\ILingual\wtiApplication  WinTech/ILingual/wtiApplication  wtiAppl_logUser
CALL LocalCompilePgm.bat A WinTech\ILingual  WinTech/ILingual  wtiLingual

REM -----production components
:prod
CALL LocalCompilePgm.bat C WinTech\ILingual  WinTech/ILingual  wtiWeb

rem start Norton AntiVirus Auto-Protect
rem ----------------------------------
rem net start "NAV Auto-Protect" /y

:end
echo .................... end of script ....................  
pause
