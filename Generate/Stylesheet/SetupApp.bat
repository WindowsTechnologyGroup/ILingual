rem @echo off

IF "%1"=="" GOTO error
SET ipath=%1
IF "%2"=="" GOTO error
SET path=%2

copy %ipath%\Setup\*.* %path%

If Not Exist %path%\Common MD %path%\Common
copy %ipath%\Setup\Common\*.* %path%\Common

If Not Exist %path%\SQL MD %path%\SQL
copy %ipath%\Setup\SQL\*.* %path%\SQL
If Not Exist %path%\SQL\Functions MD %path%\SQL\Functions
copy %ipath%\Setup\SQL\Functions\*.* %path%\SQL\Functions
If Not Exist %path%\SQL\Procedures MD %path%\SQL\Procedures
copy %ipath%\Setup\SQL\Procedures\*.* %path%\SQL\Procedures
If Not Exist %path%\SQL\Scripts MD %path%\SQL\Scripts
copy %ipath%\Setup\SQL\Scripts\*.* %path%\SQL\Scripts
If Not Exist %path%\SQL\Tables MD %path%\SQL\Tables
copy %ipath%\Setup\SQL\Tables\*.* %path%\SQL\Tables

If Not Exist %path%\VB MD %path%\VB
copy %ipath%\Setup\VB\*.* %path%\VB

If Not Exist %path%\Web MD %path%\Web
copy %ipath%\Setup\Web\*.* %path%\Web
If Not Exist %path%\Web\Images MD %path%\Web\Images
copy %ipath%\Setup\Web\Images\*.* %path%\Web\Images
If Not Exist %path%\Web\Include MD %path%\Web\Include
copy %ipath%\Setup\Web\Include\*.* %path%\Web\Include

GOTO end

:error
echo Use SetupApp.bat "ILingual Generate Folder" "Application Folder"
pause

:end
set path=

