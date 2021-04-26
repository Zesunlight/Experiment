/*
 * BoD winautohide v1.00.
 *
 * This program and its source are in the public domain.
 * Contact BoD@JRAF.org for more information.
 *
 * Version history:
 * 2008-06-13: v1.00
 */

#SingleInstance ignore

/*
 * Hotkey bindings
 */
;Hotkey, #right, toggleWindowRight
;Hotkey, #left, toggleWindowLeft
;Hotkey, #up, toggleWindowUp
;Hotkey, #down, toggleWindowDown

;Hotkey, ~Numpad0 & right, toggleWindowRight
;Hotkey, ~Numpad0 & left, toggleWindowLeft
;Hotkey, ~Numpad0 & up, toggleWindowUp
;Hotkey, ~Numpad0 & down, toggleWindowDown

Hotkey, >^right, toggleWindowRight
Hotkey, >^left, toggleWindowLeft
Hotkey, >^up, toggleWindowUp
Hotkey, >^down, toggleWindowDown

; uncomment the following lines to use ctrl+alt+shift instead if you don't have a "windows" key
;Hotkey, !^+right, toggleWindowRight
;Hotkey, !^+left, toggleWindowLeft
;Hotkey, !^+up, toggleWindowUp
;Hotkey, !^+down, toggleWindowDown



/*
 * Timer initialization.
 */
SetTimer, watchCursor, 300


/*
 * Tray menu initialization.
 */
Menu, tray, NoStandard
Menu, tray, Add, About..., menuAbout
Menu, tray, Add, Un-autohide all windows, menuUnautohideAll
Menu, tray, Add, Exit, menuExit
Menu, tray, Default, About...


return ; end of code that is to be executed on script start-up


/*
 * Tray menu implementation.
 */
menuAbout:
	MsgBox, 8256, About, BoD winautohide v1.00.`n`nThis program and its source are in the public domain.`nContact BoD@JRAF.org for more information.
return

menuUnautohideAll:
	Loop, Parse, autohideWindows, `,
	{
		curWinId := A_LoopField
		if (autohide_%curWinId%) {
			Gosub, unautohide
		}
	}
return

menuExit:
	Gosub, menuUnautohideAll
	ExitApp
return



/*
 * Timer implementation.
 */
watchCursor:
	MouseGetPos, , , winId ; get window under mouse pointer
	if (autohide_%winId%) { ; window is on the list of 'autohide' windows
		if (hidden_%winId%) { ; window is in 'hidden' position
			previousActiveWindow := WinExist("A")
			WinActivate, ahk_id %winId% ; activate the window
			WinMove, ahk_id %winId%, , showing_%winId%_x, showing_%winId%_y ; move it to 'showing' position
			hidden_%winId% := false
			needHide := winId ; store it for next iteration
		}
	} else {
		if (needHide) {
			WinMove, ahk_id %needHide%, , hidden_%needHide%_x, hidden_%needHide%_y ; move it to 'hidden' position
			WinActivate, ahk_id %previousActiveWindow% ; activate previously active window
			hidden_%needHide% := true
			needHide := false ; do that only once
		}
	}
return


/*
 * Hotkey implementation.
 */
toggleWindowRight:
	mode := "right"
	Gosub, toggleWindow
return

toggleWindowLeft:
	mode := "left"
	Gosub, toggleWindow
return

toggleWindowUp:
	mode := "up"
	Gosub, toggleWindow
return

toggleWindowDown:
	mode := "down"
	Gosub, toggleWindow
return


toggleWindow:
	WinGet, curWinId, id, A
	autohideWindows = %autohideWindows%,%curWinId%
	if (autohide_%curWinId%) {
		Gosub, unautohide
	} else {
		autohide_%curWinId% := true
		Gosub, workWindow
		WinGetPos, orig_%curWinId%_x, orig_%curWinId%_y, width, height, ahk_id %curWinId% ; get the window size and store original position

		if (mode = "right") {
			showing_%curWinId%_x := A_ScreenWidth - width
			showing_%curWinId%_y := orig_%curWinId%_y

			hidden_%curWinId%_x := A_ScreenWidth - 1
			hidden_%curWinId%_y := orig_%curWinId%_y
		} else if (mode = "left") {
			showing_%curWinId%_x := 0
			showing_%curWinId%_y := orig_%curWinId%_y

			hidden_%curWinId%_x := -width + 1
			hidden_%curWinId%_y := orig_%curWinId%_y
		} else if (mode = "up") {
			showing_%curWinId%_x := orig_%curWinId%_x
			showing_%curWinId%_y := 0

			hidden_%curWinId%_x := orig_%curWinId%_x
			hidden_%curWinId%_y := -height + 1
		} else { ; down
			showing_%curWinId%_x := orig_%curWinId%_x
			showing_%curWinId%_y := A_ScreenHeight - height

			hidden_%curWinId%_x := orig_%curWinId%_x
			hidden_%curWinId%_y := A_ScreenHeight - 1
		}

		WinMove, ahk_id %curWinId%, , hidden_%curWinId%_x, hidden_%curWinId%_y ; hide the window
		hidden_%curWinId% := true
	}
return


unautohide:
	autohide_%curWinId% := false
	needHide := false
	Gosub, unworkWindow
	WinMove, ahk_id %curWinId%, , orig_%curWinId%_x, orig_%curWinId%_y ; go back to original position
	hidden_%curWinId% := false
return

workWindow:
	DetectHiddenWindows, On
	WinSet, AlwaysOnTop, on, ahk_id %curWinId% ; always-on-top
	WinHide, ahk_id %curWinId%
	WinSet, Style, -0xC00000, ahk_id %curWinId% ; no title bar
	WinSet, ExStyle, +0x80, ahk_id %curWinId% ; remove from task bar
	WinShow, ahk_id %curWinId%
return

unworkWindow:
	DetectHiddenWindows, On
	WinSet, AlwaysOnTop, off, ahk_id %curWinId% ; always-on-top
	WinHide, ahk_id %curWinId%
	WinSet, Style, +0xC00000, ahk_id %curWinId% ; title bar
	WinSet, ExStyle, -0x80, ahk_id %curWinId% ; remove from task bar
	WinShow, ahk_id %curWinId%
return
