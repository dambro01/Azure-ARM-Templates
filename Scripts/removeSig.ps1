# https://stackpointer.io/windows/remove-digital-signature-dll-exe/440/
# https://blog.didierstevens.com/programs/disitool/

# Install Chocolatey & Python
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install -y python3

# Download and extract tools
$destinationZip = "$($env:CommonProgramFiles)\pefile-2022.5.30.zip"
$destinationZip2 = "$($env:CommonProgramFiles)\disitool_v0_4.zip"
$pefile = "$($env:CommonProgramFiles)\pefile"
$disitool = "$($env:CommonProgramFiles)\disitool"
$driver = "C:\Windows\system32\drivers\intelide.sys"
(New-Object System.Net.WebClient).DownloadFile("https://github.com/erocarrera/pefile/releases/download/v2022.5.30/pefile-2022.5.30.zip", $destinationZip)
(New-Object System.Net.WebClient).DownloadFile("https://didierstevens.com/files/software/disitool_v0_4.zip", $destinationZip2)
Expand-Archive -LiteralPath $destinationZip -DestinationPath $pefile -Force
Expand-Archive -LiteralPath $destinationZip2 -DestinationPath $disitool -Force

# Remove digital signature
Set-Location "$pefile\pefile-2022.5.30"
python setup.py install
Set-Location $disitool
Copy-Item -Path $driver
python disitool.py delete intelide.sys intelide.sys-unsigned.sys
Move-Item -Path "intelide.sys" -Force "$($env:CommonProgramFiles)"
Rename-Item -Path "intelide.sys-unsigned.sys" -NewName "intelide.sys"
Rename-Item -Path $driver -NewName "intelide2.sys" -Force
Move-Item -Path "intelide.sys" $driver -Force
