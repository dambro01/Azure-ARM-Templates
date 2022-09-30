@REM Disable service
sc config WinHttpAutoProxySvc start= disabled && sc stop WinHttpAutoProxySvc

@REM Increase CPU utilization
powershell -noexit "$Script:StressJob = 1..$env:NUMBER_OF_PROCESSORS | foreach {Start-Job {[System.Threading.Thread]::CurrentThread.Priority = 'Highest';while ($true) {$i++};}}"

