# Corrupts the user profie

param(
        [Parameter(Mandatory = $true)][string]$profile,
        [Parameter(Mandatory = $true)][securestring]$securePassword
    )

Start-Sleep -Seconds 30
# $profile = Get-Content "C:\Packages\Plugins\Microsoft.CPlat.Core.RunCommandHandlerWindows\2.0.5\Downloads\username.txt" -First 1
# $password = Get-Content "C:\Packages\Plugins\Microsoft.CPlat.Core.RunCommandHandlerWindows\2.0.5\Downloads\password.txt" -First 1

$username = "$env:USERDOMAIN\" + "$profile"

# [securestring]$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $securePassword
$time = [DateTime]::Now.AddSeconds(15)
$Trigger = New-ScheduledTaskTrigger -Once -At $time
$Action = New-ScheduledTaskAction -Execute "notepad.exe"

# Using Invoke-Command to Execute the Register-ScheduledTask cmdlet under the local admin account because System doesn't have the correct permissions

Invoke-Command -Credential $cred -ComputerName $env:ComputerName -ScriptBlock {

	param($username, $password, $Trigger, $Action)

	Register-ScheduledTask -User $username -Password $password -TaskName "openNotepad" -Trigger $Trigger -Action $Action -Force

} -Args $username, $password, $Trigger, $Action


mkdir c:\temp

Set-Location C:\temp\
$registry = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" -Recurse
Foreach ($a in $registry) {
	$a.Property | ForEach-Object {
		If ($a.GetValue($_) -eq ("C:\Users\" + $profile)) {
			$path = $a.PSChildName
			Invoke-Command { reg export ("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" + $path) regbck.reg }
			Rename-Item -Path ("HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" + $path) -NewName ($path + ".bak")
			Invoke-Command { reg import regbck.reg }
			Set-ItemProperty -Path ("HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" + $path) -Name "ProfileImagePath" -Value ("C:\Users\" + $profile + "1")
		}
	}
}