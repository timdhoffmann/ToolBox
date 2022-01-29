[string] $ProfileFileName = "Microsoft.PowerShell_profile.ps1"
[string] $CustomProfilePath = "$PSScriptRoot\$ProfileFileName"
if (-not (Test-Path $CustomProfilePath))
{
    Write-Output "Could not find custom profile at '$CustomProfilePath'."
    return
}
# if (-not (Test-Path $ProfileDirectoryPath)) {
#     Write-Output "Creating PowerShell profile folder at '$ProfileDirectoryPath'."
#     New-Item -ItemType "Directory" -Path "$env:USERPROFILE\Documents\" -Name "PowerShell"
# }
[string] $destinationFolderPath = $profile | Split-Path
# Default PowerShell profile file path.
$destinationFilePath = "$destinationFolderPath\$ProfileFileName"
Copy-Item -Path $CustomProfilePath -Destination $destinationFilePath
Write-Output "Copied custom profile to '$destinationFilePath'."

if (-not ($profile -eq $destinationFilePath))
{
    Copy-Item -Path $CustomProfilePath -Destination $profile
    Write-Output "Additionaly copied to custom profile path: '$profile'."    

}
