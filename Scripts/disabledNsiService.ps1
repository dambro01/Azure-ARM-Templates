# Creates temp folder and exports current value

md c:\temp
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nsi" | Out-File -FilePath C:\temp\nsi.txt

# Disables NSI service

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nsi" -name "Start" -value 4

# Restarts the VM

Restart-Computer -Force