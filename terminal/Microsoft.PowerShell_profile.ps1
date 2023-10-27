# CWD windows terminal
# function prompt {
#   $loc = $executionContext.SessionState.Path.CurrentLocation;

#   $out = ""
#   if ($loc.Provider.Name -eq "FileSystem") {
#     $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
#   }
#   $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
#   return $out
# }

# icons
Import-Module Terminal-Icons

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
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

# Dir auto complete
# Import-Module DirectoryPredictor
# Set-DirectoryPredictorOption -DirectoryMode Mixed
# Set-DirectoryPredictorOption -SortMixedResults Folders

# ls allias
Import-Module PowerColorLS
function Power-Color {
  PowerColorLS -a
}

Set-Alias -Name ls -Value Power-Color -Option AllScope

# Starship
Invoke-Expression (&starship init powershell)