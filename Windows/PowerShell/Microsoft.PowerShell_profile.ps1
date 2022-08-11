oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/pure.omp.json | Invoke-Expression
Import-Module posh-git

# Set tab completion with menu.
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}