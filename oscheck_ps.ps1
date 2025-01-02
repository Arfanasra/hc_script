$hostname = $env:COMPUTERNAME
 
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time'
Write-Host "
" 
Write-Host 
"$hostname 
CPU Usage: 
$($cpuUsage.CounterSamples[0].CookedValue)%"
Write-Host ""
 
$memory = Get-WmiObject -Class Win32_OperatingSystem
$totalMemory = [math]::round($memory.TotalVisibleMemorySize / 1024, 2)
$freeMemory = [math]::round($memory.FreePhysicalMemory / 1024, 2) 
$usedMemory = [math]::round($totalMemory - $freeMemory, 2)
$usedMemoryPercentage = [math]::round(($usedMemory / $totalMemory) * 100, 2)  

Write-Host "
" 
Write-Host "$hostname
Total: $totalMemory MB
Used: $usedMemory MB
Used(%): $usedMemoryPercentage"
Write-Host "
"
 
Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -ne 2 -and $_.DriveType -ne 5} | ForEach-Object {
$TotalSpaceMB = [math]::Round($_.Size / 1MB, 2)
$FreeSpaceMB = [math]::Round($_.FreeSpace / 1MB, 2)
$UsedSpaceMB = [math]::round($TotalSpaceMB - $FreeSpaceMB, 2)
$UsedPercent = [math]::Round(($UsedSpaceMB / $TotalSpaceMB) * 100, 2)

Write-Host "
" 
Write-Host "$hostname
Drive $($_.DeviceID)
Total Space: $TotalSpaceMB MB
Free Space: $FreeSpaceMB MB
Used Space: $UsedSpaceMB MB
Used(%): $UsedPercent%"
Write-Host ""
}