# AutoHotkey教程

## 相关链接

- 官网下载：https://www.autohotkey.com/
- 中文论坛：https://www.autohotkey.com/boards/viewforum.php?f=26
- 中文文档：https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm
- Github：https://github.com/Lexikos/AutoHotkey_L
- AHK 快餐店：https://www.appinn.com/ahk-fast-food-restaurant/
- 中文社区：https://www.autoahk.com/

## 是什么

AutoHotkey是一门Windows平台下的脚本语言，支持热键、热字符、Windows API，能够快捷或自动执行重复性任务。

## 基本语法

### 热键

```
[热键名称]::1行代码

[热键名称]::
代码行1
代码行2
...
代码行n
return
```

即自定义快捷键

### 热字串

```
;将你输入的 ftw 转换为 Free the whales
::ftw::Free the whales

;将你输入的 btw 转换为 You typed "btw"
::btw::
   Send, You typed "btw"
Return

:*:btw::By the way  ; 替换 "btw" 为 "By the way" 而不需要按下终止符
```

热字串可用于扩展缩写、自动替换、启动脚本动作

### 符号

| 符号  | 描述 |
| ------ | ---- |
| # | Win |
| !    | Alt                                                          |
| ^    | Ctrl                                                         |
| +    | Shift                                                        |
| &    | 合并两个按键（含鼠标按键）成为一个自定义热键                 |
| ::   | （两个英文冒号）起分隔作用                                   |
| ;    | 注释后面一行的内容                                           |
| <    | 使用成对按键中左边的触发效果                                 |
| >    | 使用成对按键中右边的触发效果                                 |
| *    | 属于其他热键的一部分时也能触发，如`*#c::Run Calc.exe`，Win+C, Shift+Win+C, Ctrl+Win+C 等都会触发此热键 |
| ~    | 触发热键时，热键中按键原有的功能不会被屏蔽                   |


### 关键字

| 关键字 | 含义 |
| ------ | ---- |
| run | 用来启动一个程序、文档、URL 网址或快捷方式，如使用 AHK 内置变量来打开"我的文档" `Run, %A_MyDocuments%` |
| MsgBox | 生成对话框的命令 |
| UP | 跟在热键名后面，使得在释放按键时触发热键，而不是按下时 |
| Numpad0 | 数字键0 |
| Send | 表示发送按键，模拟打字或按键操作                             |

### 其他

- `.ahk`文件编码保存为`UTF-8 BOM`，可避免中文乱码问题
- `!A` 表示按下 Alt+Shift+A ，而 `!a` 表示按下 Alt+A
- 所有按键列表：https://wyagd001.github.io/zh-cn/docs/KeyList.htm

## 示例

### 简单功能

#### 替换大写锁定键

```
; replace CapsLock to LeftEnter; CapsLock = Alt CapsLock
$CapsLock::Enter
LAlt & Capslock::SetCapsLockState, % GetKeyState("CapsLock", "T") ? "Off" : "On"
```

#### 按键映射与屏蔽

```
; 左 Win 重映射为左 Ctrl
*LWin::Send {LControl down}
*LWin Up::Send {LControl up}

; 简单一点
LWin::LCtrl
LCtrl::LWin

LWin::return  ;屏蔽左边的 Win 键
```

#### 复制加强

```
^b::  ; Ctrl+B 热键
Send, {ctrl down}c{ctrl up}  ; 复制选定的文本. 也可以使用 ^c, 但这种方法更加可靠.
SendInput, [b]{ctrl down}v{ctrl up}[/b] ; 粘贴所复制的文本, 并在文本前后加上加粗标签.
Return  ; 热键内容结束, 这之后的内容将不会触发.
```

#### 右手操作

```
RAlt & \::AltTab  ; 右手切换任务
; AltTab 和 ShiftAltTab 是两个特殊的命令, 它们仅在与热键在同一行时才能被识别

RAlt & v:: Send, $${left}  ; latex formula
RAlt & o::run A:\Papers\2019ThesisUESTC\clean.bat  ; latex compile

>^Up::WinMaximize A   ; 最大化活动/前端窗口.
>^Down::WinMinimize A   ; 最小化活动/前端窗口.
```

#### [像素级移动鼠标](https://www.appinn.com/ahk-fast-food-restaurant-9-move-the-mouse-one-pixel/)

```
; MouseMove 的完整语法是：
; MouseMove, X, Y [, Speed, R]
; X – X 坐标；Y – Y 坐标；[ ] 里面的是可选参数，Speed – 移动的速度，其范围是 0 – 100，不填写任何数字的话，参数默认是 0 ，最快速移动；最后的 R 表示前面的参数 X、Y 是相对鼠标当前位置，如果不带这个参数， X、Y 就表示屏幕上的坐标。讲起来很啰嗦，大家比较上面的代码就明白。
Left::  MouseMove, -1,  0, , R
Up::    MouseMove,  0, -1, , R
Right:: MouseMove,  1,  0, , R
Down::  MouseMove,  0,  1, , R
```

#### [鼠标左右键同时按下关闭窗口](https://www.appinn.com/ahk-fast-food-restaurant-12-lbutton-rbutton-close-window/)

```
~LButton & RButton::
;按住不放 A 键再按 B 键的写法是 “A & B”
;前缀键导致失去它原有的功能
;“~”在这里是指示原有的左键仍要处理，若不加“~”则左键就失效了
WinGetClass, class, A  ;类名
IfInString, class, Chat
{
    send !{F4}
    return
}

WinGetActiveTitle, Title  ;获取当前活动窗口的标题
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

WinClose, %Title%  ;关闭窗口
return
```

#### [在命令提示符下粘贴](https://www.appinn.com/paste-in-cmd/)

```
#IfWinActive ahk_class ConsoleWindowClass
^v::
send %Clipboard%
return

; 模拟右键来粘贴
#IfWinActive ahk_class ConsoleWindowClass
^v::
MouseClick, Right, %A_CaretX%, %A_CaretY%,,0
send p  ;在右键菜单弹出来后，按下 p，即点击粘贴命令
return
```

`#IfWinActive` 是一个用来对特定窗口实现快捷键（hotkey）和热字符串（HotString）的命令，`ahk_class ConsoleWindowClass` 是命令提示符的类名，可以用 ahk 自带的 Window Spy 获得。

`A_CaretX` 是一个 ahk 自带的变量，它的值就是当前光标——特指那个文本框中一闪一闪的光标——的 X 坐标，但AHK 无法正确得到光标在 Firefox 下的坐标。

### 他山之石

集合：https://wyagd001.github.io/zh-cn/docs/scripts/index.htm

窗口贴边隐藏：https://www.appinn.com/winautohide/

把鼠标键盘动作录制成一个 AHK 脚本：https://www.appinn.com/ahk-fast-food-restaurant-7-macro-recorder/

秒表：https://autohotkey.com/board/topic/88714-simple-stop-watch/

入门教程：https://www.autoahk.com/archives/16262



