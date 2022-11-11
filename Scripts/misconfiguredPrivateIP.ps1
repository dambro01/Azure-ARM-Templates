# Disables and denies connections on "Remote Desktop" firewall group rule

$nic = Get-NetAdapter | where {$_.InterfaceDescription -like "Microsoft Hyper-V*"}
Set-DnsClientServerAddress -InterfaceIndex $nic.ifIndex -ServerAddresses ("168.63.129.16")
Set-NetIPAddress -InterfaceIndex $nic.ifIndex -PrefixLength 24
New-NetIPAddress -InterfaceIndex $nic.ifIndex -IPAddress "192.168.3.2" -DefaultGateway "192.168.3.1" -PrefixLength 24 -AddressFamily IPv4