@echo off

rem install
rem Copyright (C) 2015, David C. Merritt, david.c.merritt@siemens.com
rem
rem This program is free software: you can redistribute it and/or modify
rem it under the terms of the GNU General Public License as published by
rem the Free Software Foundation, either version 3 of the License, or
rem (at your option) any later version.
rem
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem GNU General Public License for more details.
rem
rem You should have received a copy of the GNU General Public License
rem along with this program.  If not, see <http://www.gnu.org/licenses/>.
rem
rem ---------------------------------------------------------------------
rem
rem DOS script to install the Solid Edge Beautify Log script
rem
rem ---------------------------------------------------------------------
rem
rem 16/07/2015  merritt  initial release
rem 04/08/2015  merritt  added desktop shortcut
rem

set SOFTWARE_NAME=Solid Edge Beautify Log
title %SOFTWARE_NAME%: Installing...

rem set up some variables 
set SOFTWARE_DIR=%CD%
set INSTALL_DIR=%ProgramFiles%\%SOFTWARE_NAME%
set MENU_DIR=%ProgramData%\Microsoft\Windows\Start Menu\Programs
set DESKTOP_DIR=%Public%\Desktop

rem change to our current dir 
cd %SOFTWARE_DIR%

rem check if our install folders already exist
if exist "%INSTALL_DIR%" goto :ExistsError
if exist "%MENU_DIR%\%SOFTWARE_NAME%" goto :ExistsError

rem everything okay so go to start install
goto :InstallSoftware

rem
rem finally install our software 
rem
:InstallSoftware
cls
echo.
echo     %SOFTWARE_NAME%: Installing...

rem copy everything to our install folder
xcopy "%SOFTWARE_DIR%\*" "%INSTALL_DIR%" /h /e /i /r /y /d 
cls

rem set our powershell execution policy
regedit /s "%SOFTWARE_DIR%\registry\powershell_execution_policy.reg"

rem copy our start menu shortcuts
mkdir "%MENU_DIR%\%SOFTWARE_NAME%" 
ping 127.0.0.1 -n 2 > nul
xcopy "%SOFTWARE_DIR%\start_menu\*" "%MENU_DIR%" /h /e /i /r /y /d 
cls

rem copy our desktop shortcuts
xcopy "%SOFTWARE_DIR%\desktop\*" "%DESKTOP_DIR%" /h /e /i /r /y /d 
cls

rem install our registry shortcuts
regedit /s "%SOFTWARE_DIR%\registry\install_xml_context_menu.reg"
cls

rem install should be complete so open our start menu and then exit
title %SOFTWARE_NAME%: Installed!
echo.
echo     Solid Edge Beautify Log has been installed!
explorer "%MENU_DIR%\%SOFTWARE_NAME%"
goto :CleanExit


rem
rem display error for existing files 
rem
:ExistsError
title %SOFTWARE_NAME%: ERROR!
echo.
echo.
echo     Error: %SOFTWARE_NAME% appears to already be installed!
echo.
echo.    Please remove existing files before attempting to install.
echo.
echo.
echo     Press any key to exit . . .
pause > nul
goto :CleanExit


rem
rem cleanly exit
rem
:CleanExit
set SOFTWARE_NAME=
set SOFTWARE_DIR=
set INSTALL_DIR=
set MENU_DIR=
exit /b