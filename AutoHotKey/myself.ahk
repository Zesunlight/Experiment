; CapsLock + wasd
CapsLock & w:: Send {Pgup}
CapsLock & s:: Send {Pgdn}
CapsLock & a:: Send {home}
CapsLock & d:: Send {end}

; CapsLock + ijkl
CapsLock & i:: Send {up}
CapsLock & k:: Send {down}
CapsLock & j:: Send {left}
CapsLock & l:: Send {right}

; CapsLock + [] (windows virual desktop switcher)
CapsLock & [:: Send ^#{left}
CapsLock & ]:: Send ^#{right}

CapsLock & WheelUp:: Send {Volume_Up}
CapsLock & WheelDown:: Send {Volume_Down}

; RAlt + wasd --> shift + ...
RAlt & w:: Send +{up}
RAlt & s:: Send +{down}
RAlt & a:: Send +{left}
RAlt & d:: Send +{right}

; let window in front of all
RAlt & t:: Winset, AlwaysOnTop, , A

; short message
:*:/name::风雨替花愁

RAlt & p::run powershell, A:\
RAlt & m::run C:\Program Files\Sublime Text 3\sublime_text.exe

; for left hand
>#o:: Send <#e
RAlt & \::AltTab

~NumpadDot & Numpad0::
~NumpadDel & NumpadIns::
WinGetActiveTitle, Title
IfInString, Title, Browser
{
    send ^w
    return
}
IfInString, Title, AutoHotkey
{
    send {esc}
    return
}
WinClose, %Title%
return

; Ctrl+shift+c  copy file path
^+c::
send ^c
sleep,200
clipboard=%clipboard%
tooltip,%clipboard%
sleep,500
tooltip,
return