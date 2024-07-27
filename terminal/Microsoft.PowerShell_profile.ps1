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
function Power-Color {
  PowerColorLS -a
}

Set-Alias -Name ls -Value Power-Color -Option AllScope

# Starship
Invoke-Expression (&starship init powershell)