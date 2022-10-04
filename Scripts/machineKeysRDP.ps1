# Creates a backup of current permisisons to C:\temp\
md C:\temp
icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /save c:\temp\machinekeys /T

# Breaks the permissions

takeown /f "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys" /a /r
icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /remove "NT AUTHORITY\System"
icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /remove "BUILTIN\Administrators"
icacls C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys /remove "NT AUTHORITY\NETWORK SERVICE"

# Changes the ownership of MachineKeys

$ACL = Get-Acl -Path "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys"
$acl.Access | %{$acl.RemoveAccessRule($_)}
$User = New-Object System.Security.Principal.Ntaccount("NT AUTHORITY\NETWORK SERVICE")
$ACL.SetOwner($User)
$ACL | Set-Acl -Path "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys"
Get-ACL -Path "C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys"

# Deletes the current RDP certificate

Import-Module PKI
Set-Location Cert:\LocalMachine
$RdpCertThumbprint = 'Cert:\LocalMachine\Remote Desktop\'+((Get-ChildItem -Path 'Cert:\LocalMachine\Remote Desktop\').thumbprint)
Remove-Item -Path $RdpCertThumbprint
Restart-Service termservice -Force