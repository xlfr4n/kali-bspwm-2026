#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName
)

$ErrorActionPreference = 'Continue'
$fail = 0

function Check([string]$Label, [scriptblock]$Action) {
    try {
        & $Action
        if ($LASTEXITCODE -ne 0) { throw 'non-zero exit code' }
        Write-Host "[OK]   $Label"
    } catch {
        Write-Host "[FAIL] $Label"
        $script:fail++
    }
}

Write-Host '⚡ xLFr4n // AD LAB // BASELINE TEST'
Check 'domain object' { Import-Module ActiveDirectory; Get-ADDomain -Identity $DomainName | Out-Null }
Check 'DNS resolution' { Resolve-DnsName $DomainName -ErrorAction Stop | Out-Null }
Check 'domain controller discovery' { nltest /dsgetdc:$DomainName | Out-Null }
Check 'Lab-Users OU' { Get-ADOrganizationalUnit -Identity "OU=Lab-Users,$((Get-ADDomain).DistinguishedName)" | Out-Null }
Check 'Lab-Groups OU' { Get-ADOrganizationalUnit -Identity "OU=Lab-Groups,$((Get-ADDomain).DistinguishedName)" | Out-Null }
Check 'Lab-Computers OU' { Get-ADOrganizationalUnit -Identity "OU=Lab-Computers,$((Get-ADDomain).DistinguishedName)" | Out-Null }

Write-Host "`nSummary: $fail FAIL"
exit $fail
