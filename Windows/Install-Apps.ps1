# Installs New applications.
# Source: https://chrislayers.com/2021/08/01/scripting-winget/.
$apps = @(
    # Development.
    @{name = "Microsoft.PowerShell" } 
    @{name = "Microsoft.VisualStudioCode" }
    @{name = "Microsoft.VisualStudio.2022.Community" }
    @{name = "Git.Git" } 
    # OhMyPosh shell prompt.
    @{name = "JanDeDobbeleer.OhMyPosh" } 
    @{name = "gerardog.gsudo" } 

    # Productivity.
    @{name = "Mozilla.Firefox" }
    @{name = "Google.Chrome" }
    @{name = "BraveSoftware.BraveBrowser" }
    @{name = "Notion.Notion" } 
    @{name = "OpenWhisperSystems.Signal" } 
    @{name = "WhatsApp.WhatsApp" } 
    @{name = "Discord.Discord" } 
    @{name = "Microsoft.PowerToys" } 
    @{name = "Google.Drive" } 
    @{name = "Foundry376.Mailspring" } 
    @{name = "Foxit.FoxitReader" } 
    
    # Work.
    # This will throw an error but it is actually a success that only requires a system restart.
    @{name = "Citrix.Workspace" } 
    @{name = "Microsoft.Teams" }

    # Misc.
    @{name = "Valve.Steam" }
    @{name = "EpicGames.EpicGamesLauncher" }
    @{name = "Logitech.GHUB" }
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