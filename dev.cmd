@echo off

set ROOT=%~dp0

if not exist "%ROOT%backend\.venv\Scripts\python.exe" (
    echo.
    echo ERROR: Backend environment does not exist.
    echo Run setup.cmd first.
    echo.
    pause
    exit /b 1
)

if not exist "%ROOT%frontend\node_modules" (
    echo.
    echo ERROR: Frontend dependencies do not exist.
    echo Run setup.cmd first.
    echo.
    pause
    exit /b 1
)

echo Starting MIGHTYCorgi development environment...

start "MIGHTYCorgi Backend" cmd /k ^
    "cd /d "%ROOT%backend" && .venv\Scripts\python.exe -m uvicorn app.main:app --reload"

start "MIGHTYCorgi Frontend" cmd /k ^
    "cd /d "%ROOT%frontend" && npm start"
