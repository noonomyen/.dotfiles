if ($PWD.Path -eq "C:\Windows\System32") {
    Set-Location $env:USERPROFILE
}

# winget install JanDeDobbeleer.OhMyPosh -s winget
# Install-Module -Name PowerShellGet -Force
# PowerShellGet\Install-Module posh-git -Force
# Install-Module -Name Terminal-Icons -Repository PSGallery

Import-Module posh-git
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
oh-my-posh init pwsh --config "C:\\Users\\nnyno\\.ompsh\\mod.agnoster.omp.json" | Invoke-Expression

