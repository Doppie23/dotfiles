# Starship
Invoke-Expression (&starship init powershell)

# Auto complete
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

# FZF and after open explorer at file location
function ifzf {
  ii (Split-Path -Parent (fzf))
}
New-Alias -Name search -Value ifzf
