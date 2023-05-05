@echo off
echo [+]Creating directory C:\bgps...
mkdir C:\bgps>nul
cd /d %~dp0
copy .\bgps\bgps.bat C:\bgps\bgps.bat>nul
echo [+]copying files...
timeout /t 2 /NOBREAK>nul
echo [Info] file copied at C:\bgps\

echo [+]adding folder to System PATH...

for %%i in ("%PATH:;=" "%") do (
    if /i "%%~i"=="C:\bgps" (
        echo [Info] Path Already Exist.
        goto END
    )
)
setx /M path "%path%;C:\bgps"

:END
timeout /t 2 /NOBREAK>nul
echo [+]Done.
pause