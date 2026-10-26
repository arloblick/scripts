# Lists running SYSTEM services outside the Windows folder
# PE - Server Operators SeBackupPrivilege

$windowsPath = '^\s*"?' + [regex]::Escape($env:SystemRoot) + '\\'

Get-CimInstance Win32_Service |
Where-Object {
    $_.State -eq 'Running' -and
    $_.StartName -match '^(LocalSystem|NT AUTHORITY\\SYSTEM)$' -and
    -not [string]::IsNullOrWhiteSpace($_.PathName) -and
    $_.PathName -notmatch $windowsPath -and
    $_.PathName -notmatch '^\s*"?(%SystemRoot%|%windir%|\\SystemRoot)\\'
} |
Select-Object Name,
    @{Name='Privilege Level'; Expression={'LocalSystem (SYSTEM)'}},
    PathName |
Format-Table -AutoSize -Wrap