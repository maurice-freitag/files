# Environment
$env:LC_ALL = "C.UTF-8"

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Chord 'Ctrl+"' -Function MenuComplete

# Modules 
Import-Module posh-git
Import-Module oh-my-posh
Import-Module Terminal-Icons

# Posh
Copy-Item $(Join-Path $PSScriptRoot '.\PoshThemes\*') $(Join-Path $env:USERPROFILE '\Documents\PowerShell\PoshThemes') -Force -Recurse
Set-Theme Material-modded

Set-PSReadLineOption -PredictionSource History
$GitPromptSettings.EnableStashStatus = $true
$Global:ThemeSettings.Colors.PromptBackgroundColor = 0x4483B7
$Global:ThemeSettings.Colors.GitDefaultColor = 0x30ed62
$Global:ThemeSettings.Colors.SessionInfoBackgroundColor = 0x818181

# Functions
function sln {
    $slns = Get-ChildItem "*.sln"
    if ($slns.Count -eq 0) {
        Write-Error "No solutions found"
    }
    elseif ($slns.Count -gt 1){
        Write-Error "More than one solution found"
    }
    else {
        Start-Process -FilePath $slns[0]
    }
}
