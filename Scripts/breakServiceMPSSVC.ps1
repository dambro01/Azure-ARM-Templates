# Creates temp folder and exports current value

md c:\temp
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\mpssvc' -name "ImagePath" | Out-File -FilePath C:\temp\mpssvc.txt

# Breaks the imagepath string by giving an incorrect path

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\mpssvc' -name "ImagePath" -value "%SystemRoot%\system32\svchostt.exe -k LocalServiceNoNetworkFirewall -p"

# Restarts the VM

Restart-Computer -Force