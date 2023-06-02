# winget install JanDeDobbeleer.OhMyPosh -s winget
# Install-Module -Name PowerShellGet -Force
# PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
# Add-PoshGitToProfile

New-Alias open ii

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -Colors @{ InlinePrediction = '#9CA3AF' }
# Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi

Set-PSReadlineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadlineKeyHandler -Key "UpArrow" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key "DownArrow" -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord

# $env:POSH_THEMES_PATH\agnoster.omp.json
# edit block->segments type:path | change properties->style from 'agnoster' to 'full'
oh-my-posh init pwsh --config "C:\\Users\\noonomyen\\.ompsh\\agnoster-mod.omp.json" | Invoke-Expression

