# Corrupts the user profie

$username = "azuresota"
$password = "P@ssw0rd!123"

[SecureString]$secureString = $password | ConvertTo-SecureString -AsPlainText -Force
[PSCredential]$credentialObject = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureString

Enable-PSRemoting -Force

Invoke-Command -ComputerName localhost -Credential $credentialObject -ScriptBlock {Start-Process "notepad.exe"}
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
