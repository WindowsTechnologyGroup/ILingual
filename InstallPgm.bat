@echo off

IF "%1"=="" GOTO error
SET type=""
IF %1==EXE SET type=EXE
IF %1==DLL SET type=DLL
IF %type%=="" GOTO error

IF "%2"=="" GOTO error
SET filepath=%2

IF "%3"=="" GOTO error
SET projpath=%3

IF "%4"=="" GOTO error
SET name=%4

REM ----- set the source safe path
SET ipgm="C:\Program Files\Microsoft Visual Studio\Common\VSS\win32\ss.exe"

REM ----- set source logon
SET logon=Install

REM ----- set the windows system directory
IF EXIST C:\Windows\System\Nul Set WindowsDir=C:\Windows\System
IF EXIST C:\Win95\System\Nul Set WindowsDir=C:\Win95\System
IF EXIST C:\WinNT\System32\Nul Set WindowsDir=C:\WinNT\System32

ECHO Installing %name% ....

REM ----- set the installation folder and create it if it doesn't exist
SET fold=D:\%filepath%\%name%
IF NOT EXIST %fold% MD %fold%

IF %type%==EXE GOTO getsource

:unregister
REM ----- unregister old dlls
%WindowsDir%\regsvr32 /u /s %fold%\%name%.dll

:getsource
REM ----- get executable source only for production
%ipgm% get $/%projpath%/%name%/*.* -O- -Y%logon% -GWR -GL%fold%

IF %type%==EXE GOTO end

:register
REM ----- register new dlls
%WindowsDir%\regsvr32 /s %fold%\%name%.dll

GOTO end

:error
echo Use INSTALLPGM.BAT -fp -pp -n
echo -fp = project path (appended to D:\)
echo -pp = project path (appended to $\)
echo -n = project name
echo ex: INSTALLPGM.BAT WinTech\ILingual\wtiUser  WinTech/ILingual/wtUser  wtiUser_logBusn
pause

:end

set env=
set type=
set projpath=
set filepath=
set name=
set site=
set ipgm=
set fold=
