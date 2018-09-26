Write-Output "Downloading and Installing WMF 5.1"

$url = 'http://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu'
$output = 'C:\WMF.msu'

# Download WMF 5.1
(New-Object System.Net.WebClient).DownloadFile($url, $output)

# Install WMF 5.1
Start-Process -FilePath 'C:\Windows\System32\wusa.exe' -ArgumentList 'C:\WMF.msu /quiet /norestart' -Wait

# Remove downloaded file
Remove-Item -Path $output -Force