#InstallKeybdHook
#SingleInstance
#NoEnv
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Chording
d & f::
{
    MsgBox,  % A_ThisHotkey
}
d::Send d
f & d::
{
    MsgBox,  % A_ThisHotkey
}
f::Send f