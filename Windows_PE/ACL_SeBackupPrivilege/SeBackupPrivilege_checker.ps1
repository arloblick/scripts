<#
Description: Lists running SYSTEM services outside the Windows folder.
Privilege escalation - Server Operators / SeBackupPrivilege.
Default: only Running services, if you want see Running and Stopped change:
remove line 11: $_.State -eq 'Running' -and
update line 17: Select-Object Name, State,

Author:      Grzegorz Chojnowski / ArloBlick
GitHub:      https://github.com/arloblick
#>

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