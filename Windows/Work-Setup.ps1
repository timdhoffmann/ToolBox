<#
    Sets up apps and services for working.
#>

# Outlook
Start-Process -FilePath "olk"

Start-Process -FilePath "firefox"
Start-Process -FilePath "C:\Program Files\Parsec\Parsecd.exe"
Start-Process -FilePath "C:\Program Files\WindowsApps\Microsoft.Todos_2.114.7122.0_x64__8wekyb3d8bbwe\Todo.exe"

# These currently prevent the calling batch file window from closing.
# start-process -FilePath "Obsidian" -WorkingDirectory "$env:LOCALAPPDATA\Obsidian"
# Start-Job -ScriptBlock { & "slack" >$null 2>$null }

# Connects to a VPN connection where 'Connection name' in 'Network & internet' settings
# matches the provided string.
# rasdial "yager vpn"

