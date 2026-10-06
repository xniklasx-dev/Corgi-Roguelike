$ErrorActionPreference = "Stop"

$RootDirectory = Split-Path -Parent $PSScriptRoot
$BackendDirectory = Join-Path $RootDirectory "backend"
$FrontendDirectory = Join-Path $RootDirectory "frontend"

$VenvDirectory = Join-Path $BackendDirectory ".venv"
$VenvPython = Join-Path $VenvDirectory "Scripts\python.exe"


function Write-Step {
    param (
        [string]$Message
    )

    Write-Host ""
    Write-Host "=================================================="
    Write-Host $Message
    Write-Host "=================================================="
}


Write-Step "Checking prerequisites"


# --------------------------------------------------
# Check Python 3.14
# --------------------------------------------------

try {
    $PythonVersion = py -3.14 --version 2>&1
    Write-Host "Found: $PythonVersion"
}
catch {
    Write-Host ""
    Write-Host "ERROR: Python 3.14 was not found."
    Write-Host "Install Python 3.14 and make sure the Python launcher 'py' is available."
    exit 1
}


# --------------------------------------------------
# Check Node.js
# --------------------------------------------------

try {
    $NodeVersion = node --version 2>&1
    Write-Host "Found Node.js: $NodeVersion"
}
catch {
    Write-Host ""
    Write-Host "ERROR: Node.js was not found."
    Write-Host "Install Node.js 24 LTS."
    exit 1
}


# --------------------------------------------------
# Check npm
# --------------------------------------------------

try {
    $NpmVersion = npm --version 2>&1
    Write-Host "Found npm: $NpmVersion"
}
catch {
    Write-Host ""
    Write-Host "ERROR: npm was not found."
    Write-Host "Install Node.js 24 LTS, which includes npm."
    exit 1
}


# --------------------------------------------------
# Create Python virtual environment
# --------------------------------------------------

Write-Step "Setting up Python virtual environment"

if (-not (Test-Path $VenvPython)) {
    Write-Host "Creating .venv..."

    Push-Location $BackendDirectory

    try {
        py -3.14 -m venv .venv
    }
    finally {
        Pop-Location
    }
}
else {
    Write-Host ".venv already exists. Reusing it."
}


# --------------------------------------------------
# Upgrade pip
# --------------------------------------------------

Write-Step "Updating pip"

& $VenvPython -m pip install --upgrade pip


# --------------------------------------------------
# Install backend dependencies
# --------------------------------------------------

Write-Step "Installing backend dependencies"

& $VenvPython -m pip install `
    -r (Join-Path $BackendDirectory "requirements.txt")


# --------------------------------------------------
# Apply Alembic migrations
# --------------------------------------------------

Write-Step "Updating SQLite database"

Push-Location $BackendDirectory

try {
    & $VenvPython -m alembic upgrade head
}
finally {
    Pop-Location
}


# --------------------------------------------------
# Install Angular dependencies
# --------------------------------------------------

Write-Step "Installing frontend dependencies"

Push-Location $FrontendDirectory

try {
    npm ci
}
finally {
    Pop-Location
}


# --------------------------------------------------
# Final checks
# --------------------------------------------------

Write-Step "Verifying installation"

& $VenvPython -c "import fastapi, sqlalchemy, alembic; print('Backend dependencies OK')"

Push-Location $BackendDirectory

try {
    & $VenvPython -c "import app.main; print('Backend application OK')"
    & $VenvPython -m alembic current
}
finally {
    Pop-Location
}


Write-Step "MIGHTYCorgi setup complete"

Write-Host ""
Write-Host "Backend environment:"
Write-Host "  backend\.venv"
Write-Host ""
Write-Host "SQLite database:"
Write-Host "  backend\data\mightycorgi.db"
Write-Host ""
Write-Host "Frontend dependencies:"
Write-Host "  frontend\node_modules"
Write-Host ""
Write-Host "You can now start developing."
