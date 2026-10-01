#requires -RunAsAdministrator
[CmdletBinding()]
param(
    [string]$DomainName = 'xlfr4n.test',
    [string]$NetBIOSName = 'XLFR4N',
    [string]$LabAdminSam = 'labadmin',
    [string]$TestUserSam = 'labuser'
)

$ErrorActionPreference = 'Stop'

function Read-RequiredSecret([string]$Prompt) {
    do { $value = Read-Host -AsSecureString $Prompt } while (-not $value)
    return $value
}

Write-Host '⚡ xLFr4n // AD LAB // DC PROVISION'
Write-Host "Domain: $DomainName"

$feature = Get-WindowsFeature -Name AD-Domain-Services
if (-not $feature.Installed) {
    Write-Host '[*] Installing AD DS and DNS roles...'
    Install-WindowsFeature AD-Domain-Services,DNS -IncludeManagementTools
}

Import-Module ADDSDeployment

$existingDomain = Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty Domain
if ($existingDomain -ne $DomainName) {
    Write-Host '[*] Promoting this server to a new lab forest...'
    $safeModePassword = Read-RequiredSecret 'DSRM password'
    Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $NetBIOSName -SafeModeAdministratorPassword $safeModePassword -InstallDns -NoRebootOnCompletion:$false
    exit 0
}

Import-Module ActiveDirectory
Write-Host '[*] Domain detected. Creating lab OUs and accounts...'

function Ensure-OU([string]$Name, [string]$Path) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$Name)" -SearchBase $Path -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $Name -Path $Path | Out-Null
    }
}

$root = (Get-ADDomain).DistinguishedName
Ensure-OU 'Lab-Users' $root
Ensure-OU 'Lab-Groups' $root
Ensure-OU 'Lab-Computers' $root

$usersPath = "OU=Lab-Users,$root"
$groupsPath = "OU=Lab-Groups,$root"
$computersPath = "OU=Lab-Computers,$root"

$labAdminPassword = Read-RequiredSecret 'Password for labadmin'
$testUserPassword = Read-RequiredSecret 'Password for labuser'

if (-not (Get-ADUser -Filter "SamAccountName -eq '$LabAdminSam'" -ErrorAction SilentlyContinue)) {
    New-ADUser -SamAccountName $LabAdminSam -UserPrincipalName "$LabAdminSam@$DomainName" -Name 'Lab Admin' -AccountPassword $labAdminPassword -Enabled $true -Path $usersPath | Out-Null
}
if (-not (Get-ADUser -Filter "SamAccountName -eq '$TestUserSam'" -ErrorAction SilentlyContinue)) {
    New-ADUser -SamAccountName $TestUserSam -UserPrincipalName "$TestUserSam@$DomainName" -Name 'Lab User' -AccountPassword $testUserPassword -Enabled $true -Path $usersPath | Out-Null
}

$group = Get-ADGroup -Identity 'Lab-Operators' -ErrorAction SilentlyContinue
if (-not $group) { $group = New-ADGroup -Name 'Lab-Operators' -GroupScope Global -GroupCategory Security -Path $groupsPath; }
Add-ADGroupMember -Identity $group -Members $LabAdminSam -ErrorAction SilentlyContinue

Set-ADDefaultDomainPasswordPolicy -Identity (Get-ADDomain).DistinguishedName -MinPasswordLength 12 -ComplexityEnabled $true -PasswordHistoryCount 5 -MaxPasswordAge (New-TimeSpan -Days 30)

Write-Host '[OK] Domain controller baseline created.'
Write-Host "[OK] OUs: $usersPath / $groupsPath / $computersPath"
Write-Host "[OK] Lab accounts: $LabAdminSam, $TestUserSam"
