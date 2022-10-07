# Disables inheritance

$registry = "HKLM:\SYSTEM\CurrentControlSet\Services\BFE"
$acl = Get-Acl $registry
$DisableInheritance=$true
$PreserveInheritanceIfDisabled =$True
$acl.SetAccessRuleProtection($DisableInheritance, $preserveInheritanceIfDisabled)
$acl | Set-Acl -Path $registry

# Break the permissions

$registry = "HKLM:\SYSTEM\CurrentControlSet\Services\BFE\Parameters"
$acl = Get-Acl $registry
$id = "BUILTIN\Users"
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ($id,"FullControl","Deny")
$id1 = "BUILTIN\Administrators"
$rule1 = New-Object System.Security.AccessControl.RegistryAccessRule ($id1,"FullControl","Deny")
$acl.SetAccessRule($rule)
$acl.SetAccessRule($rule1)
$acl | Set-Acl -Path $registry

# Restarts the VM

Restart-Computer -Force
