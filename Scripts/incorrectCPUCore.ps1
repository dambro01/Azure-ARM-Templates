# Changes registry to show incorrect CPU core inside the Guest OS

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -name "FeatureSettingsOverride" -value 8192
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -name "FeatureSettingsOverrideMask" -value 325

# Restarts the VM

Restart-Computer -Force