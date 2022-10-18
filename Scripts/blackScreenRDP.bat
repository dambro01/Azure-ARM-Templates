net localgroup "Users" "NT AUTHORITY\INTERACTIVE" /delete
net localgroup "Users" "NT AUTHORITY\Authenticated Users" /delete
shutdown /r /f /t 0