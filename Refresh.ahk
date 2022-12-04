; Turns on hotkeys if off

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode, 2
DetectHiddenWindows, On
IfWinNotExist, Shortcuts.ahk
	Run, Shortcuts.ahk
Return