Param(
	[Parameter(Mandatory = $true,
		HelpMessage = "Name of the Storage Account")]
	[ValidateNotNullOrEmpty()]
	[string]$storageAccountName,

	[Parameter(Mandatory = $true,
		HelpMessage = "Name of the file share within the storage account")]
	[ValidateNotNullOrEmpty()]
	[string]$fileShareName,

	[Parameter(Mandatory = $true,
		HelpMessage = "The storage account key")]
	[ValidateNotNullOrEmpty()]
	[string]$storageAccountKey
)

Add-Content -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\mount.bat" -Value "powershell ""& 'C:\Program Files\Common Files\mount.ps1'""";
Add-Content -Path "C:\Program Files\Common Files\mount.ps1" -Value "cmdkey /add:$storageAccountName.file.core.windows.net /user:localhost\$storageAccountName /pass:$storageAccountKey; net use Z: \\$storageAccountName.file.core.windows.net\$fileShareName /persistent:yes";
