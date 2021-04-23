#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    #check the last command state and indicate if failed
    $promtSymbolColor = [ConsoleColor]::Green
    If ($lastCommandFailed) {
        $promtSymbolColor = [ConsoleColor]::Red
    }
    
    $prompt += Write-Prompt -Object (
        [char]::ConvertFromUtf32(0x276F)) -ForegroundColor  $sl.Colors.GitNoLocalChangesAndAheadColor
    $prompt += Write-Prompt -Object (
        [char]::ConvertFromUtf32(0x276F)+" ") -ForegroundColor $promtSymbolColor
    # Writes the postfixes to the prompt
    

    $user = $sl.CurrentUser 
    $prompt += Write-Prompt -Object $user
    $prompt += Write-Prompt -Object " :: " 
    # Writes the drive portion
    $drive = $sl.PromptSymbols.HomeSymbol
    if ($pwd.Path -ne $HOME) {
        $drive = "$(Split-Path -path $pwd -Leaf)"
    }
    $prompt += Write-Prompt -Object $drive -ForegroundColor $sl.Colors.DriveForegroundColor

    $status = Get-VCSStatus
    $prompt += Write-Prompt -Object (" :: ")
    if ($status) {
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object ($themeInfo.VcInfo) -ForegroundColor $themeInfo.BackgroundColor
    }
    else {
        $fruits = @( "0x1F347","0x1F347","0x1F349","0x1F34A","0x1F34B","0x1F34C","0x1F34D","0x1F96D","0x1F34E","0x1F34F","0x1F350","0x1F351","0x1F352","0x1F353","0x1F95D","0x1F345","0x1F965" )
        $prompt += [char]::ConvertFromUtf32($($fruits | Get-Random))
    }


    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
    }
    $prompt += Write-Prompt -Object (" :: ")
    $sTime = "$(Get-Date -Format HH:mm)"
    $prompt += Write-Prompt -Object $sTime   -ForegroundColor $sl.colors.PromptSymbolColor
    #$prompt += Set-Newline

    $prompt += '  '
    $prompt
}

function Get-TimeSinceLastCommit {
    return (git log --pretty=format:'%cr' -1)
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.PromptIndicator = '+'
$sl.PromptSymbols.HomeSymbol = '🏠'
$sl.Colors.PromptSymbolColor = [ConsoleColor]::Green
$sl.Colors.PromptHighlightColor = [ConsoleColor]::Blue
$sl.Colors.DriveForegroundColor = [ConsoleColor]::Cyan
$sl.Colors.WithForegroundColor = [ConsoleColor]::Red
$sl.PromptSymbols.GitDirtyIndicator =[char]::ConvertFromUtf32(10007)
$sl.Colors.GitDefaultColor = [ConsoleColor]::Yellow
$sl.Colors.AdminIconForegroundColor = [ConsoleColor]::Blue
