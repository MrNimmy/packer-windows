# https://www.petri.com/manage-windows-updates-with-powershell-module

Write-Output "Installing Windows update module"
Install-PackageProvider -Name Nuget -Force
Install-Module PSWindowsUpdate -Force -Confirm:$false
Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false