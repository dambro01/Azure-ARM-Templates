# Removes NT AUTHORITY\INTERACTIVE and NT AUTHORITY\Authenticated Users from local group Users

Remove-LocalGroupMember -Group "Users" -Member "NT AUTHORITY\INTERACTIVE"
Remove-LocalGroupMember -Group "Users" -Member "NT AUTHORITY\Authenticated Users"

# Restarts the VM

Restart-Computer -Force