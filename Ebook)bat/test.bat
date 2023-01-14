@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------
:frist
cls
color 2
echo ---------------------------------------
echo {  CHOOSE THE OPERATATION TO PERFORM    }
echo ---------------------------------------
echo .                                    .
echo CLOSE CHROME   --    Enter (C or 1)
echo CLOSE NOTEPAD  --    Enter (N or 2)
echo FLUSH DNS      --    Enter (F or 3)
echo PING NETWORK   --    Enter (P or 4)
echo DISK CLEAN     --    Enter (D or 5)
echo .                                    .
echo              Quit == Q
echo .                                    .

CHOICE /C CNFPD /M "Choose An Option"
if %errorlevel%==1 goto chr
if %errorlevel%==2 goto ntp
if %errorlevel%==3 goto png
if %errorlevel%==4 goto ntr
if %errorlevel%==5 goto dsk
if %errorlevel%==6 goto chr
if %errorlevel%==7 goto ntp
if %errorlevel%==8 goto png
if %errorlevel%==9 goto ntr
if %errorlevel%==10 goto dsk
if %errorlevel%==11 goto end

:chr
cls
taskkill /F /IM chrome* /T
goto frist

:ntp
cls
taskkill /IM notepad.exe /F
goto frist

:ntr
ipconfig/flushDNS
goto frist

:png
cls 
color a
ping google.com

:dsk
Chkdsk D:
Chkdsk E:
Chkdsk c:
goto frist
