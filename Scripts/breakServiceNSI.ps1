# Creates temp folder and exports current value

md c:\temp
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nsi" | Out-File -FilePath C:\temp\nsi.txt

# Changes the logon account for the NSI service

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\nsi' -name "ObjectName" -value "NT Authority\ServiceLocal"

# Restarts the VM

Restart-Computer -Force