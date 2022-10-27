# Blocks private network profile inbound traffic

Set-NetConnectionProfile -Name "Network" -NetworkCategory Private
Set-NetFirewallProfile -Name Private -AllowInboundRules False