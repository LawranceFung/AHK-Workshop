#InstallKeybdHook
#SingleInstance
#NoEnv
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

toggle := 0

SetTitleMatchMode, 2
; Debugging
; I recommend AutoHotkey Plus Plus for Visual Studio Code

; hotstrings
    ; Git Bash
::psh:: git add . && git commit -m "" && git push{left 13}

; RegEx
::\anything::.
::\matchAtLeastOnce::+
::\matchAtLeastZero::*
::\whitespace::\s
::[ \t\n\r\f\v]::\s
::startGroup::[
::endGroup::]

; Application-specific shortcuts
; RegEx by application
#IfWinActive, - Sublime Text    
#IfWinActive
; Python 
#IfWinActive, .py
    ::\regex::re.search(''){left 2}
#IfWinActive
; Java escapes more characters
#IfWinActive, .java
    ::\startInnerGroup::\[
    ::\endInnerGroup::\]
#IfWinActive

; Open or call programs
#0::Run, cmd ; directly
+#0::Run, "C:\Program Files (x86)\Notepad++\notepad++.exe" ; full path
; by aumid
!#0::Run, shell:Appsfolder\Microsoft.Getstarted_8wekyb3d8bbwe!App
; Hidden
^#0::
{
    TempFile=%A_ScriptDir%\ip_temp.txt ; Define temp file
    RunWait %comspec% /c "ipconfig > %TempFile%",,Hide ; Redirect info into temp file whilst hiding Command output
    Return
}

; mouse movement
F12::
    MouseGetPos, xpos, ypos 
    MsgBox, The cursor is at X%xpos% Y%ypos%. 
    Return

; Sequential Shortcuts
+#'::
{
    sequenceTooltip("Pe&$o`n&Bitcoin`nLong ɨ`n^&interrobang`n&x Times`nBullet Point (&.)")
    Input Key, CL1T1M ; since L1 specifies a total of 1 followup stroke, we don't need to handle ESC as a sequence break
    ; MsgBox % Key
    switch Key
    {
        case "$":
            Send {U+20B1}
            Return
        case "b":
            Send {U+20BF}
            Return
        ; case "B": ; case sensitive option C does not seem to work
        ;     Send {U+0E3F}
        ;     Return
        case "i":
            Send {U+0268}
            Return
        case Chr(9): ; ^iɨ
            Send {U+203D}
            Return
        case Chr(73): ; +^i
            Send {U+2E18}
            Return
        case "x":
            Send {U+00D7}
            Return
        default: ; input character
            Send % Key
            Return
    }
}
Return

; Sequential Shortcuts Helper Functions
sequenceTooltip(Tooltips)
{
    IfWinExist, tooltipWin
        Gui, destroy
    
    Gui, +ToolWindow -Caption +0x400000 +alwaysontop        
    Gui, Font, s15
    Gui, Add, text, x0 y0, %Tooltips%
    SysGet, screenx, 0
    SysGet, screeny, 1
    xpos:=screenx / 2
    ypos:=screeny / 2
    Gui, Show, NoActivate xcenter ycenter AutoSize center, tooltipWin
    
    SetTimer,tooltipWinClose, 1000
}
tooltipWinClose:
    SetTimer,tooltipWinClose, off
    Gui, destroy
Return


; terminal command that runs in the background which requires capturing console output
#If (WinActive("ahk_exe WindowsTerminal.exe") && WinActive("MSYS:/")) || WinActive("MINGW64") ; #todo migrate to Windows Terminal JSON settings?  https://docs.microsoft.com/en-us/windows/terminal/customize-settings/actions
{
    ^!7:: ; squash current branch's changes into master ; mnemonic 7 comes from 7-zip
    {
        myBranchName := HiddenCommand("git branch --show current")
        StringLen, myBranchNameLength, myBranchName    
        SendInput, git checkout master && git merge --squash %myBranchName% -m ""{left 1} 
        Return
    }
    ^!c::clipboard := HiddenCommand("git rev-parse HEAD") ; copy commit stamp  
}

; How to catch output from command line (In Git Bash Windows Terminal)
HiddenCommand(CmdToHide)
{
    WinGetTitle, Title, A
    SanitizedFolderName := RegExReplace(Title, "MSYS:/([a-z])", "$U1:") ; assumes Git Bash Windows Terminal
    ; SanitizedFolderName := RegExReplace(Title, "MINGW64:/([a-z])", "$U1:") ; assumes Git Bash
    ; assumes main drive, which isn't necessarily C:\
    RunWait, %comspec% /c cd %SanitizedFolderName% && %CmdToHide% > C:\Users\Public\temp-cmd-output.txt,,Hide
    tempCmdOutFile := FileOpen("C:\Users\Public\temp-cmd-output.txt", "r")
    cmdOut := RegExReplace(tempCmdOutFile.ReadLine(), "(.*)\n$", "$1")
    tempCmdOutFile.Close()
    FileDelete, C:\Users\Public\temp-cmd-output.txt
    return cmdOut
}