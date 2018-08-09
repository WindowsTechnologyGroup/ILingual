@echo off

IF "%1"=="" GOTO error
SET path=%1
IF "%2"=="" GOTO error
SET entity=%2


If Not Exist %path%\%entity% MD %path%\%entity%
If Not Exist %path%\%entity%\%entity%Busn MD %path%\%entity%\%entity%Busn
If Not Exist %path%\%entity%\%entity%Data MD %path%\%entity%\%entity%Data
If Not Exist %path%\%entity%\%entity%User MD %path%\%entity%\%entity%User
If Not Exist %path%\%entity%\%entity%Web MD %path%\%entity%\%entity%Web
GOTO end

:error
echo Use SetupApp.bat "Application Folder" "Entity Name"
pause

:end
set path=

