sc config rdagent start= disabled && sc stop rdagent && sc config WindowsAzureGuestAgent start= disabled && sc stop WindowsAzureGuestAgent && sc delete rdagent && sc delete WindowsAzureGuestAgent
rmdir C:\WindowsAzure /S /Q
