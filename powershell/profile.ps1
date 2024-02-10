# Environment
$env:LC_ALL = "C.UTF-8"
$env:POSH_GIT_ENABLED = $true
$env:OPENSSL_CONF = "C:\certs\openssl.cnf"

Set-Variable -Name "repos" -Value $(Join-Path $env:USERPROFILE "source/repos") -Scope global

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Chord 'Ctrl+"' -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -Colors @{ InlinePrediction = $PSStyle.Foreground.BrightBlack }

# Modules 
Import-Module posh-git

# Posh
oh-my-posh --init --shell pwsh --config $(Join-Path $PSScriptRoot '.\PoshThemes\material-modded.omp.json') | Invoke-Expression

$GitPromptSettings.EnableStashStatus = $true
$GitPromptSettings.BeforeStatus.Text = " :: ["
$GitPromptSettings.AfterStatus.Text = "]"

function global:PromptWriteErrorInfo() {
    if ($global:GitPromptValues.DollarQuestion) { return }

    if ($global:GitPromptValues.LastExitCode) {
        "`e[31m(" + $global:GitPromptValues.LastExitCode + ") `e[0m"
    }
    else {
        "`e[31m! `e[0m"
    }
}