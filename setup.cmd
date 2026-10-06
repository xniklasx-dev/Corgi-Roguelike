@echo off

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\setup.ps1"

if errorlevel 1 (
    echo.
    echo Setup failed.
    pause
    exit /b 1
)

echo.
echo Setup completed successfully.
pause
