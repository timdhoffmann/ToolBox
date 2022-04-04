<#
    Switches the Windows system theme between light and dark modes. App theme follows.
#>

function Get-IsSystemUsingLightTheme
{
    return Get-ItemPropertyValue -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme
}

function Set-SystemTheme
{
    $isSystemUsingLightTheme = if (Get-IsSystemUsingLightTheme) { 0 } else { 1 }

    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value $isSystemUsingLightTheme -Type Dword -Force 
}

function Set-AppTheme
{
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value $(Get-IsSystemUsingLightTheme) -Type Dword -Force
}

Set-SystemTheme
Set-AppTheme