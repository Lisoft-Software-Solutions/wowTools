Dim shell, args, drive, dir, choice
Set shell = CreateObject("WScript.Shell")
choice = MsgBox("Setup has complete! You can now reopen WoW Tools!", OK , "wowTools 5")
If choice = vbOK Then
      WScript.Quit 1
End If
