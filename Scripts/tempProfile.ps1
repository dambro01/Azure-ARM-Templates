# Corrupts the user profie

#$username = Get-Content "C:\Packages\Plugins\Microsoft.CPlat.Core.RunCommandHandlerWindows\2.0.5\Downloads\username.txt" -First 1
#$password = Get-Content "C:\Packages\Plugins\Microsoft.CPlat.Core.RunCommandHandlerWindows\2.0.5\Downloads\password.txt" -First 1

$username = "azuresota"
$password = "P@ssword!123"

SCHTASKS /CREATE /SC DAILY /TN "openNotepad" /TR "notepad.exe" /ST HH:11:00 /RU $username /RP $password
SCHTASKS /run /tn "openNotepad"

Stop-Process -Name "notepad" -Force

md c:\temp

cd C:\temp\
$registry = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" -Recurse
Foreach($a in $registry) {
    $a.Property | ForEach-Object {
        If($a.GetValue($_) -eq ("C:\Users\" + $username))
        {
            $path = $a.PSChildName
            Invoke-Command { reg export ("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" + $path) regbck.reg }
            Rename-Item -Path ("HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" + $path) -NewName ($path + ".bak")
            Invoke-Command { reg import regbck.reg }
            Set-ItemProperty -Path ("HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" + $path) -name "ProfileImagePath" -value ("C:\Users\" + $username + "1")
            }
    }
}
