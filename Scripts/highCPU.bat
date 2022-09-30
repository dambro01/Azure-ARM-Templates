@REM Download PerfInsights
powershell "(New-Object System.Net.WebClient).DownloadFile('https://aka.ms/perfinsightslatest', 'C:\Program Files\Common Files\PerfInsights.zip')" 

@REM Expand zip
powershell "Expand-Archive -LiteralPath 'C:\Program Files\Common Files\PerfInsights.zip' -DestinationPath 'C:\Program Files\Common Files\PerfInsights'"

@REM asynchronously start PerfInsights for 60s
powershell "Start-Process powershell -Verb runAs -ArgumentList {& 'C:\Program Files\Common Files\PerfInsights\PerfInsights.exe' /run advanced xpns /d 60 /AcceptDisclaimerAndShareDiagnostics /sau /outputfolder 'C:\Program Files\Common Files'}"

@REM Increase CPU utilization
powershell -noexit "$Script:StressJob = 1..$env:NUMBER_OF_PROCESSORS | foreach {Start-Job {[System.Threading.Thread]::CurrentThread.Priority = 'Highest';while ($true) {$i++};}}"
