# Environment
$env:LC_ALL = "C.UTF-8"
$env:POSH_GIT_ENABLED = $true
Set-Variable -Name "repos" -Value $(Join-Path $env:USERPROFILE "source/repos") -Scope global

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Chord 'Ctrl+"' -Function MenuComplete

# Modules 
Import-Module posh-git
Import-Module Terminal-Icons

# Posh
oh-my-posh --init --shell pwsh --config $(Join-Path $PSScriptRoot '.\PoshThemes\material-modded.omp.json') | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
$GitPromptSettings.EnableStashStatus = $true
