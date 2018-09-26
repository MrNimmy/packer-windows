# This script is called from Autounattend.xml

Write-Host "Copy unattend.xml to C:\Scripts\"
New-Item c:\Scripts -Type Directory
Copy-Item a:\unattend.xml C:\Scripts\

Copy-Item a:\oracle.cer c:\Scripts
certutil -addstore -f "TrustedPublisher" c:\Scripts\oracle.cer

Write-Output "Settings all network connections to private"
$networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]'{DCB00C01-570F-4A9B-8D69-199FDBA5723B}'))
$connections = $networkListManager.GetNetworkConnections()
$connections | foreach {$_.GetNetwork().SetCategory(1)}


Write-Output "Enable WinRM"
netsh advfirewall firewall set rule group="remote administration" new enable=yes
netsh advfirewall firewall add rule name="Open Port 5985" dir=in action=allow protocol=TCP localport=5985

winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="0"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="0"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'

net stop winrm
sc.exe config winrm start= auto
net start winrm
