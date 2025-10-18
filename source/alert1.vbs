Dim shell, args, drive, dir, choice
Set shell = CreateObject("WScript.Shell")
Set args = WScript.Arguments

If args.Count < 1 Then
    MsgBox "Crital Error Occured (0X001)", vbCritical, "wowTools 5"
    WScript.Quit 1
End If

dir   = args(0)

choice = MsgBox("The server is now ready!", vbOKCancel + vbExclamation, "wowTools 5")

If choice = vbOK Then
    shell.Run """" & exePath & """", 0, False
Else
      WScript.Quit 1
End If
