# Creates temp folder and exports current value

md c:\temp
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache" | Out-File -FilePath C:\temp\DNSCache.txt

# Disables DNSCache service

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache" -name "Start" -value 4

# Restarts the VM

Restart-Computer -Force