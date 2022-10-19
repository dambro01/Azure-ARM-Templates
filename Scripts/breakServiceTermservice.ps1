# Creates temp folder and exports current value

md c:\temp
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\TermService\Parameters' -name "ServiceDll" | Out-File -FilePath C:\temp\termservice.txt

# Breaks the service dll path

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\TermService\Parameters' -name "ServiceDll" -value "%SystemRoot%\System32\rdp.dll"

# Restarts the VM

Restart-Computer -Force