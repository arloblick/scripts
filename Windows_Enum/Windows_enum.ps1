<#
Description: Lists Windows antivirus and endpoint security services with their names, status, and executable paths.

Author:      Grzegorz Chojnowski / ArloBlick
GitHub:      https://github.com/arloblick
#>

Get-CimInstance Win32_Service |
Where-Object {
    $_.DisplayName -match 'Defender|WinDefend|Sophos|ESET|Kaspersky|Symantec|Norton|McAfee|Trellix|Trend Micro|Bitdefender|Sentinel|CrowdStrike|Cylance|Palo Alto|Cortex|Fortinet|WithSecure|F-Secure'
} |
Select-Object Name, DisplayName, State, PathName |
Sort-Object DisplayName |
Format-List