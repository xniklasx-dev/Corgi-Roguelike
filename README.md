# MIGHTYCorgi

## Team Members

- Andreas
- Kilian
- Niklas
- Tony

## Description

A CORGI that becomes more powerful and MIGHTY!
Each round you'll defeat enemies, faint, and then return more powerful than ever before!

# Development Setup

## Requirements

Install:

- Git
- Python 3.14
- Node.js 24+
- VS Code (recommended)

## First-time setup

Clone the repository:

```powershell
git clone https://github.com/xniklasx-dev/MIGHTYCorgi.git
cd MIGHTYCorgi
```

(Or use GitHub Desktop)

Run the setup script:

```powershell
.\setup.cmd
```

This automatically:

- creates the Python virtual environment
- installs backend dependencies
- applies database migrations
- creates the local SQLite database
- installs frontend dependencies

## Start development

### VS Code setup (One-Time)

```powershell
Ctrl + Shift + P
→ Preferences: Open Keyboard Shortcuts (JSON)
```

There, add:

```json
{
  "key": "ctrl+alt+d",
  "command": "workbench.action.tasks.runTask",
  "args": "MIGHTYCorgi: Dev"
}
```

### Start Frontend and Backend

```powershell
Ctrl + Alt + D
```

### Frontend:

http://localhost:4200

### Backend:

http://localhost:8000

### API documentation:

http://localhost:8000/docs
