# ToolBox

A collection of small tools, settings, and scripts.

## Prerequisites

- Install chocolatey via winget.
- Install git for Windows via Chocolatey.
- Install Python via Chocolatey.
- Clone this repository.
- Install Python dependencies

```pwsh
pip install pyyaml
```

## Windows Apps

- Run from an elevated `cmc`, **not** PowerShell, since it can cause trouble with
self-updating, etc.

```cmd
cd <this_repo>\Windows
python install_apps_chocolatey.py [--work] [--private] -y
```

## Windows Scripts

- Create a shortcut to the respective `*.bat` file.
- Move the shortcut to `%appdata%\Microsoft\Windows\Start Menu`.
- Invoke via Start Menu search or PowerToys Run.