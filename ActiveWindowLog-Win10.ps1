Add-Type @"
using System;
using System.Runtime.InteropServices;

public static class GetActiveWindow {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
}
"@

$logFile = "C:\Users\abcdefg\Downloads\activeapplication.log"

while ($true) {
$activeWindow = [GetActiveWindow]::GetForegroundWindow()
$processId = 0
$result = [GetActiveWindow]::GetWindowThreadProcessId($activeWindow, [ref]$processId)
$process = Get-Process -Id $processId | Select-Object -Property ProcessName,MainWindowTitle
$logMessage = "$(Get-Date),$process.ProcessName,$process.MainWindowTitle,$process.StartInfo.Arguments"
#   $logMessage = "{0}: {1} : {2}" -f $process.ProcessName, $process.MainWindowTitle, $process.StartInfo.Arguments
Add-Content $logFile $logMessage
#   Write-Host "Active window handle: $activeWindow"
#   Write-Host "Result: $result"
#   Write-Host "Process ID: $processId"
#   Write-Host "Command Line: $($process.StartInfo.Arguments)"
Start-Sleep -Seconds 180
}
