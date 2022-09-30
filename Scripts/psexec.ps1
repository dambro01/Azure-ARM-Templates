[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
$client = New-Object System.Net.WebClient
$client.DownloadFile("https://download.sysinternals.com/files/PSTools.zip", "C:\Program Files\Common Files\PSTools.zip")
Expand-Archive -LiteralPath "C:\Program Files\Common Files\PSTools.zip" -DestinationPath "C:\Program Files\Common Files\PSTools"
& "C:\Program Files\Common Files\PSTools\psexec.exe" -accepteula -nobanner -s powershell -nologo -noprofile -command "echo 'Hello World'"
