WinTransplus(w){
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent <= 245
        transparent := transparent+10
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}
WinTransMinus(w){
    WinGet, transparent, Transparent, ahk_id %w%
    if transparent > 20
        transparent := transparent-10
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
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