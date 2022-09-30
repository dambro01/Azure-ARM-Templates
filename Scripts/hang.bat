@REM Download files
powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12" 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/Azure/repair-script-library/raw/master/src/windows/common/tools/kdbgctrl.exe', 'C:\Program Files\Common Files\kdbgctrl.exe')
powershell "(New-Object System.Net.WebClient).DownloadFile('https://download.sysinternals.com/files/NotMyFault.zip', 'C:\Program Files\Common Files\NotMyFault.zip')

@REM Expand zips
powershell "Expand-Archive -LiteralPath 'C:\Program Files\Common Files\NotMyFault.zip' -DestinationPath 'C:\Program Files\Common Files\NotMyFault'"

@REM trigger dump config
powershell "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' -Name 'DedicatedDumpFile' -Value 'D:\dd.sys'"
powershell "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' -Name 'DumpFile' -Value '%SystemRoot%\Memory.dmp'"
powershell "& 'C:\Program Files\Common Files\kdbgctrl.exe' -sd full"

@REM Trigger crash
powershell "& 'C:\Program Files\Common Files\NotMyFault\NotMyFault64.exe' /hang /accepteula"
