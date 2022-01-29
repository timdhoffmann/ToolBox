[string] $FontsToInstallPath = ".\FontsToInstall\"
if (-not (Test-Path $FontsToInstallPath))
{
    [string] $FontsToInstallDirectory = New-Item -ItemType Directory $FontsToInstallPath
}

[string] $Caskaydia = "Caskaydia%20Cove%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.otf"
if (-not (Test-Path "$FontsToInstallPath\$Caskaydia")) 
{
    Write-Output "Downloading fonts..."
    Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.otf" -OutFile "$FontsToInstallDirectory\$Caskaydia"
}

Write-Output "Installing fonts..."
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in Get-ChildItem $FontsToInstallDirectory *.otf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        Write-Output $fileName
        Get-ChildItem $file | ForEach-Object { $fonts.CopyHere($_.fullname) }
    }
}
Copy-Item *.otf c:\windows\fonts\