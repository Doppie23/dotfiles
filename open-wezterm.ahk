;; Add to AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;; to auto start

#Esc::
#`::
WinTitle := "ahk_exe wezterm-gui.exe"
DetectHiddenWindows, On

IfWinActive, %WinTitle%
{
    WinActivate, ahk_class Shell_TrayWnd
    WinHide, %WinTitle%
}
else IfWinExist, %WinTitle%
{
    DetectHiddenWindows, Off
    IfWinNotExist, %WinTitle%
    {
        ; could not find the window so its hidden
        WinShow, %WinTitle%
    }
    else
    {
        WinRestore, %WinTitle%
    }
    WinActivate, %WinTitle%
}
else
{
    Run, wezterm.exe,, Hide
}
return
