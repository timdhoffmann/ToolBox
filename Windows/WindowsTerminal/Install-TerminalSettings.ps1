[string] $SourceSettingsPath = "$PSScriptRoot\settings.json"
if (-not (Test-Path $SourceSettingsPath))
{
    Write-Output "No settings file found at $SourceSettingsPath."
    return
}

[string] $DestinationFolderPath = "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if( (Test-Path $DestinationFolderPath)) {
    Copy-Item -Path $SourceSettingsPath -Destination $DestinationFolderPath
    Write-Output "Copied settings to $DestinationFolderPath."
}

