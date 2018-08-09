@echo off
rem Note: if this code fails to execute or asks for a login name and password
rem you need to modify your source safe ini file to point to the source safe
rem database on the network, rather than your local machine. To do this,
rem modify C:\Program Files\Microsoft Visual Studio\Common\VSS\srcsafe.ini
rem Data_Path = \\wt-source\Visual Source Safe\data
rem Temp_Path = \\wt-source\Visual Source Safe\temp
rem Users_Path = \\wt-source\Visual Source Safe\users
rem Users_Txt = \\wt-source\Visual Source Safe\users.txt

REM ----- set source safe path
SET pgm="C:\Program Files\Microsoft Visual Studio\Common\VSS\win32\ss.exe"

REM ----- set source logon
SET logon=Install

rem stop Norton AntiVirus Auto-Protect
rem ----------------------------------
rem net stop "NAV Auto-Protect" /y

REM ----- system object
:system
CALL InstallPgm DLL WinTech  WinTech  wtSystem

REM ----- logical data components
:logdata
CALL InstallPgm DLL WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logData

REM ----- logical business components
:logbusn
CALL InstallPgm DLL WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logBusn
CALL InstallPgm DLL WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logBusn
CALL InstallPgm DLL WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logBusn
CALL InstallPgm DLL WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_logBusn
CALL InstallPgm DLL WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logBusn

REM ----- logical user components
:loguser
CALL InstallPgm DLL WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logUser
CALL InstallPgm DLL WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logUser
CALL InstallPgm DLL WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_logUser
CALL InstallPgm DLL WinTech\ILingual\wtiBusiness  WinTech/ILingual/wtiBusiness  wtiBusn_logUser
CALL InstallPgm DLL WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logUser

REM ----- physical data components
:phydata
REM CALL InstallPgm DLL WinTech\ILingual\wtiData  WinTech/ILingual/wtiData  wtiData_phyData

REM ----- physical business components
:phybusn
CALL InstallPgm DLL WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_phyBusn

REM ----- physical user components
:phyuser
CALL InstallPgm DLL WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_phyUser

REM ----- applications
:appl
CALL InstallPgm DLL WinTech\ILingual\wtiApplication  WinTech/ILingual/wtiApplication  wtiAppl_logBusn
CALL InstallPgm DLL WinTech\ILingual\wtiApplication  WinTech/ILingual/wtiApplication  wtiAppl_logUser
CALL InstallPgm EXE WinTech\ILingual  WinTech/ILingual  wtiLingual

REM ----- production components
:prod
CALL InstallPgm DLL WinTech\ILingual  WinTech/ILingual  wtiWeb

:installend
rem start Norton AntiVirus Auto-Protect
rem ----------------------------------
rem net start "NAV Auto-Protect" /y

SET pgm=
echo .................... end of script ....................  
pause
