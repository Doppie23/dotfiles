# Starship
Invoke-Expression (&starship init powershell)

# Auto complete
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {
    $result = fzf
    if ($result) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("`"$result`"")
    }
}

# FZF and after open explorer at file location
function ifzf {
  ii (Split-Path -Parent (fzf))
}
New-Alias -Name search -Value ifzf
