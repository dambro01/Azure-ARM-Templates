@REM https://docs.microsoft.com/en-us/sysinternals/downloads/testlimit
@REM https://docs.microsoft.com/en-us/archive/blogs/vijaysk/tools-to-simulate-cpu-memory-disk-load

@REM Download files
powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12" 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://download.sysinternals.com/files/TestLimit.zip', 'C:\Program Files\Common Files\TestLimit.zip')" 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://aka.ms/perfinsightslatest', 'C:\Program Files\Common Files\PerfInsights.zip')" 

@REM Expand zips
powershell "Expand-Archive -LiteralPath 'C:\Program Files\Common Files\testlimit.zip' -DestinationPath 'C:\Program Files\Common Files\TestLimit'"
powershell "Expand-Archive -LiteralPath 'C:\Program Files\Common Files\PerfInsights.zip' -DestinationPath 'C:\Program Files\Common Files\PerfInsights'"

@REM asynchronously start PerfInsights for 300s
powershell "Start-Process powershell -Verb runAs -ArgumentList {& 'C:\Program Files\Common Files\PerfInsights\PerfInsights.exe' /run advanced xpns /d 300 /AcceptDisclaimerAndShareDiagnostics /sau /outputfolder 'C:\Program Files\Common Files'}"

@REM Increase memory utilization
powershell "& 'C:\Program Files\Common Files\testlimit\testlimit64.exe' -accepteula -d -c -g 0 -h -i -m -p -s -t"
