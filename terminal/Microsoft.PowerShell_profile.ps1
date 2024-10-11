# Check if a venv (virtual environment) is present in the current directory
$venvDir = Join-Path $PWD.Path '.\.venv'

if (Test-Path $venvDir -PathType Container) {
    Write-Host "Activating virtual environment in $($PWD.Path)..."
    .\.venv\Scripts\Activate.ps1
}

# Starship terminal CWD
function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}

# Auto complete
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

# Dir auto complete
# Set-DirectoryPredictorOption -DirectoryMode Mixed
# Set-DirectoryPredictorOption -SortMixedResults Folders

# ls allias
# Import-Module PowerColorLS
# function Power-Color {
#   PowerColorLS -a
# }

# Set-Alias -Name ls -Value Power-Color -Option AllScope

# Starship
Invoke-Expression (&starship init powershell)

# FZF and after open explorer at file location
function ifzf {
  ii (Split-Path -Parent (fzf))
}
New-Alias -Name search -Value ifzf

# start hoogle server, server needs to first be generated once using:
# `stack hoogle -- generate`
function Start-Hoogle {
  $portInUse = Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue

  if ($portInUse) {
    Write-Host "Port 8080 is already in use. Skipping Hoogle server startup."
    Start-Process "http://localhost:8080"
  } else {
    Start-Process "http://localhost:8080"
    stack hoogle -- server --port=8080
  }
}
New-Alias -Name hoogle -Value Start-Hoogle
