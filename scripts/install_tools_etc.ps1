

# adding a sysprep script to c:\scripts. This will set the winrm service to start manually
# https://github.com/mwrock/packer-templates/issues/49
Write-Host "Add sysprep script to c:\scripts to call when Packer performs a shutdown."
$SysprepCmd = @"
sc config winrm start=demand
C:/windows/system32/sysprep/sysprep.exe /generalize /oobe /unattend:C:/scripts/unattend.xml /quiet /shutdown
"@

Set-Content -path "C:\Scripts\sysprep.cmd" -Value $SysprepCmd

# Set the winrm service to auto upon first boot
# https://technet.microsoft.com/en-us/library/cc766314(v=ws.10).aspx
$SetupComplete = @"
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm
"@

New-Item -Path 'C:\Windows\Setup\Scripts' -ItemType Directory -Force
Set-Content -path "C:\Windows\Setup\Scripts\SetupComplete.cmd" -Value $SetupComplete


# Install chocolatey
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install VBox Additions
foreach ($drive in $(Get-PSDrive -PSProvider Filesystem).Root) {
  if (Test-Path $($drive + 'VBoxWindowsAdditions.exe')) {
    Write-Host "Installing VBoxWindowsAdditions"
    Start-Process -FilePath $($drive + 'VBoxWindowsAdditions.exe') -ArgumentList  '/S' -Wait
    Write-Host "Sleeping for 60 seconds so we are sure the tools are installed before reboot"
    Start-Sleep -Seconds 60
  }
}