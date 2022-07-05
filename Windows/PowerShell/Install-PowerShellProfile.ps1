<#
    Installs the custom PowerShell profile at the default profile location.
    This might need to run from an elevated shell.
#>

[string] $ProfileFileName = "Microsoft.PowerShell_profile.ps1"
[string] $CustomProfilePath = "$PSScriptRoot\$ProfileFileName"
if (-not (Test-Path $CustomProfilePath))
{
    Write-Output "Could not find custom profile at '$CustomProfilePath'."
    return
}

$defaultProfileDirectoryPath = "$env:USERPROFILE\Documents\PowerShell\"
if (-not (Test-Path $defaultProfileDirectoryPath)) {
    Write-Output "Creating PowerShell profile folder at '$defaultProfileDirectoryPath'."
    New-Item -ItemType "Directory" -Path "$env:USERPROFILE\Documents\" -Name "PowerShell"
}

[string] $defaultProfileDirectoryPath = $profile | Split-Path
$defaultProfileFilePath = "$defaultProfileDirectoryPath\$ProfileFileName"
Copy-Item -Path $CustomProfilePath -Destination $defaultProfileFilePath
Write-Output "Copied custom profile to '$defaultProfileFilePath'."

if (-not ($profile -eq $defaultProfileFilePath))
{
    Copy-Item -Path $CustomProfilePath -Destination $profile
    Write-Output "Additionaly copied to custom profile path: '$profile'."    

}