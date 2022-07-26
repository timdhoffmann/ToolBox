# Installs New applications.
# Source: https://chrislayers.com/2021/08/01/scripting-winget/.

$apps = @(
    # Development.
    @{name = "Microsoft.PowerShell" } 
    @{name = "Microsoft.VisualStudioCode" }
    @{name = "Git.Git" } 
    # OhMyPosh shell prompt.
    @{name = "JanDeDobbeleer.OhMyPosh" } 
    
    # Productivity.
    @{name = "Mozilla.Firefox" }
    @{name = "Google.Chrome" }
    @{name = "Notion.Notion" } 
    @{name = "Discord.Discord" } 
    @{name = "Microsoft.PowerToys" } 
    @{name = "Bitwarden.Bitwarden" } 
    @{name = "voidtools.Everything" } 
    
    # Private Only.
    # @{name = "Microsoft.VisualStudio.2022.Community" }
    # @{name = "Foxit.FoxitReader" } 
    # @{name = "Google.Drive" } 
    # @{name = "Foundry376.Mailspring" } 
    # @{name = "BraveSoftware.BraveBrowser" }
    # @{name = "OpenWhisperSystems.Signal" } 
    # @{name = "WhatsApp.WhatsApp" } 
    # @{name = "Twilio.Authy" } 
    # @{name = "Logitech.GHUB" }
    
    # Work.
    # This will throw an error but it is actually a success that only requires a system restart.
    @{name = "SlackTechnologies.Slack" } 
    @{name = "Microsoft.Teams" }
    @{name = "JetBrains.Toolbox" }
    @{name = "JetBrains.IntelliJIDEA.Ultimate" }
    @{name = "JohannesMillan.superProductivity" }

    # Misc.
    @{name = "Valve.Steam" }
    @{name = "EpicGames.EpicGamesLauncher" }
    @{name = "Spotify.Spotify" }
);

Foreach ($app in $apps) {
    # Checks if the app is already installed.
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($null -ne $app.source) {
            winget install --exact --silent $app.name --source $app.source
        }
        else {
            winget install --exact --silent $app.name 
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}