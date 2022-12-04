#InstallKeybdHook
#SingleInstance
#NoEnv
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

lowers := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
global camelString := 
global snake_string :=
; camelLength = 0

for i,v in lowers
{
	Hotkey, ~%v%, captureCamel
    Hotkey, ~+%v%, captureCamel
}
Hotstring(":: ", " ") ; for whatever reason, dummy setting a hotstring is necessary to get this to work for the first letter of the first dynamic hotstring
Hotstring("Reset")
ResetConvertCamelSnake()

+F7::Reload ; Hotstring command throws error without this

ResetConvertCamelSnake()
{
    camelString :=
    snake_string :=
    return
}

captureCamel:
{
    capsOn := GetKeyState("CapsLock","T")
    shiftDn := StrLen(A_ThisHotkey) > 2
    lowerLetter := SubStr(A_ThisHotkey, StrLen(A_ThisHotkey), 1)
    upperLetter := Chr(Asc(lowerLetter) - 32)
    If capsOn ^ shiftDn
    {        
        if StrLen(camelString) > 0
        {            
            snake_string := snake_string "_" lowerLetter
        }
        Else
        {            
            snake_string := snake_string upperLetter
        }
        camelString := camelString upperLetter
    }
    Else
    {
        camelString := camelString lowerLetter
        snake_string := snake_string lowerLetter
    }
    Hotstring("::" camelString, snake_string)
    return
}

~LButton::
~RButton::
~Left::
~Right::
~Up::
~Down::
~Enter::
~Tab::
~Space::
{
    ; camelLength := StrLen(camelString)
    ; Send {Backspace %camelLength%}{BackSpace}
    ; Send % snake_string
    ; Send {Space}
    Hotstring("Reset")
    ResetConvertCamelSnake()
    return
}