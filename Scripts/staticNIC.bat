powershell -noexit "Start-Job { Start-Sleep -seconds 60; New-NetIPAddress -InterfaceIndex (Get-NetAdapter -Name Ethernet*)[0].ifIndex -IPAddress 8.8.8.8; }"
