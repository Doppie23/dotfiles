;; Add to AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;; to auto start

#Esc::
#`::
WinTitle := "ahk_exe wezterm-gui.exe"

IfWinActive, %WinTitle%
{
    ; Build a list of all matching window IDs
    WinGet, idList, List, %WinTitle%
    if (idList > 1)
    {
        ; Find index of the currently active window in the list
        WinGet, activeID, ID, A
        nextID := ""  ; default blank
        Loop, %idList%
        {
            thisID := idList%A_Index%
            if (thisID = activeID)
            {
                ; Wrap to first after last
                idxNext := (A_Index = idList ? 1 : A_Index + 1)
                nextID := idList%idxNext%
                break
            }
        }

        ; Activate next instance if found
        if (nextID != "")
        {
            WinActivate, ahk_id %nextID%
            WinRestore, ahk_id %nextID%   ; Just in case it's minimized
        }
        return
    }
    else
    {
        ; Only one instance: minimize the active window (original behavior)
        WinMinimize, A
        return
    }
}
else IfWinExist, %WinTitle%
{
    WinRestore, %WinTitle%
    WinActivate, %WinTitle%
}
else
{
    Run, wezterm.exe,, Hide
}
return
