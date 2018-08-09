@echo off

IF "%1"=="" GOTO error
SET type=""
IF %1==J SET type=Jobs
IF %1==C SET type=Components
IF %1==W SET type=Web
IF %1==A SET type=Application
IF %type%=="" GOTO error

IF "%2"=="" GOTO error
SET filepath=%2

IF "%3"=="" GOTO error
SET projpath=%3

IF "%4"=="" GOTO error
SET name=%4

SET vb="C:\Program Files\Microsoft Visual Studio\vb98\vb6.exe"
SET pgm="C:\Program Files\Microsoft Visual Studio\Common\VSS\win32\ss.exe"

If Not Exist D:\%filepath%\%name% MD D:\%file\%name%
%pgm% get $/%projpath%/%name%/*.* -O- -GWR -GLD:\%filepath%\%name%
%pgm% checkout $/%projpath%/%name%/*.* -O- -GWR -GLD:\%filepath%\%name%

echo compiling %name% ...

IF %type%==Application GOTO makeexe

:makedll
%vb% /makedll D:\%filepath%\%name%\%name%.vbp
GOTO checkin

:makeexe
%vb% /make D:\%filepath%\%name%\%name%.vbp
GOTO checkin

:checkin
%pgm% checkin $/%projpath%/%name%/*.* -CDaily -O- -GWR -GLD:\%filepath%\%name%
GOTO end

:error
echo Use COMPILEPGM.BAT -t -fp -pp -n
echo -t = (J)obs, (C)omponents, (W)eb, or (A)pplication
echo -fp = project path (appended to D:\)
echo -pp = project path (appended to $\)
echo -n = project name
echo ex: COMPILEPGM.BAT C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logBusn
pause

:end
set pgm=
set type=
set name=
set filepath=
set projpath=
set vb=

