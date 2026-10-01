#requires -Version 5.1
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$DomainName)
$ErrorActionPreference = 'Continue'
$fail = 0
function Check([string]$Label,[scriptblock]$Action) {
    try { & $Action; Write-Host "[OK]   $Label" } catch { Write-Host "[FAIL] $Label"; $script:fail++ }
}
Write-Host '⚡ xLFr4n // AD LAB // BASELINE'
Check 'AD domain' { Import-Module ActiveDirectory; Get-ADDomain -Identity $DomainName | Out-Null }
Check 'DNS' { Resolve-DnsName $DomainName -ErrorAction Stop | Out-Null }
Check 'DC discovery' { nltest /dsgetdc:$DomainName | Out-Null }
Check 'Lab-Users OU' { Get-ADOrganizationalUnit -LDAPFilter '(ou=Lab-Users)' | Select-Object -First 1 | Out-Null }
Check 'Lab-Groups OU' { Get-ADOrganizationalUnit -LDAPFilter '(ou=Lab-Groups)' | Select-Object -First 1 | Out-Null }
Write-Host "`nSummary: $fail FAIL"
exit $fail
