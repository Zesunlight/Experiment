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

CapsLock & `;::Send {BackSpace}
CapsLock & BackSpace:: Send {Home}{ShiftDown}{End}{ShiftUp}{BackSpace}

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

; [组合键]::run [程序路径]
RAlt & p::run powershell, A:\
RAlt & m::run C:\Program Files\Sublime Text 3\sublime_text.exe

; for left hand
>#o:: run %A_Desktop%
RAlt & \:: AltTab
RCtrl & /:: Send ^x

; let window in front of all
RAlt & t:: Winset, AlwaysOnTop, , A

; ::[原字符串]::[替代字符串]
:*:/name::风雨替花愁

AppsKey::
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
clipboard=%clipboard%  ; 把格式文本转换为纯文本
tooltip,%clipboard%
sleep,500
tooltip,
return

WinTransplus(w){
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent < 255
        transparent := transparent+10
    else
        transparent =
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}
WinTransMinus(w){
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent
        transparent := transparent-10
    else
        transparent := 240
    WinSet, Transparent, %transparent%, ahk_id %w%
    return
}
;窗口透明度减少
#Pgup:: 
WinGet, ow, id, A
WinTransplus(ow)
return
;窗口透明度增加
#Pgdn:: 
WinGet, ow, id, A
WinTransMinus(ow)
return