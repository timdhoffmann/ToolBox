# Installs New applications.
# Source: https://chrislayers.com/2021/08/01/scripting-winget/.

param (
    [switch]
    $InstallWorkApps,

    [switch]
    $InstallPrivateApps,

    [switch]
    $WhatIf
)

$apps = @(
    # Development.
    @{name = "Microsoft.PowerShell" }
    @{name = "Microsoft.VisualStudioCode" }
    @{name = "Git.Git" }
    # OhMyPosh shell prompt.
    @{name = "JanDeDobbeleer.OhMyPosh" }
    @{name = "Python.Python.3" }
    @{name = "Windows Subsystem for Linux Preview" }
    @{name = "Neovim.Neovim" }
    @{name = "Microsoft.VisualStudio.2022.BuildTools" }
    @{name = "Rustlang.Rustup" }

    # Productivity.
    @{name = "Mozilla.Firefox" }
    @{name = "Google.Chrome" }
    @{name = "Notion.Notion" }
    @{name = "Discord.Discord" }
    @{name = "Microsoft.PowerToys" }
    @{name = "Bitwarden.Bitwarden" }
    @{name = "voidtools.Everything" }

    # Misc.
    @{name = "Valve.Steam" }
    @{name = "EpicGames.EpicGamesLauncher" }
    @{name = "Spotify.Spotify" }
);

$privateOnlyApps = @(
    @{name = "Microsoft.VisualStudio.2022.Community" }
    @{name = "Foxit.FoxitReader" }
    @{name = "Google.Drive" }
    @{name = "Foundry376.Mailspring" }
    @{name = "BraveSoftware.BraveBrowser" }
    @{name = "OpenWhisperSystems.Signal" }
    @{name = "WhatsApp.WhatsApp" }
    @{name = "Twilio.Authy" }
    @{name = "Logitech.GHUB" }
);

$workOnlyApps = @(
    # This will throw an error but it is actually a success that only requires a system restart.
    @{name = "SlackTechnologies.Slack" }
    @{name = "Microsoft.Teams" }
    # Some tools, e.g. ReSharper only work when installed via Toolbox.
    @{name = "JetBrains.Toolbox" }
    @{name = "JohannesMillan.superProductivity" }
    @{name = "mRemoteNG.mRemoteNG" }
    @{name = "Microsoft.AzureStorageExplorer" }
    @{name = "Microsoft.VisualStudio.2022.Professional" }
);

if ($InstallWorkApps) {
    Write-Host("Adding work only apps.")
    $apps += $workOnlyApps
}

if ($InstallPrivateApps) {
    Write-Host("Adding private only apps.")
    $apps += $privateOnlyApps
}

Foreach ($app in $apps)
{
    $appInstalledResponse = winget list --exact -q $app.name
    Write-Host("appInstalledResponse for '$($app.name)' = '${appInstalledResponse}'")
    if ($WhatIf) {
        Write-Host("Skipping operations in WhatIf mode.")
        continue
    }

    # Checks if the app is already installed.
    if (![String]::Join("", $appInstalledResponse).Contains($app.name))
    {
        Write-host "Installing:" $app.name
        if ($null -ne $app.source)
        {
            winget install --exact --silent $app.name --source $app.source
        }
        else
        {
            winget install --exact --silent $app.name
        }
    }
    else
    {
        Write-host "Skipping Install of " $app.name
    }
}