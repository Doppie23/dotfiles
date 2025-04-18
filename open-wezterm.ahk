;; Add to AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;; to auto start

#Esc::
WinTitle := "ahk_exe wezterm-gui.exe"

IfWinActive, %WinTitle%
{
    WinMinimize, %WinTitle%
}
else IfWinExist, %WinTitle%
{
    WinActivate, %WinTitle%
}
else
{
    Run, wezterm.exe,, Hide
}
return
