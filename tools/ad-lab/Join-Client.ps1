#requires -RunAsAdministrator
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)] [string]$DomainName,
    [string]$ComputerOU = ''
)
$ErrorActionPreference = 'Stop'
Write-Host '⚡ xLFr4n // AD LAB // CLIENT JOIN'
$credential = Get-Credential -Message "Authorized lab domain credentials for $DomainName"
if ([string]::IsNullOrWhiteSpace($ComputerOU)) {
    Add-Computer -DomainName $DomainName -Credential $credential -Force -Restart
} else {
    Add-Computer -DomainName $DomainName -OUPath $ComputerOU -Credential $credential -Force -Restart
}
Write-Host '[OK] Domain join requested.'
