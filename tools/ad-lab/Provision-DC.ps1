#requires -RunAsAdministrator
[CmdletBinding()]
param(
    [string]$DomainName = 'xlfr4n.test',
    [string]$NetBIOSName = 'XLFR4N',
    [string]$LabAdminSam = 'labadmin',
    [string]$TestUserSam = 'labuser'
)
$ErrorActionPreference = 'Stop'
Write-Host '⚡ xLFr4n // AD LAB // DC PROVISION'

function Read-Secret([string]$Prompt) { Read-Host -AsSecureString $Prompt }

if (-not (Get-WindowsFeature AD-Domain-Services).Installed) {
    Install-WindowsFeature AD-Domain-Services,DNS -IncludeManagementTools
}
Import-Module ADDSDeployment
$domain = Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty Domain
if ($domain -ne $DomainName) {
    $dsrm = Read-Secret 'DSRM password'
    Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $NetBIOSName -SafeModeAdministratorPassword $dsrm -InstallDns -NoRebootOnCompletion:$false
    exit 0
}
Import-Module ActiveDirectory
$root = (Get-ADDomain).DistinguishedName

function Ensure-OU([string]$Name) {
    $path = "OU=$Name,$root"
    if (-not (Get-ADOrganizationalUnit -Identity $path -ErrorAction SilentlyContinue)) { New-ADOrganizationalUnit -Name $Name -Path $root | Out-Null }
    return $path
}
$usersOU = Ensure-OU 'Lab-Users'
$groupsOU = Ensure-OU 'Lab-Groups'
Ensure-OU 'Lab-Computers' | Out-Null

$adminPassword = Read-Secret 'Password for labadmin'
$userPassword = Read-Secret 'Password for labuser'
if (-not (Get-ADUser -Filter "SamAccountName -eq '$LabAdminSam'" -ErrorAction SilentlyContinue)) {
    New-ADUser -SamAccountName $LabAdminSam -UserPrincipalName "$LabAdminSam@$DomainName" -Name 'Lab Admin' -AccountPassword $adminPassword -Enabled $true -Path $usersOU | Out-Null
}
if (-not (Get-ADUser -Filter "SamAccountName -eq '$TestUserSam'" -ErrorAction SilentlyContinue)) {
    New-ADUser -SamAccountName $TestUserSam -UserPrincipalName "$TestUserSam@$DomainName" -Name 'Lab User' -AccountPassword $userPassword -Enabled $true -Path $usersOU | Out-Null
}
if (-not (Get-ADGroup -Identity 'Lab-Operators' -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name 'Lab-Operators' -GroupScope Global -GroupCategory Security -Path $groupsOU | Out-Null
}
Add-ADGroupMember -Identity 'Lab-Operators' -Members $LabAdminSam -ErrorAction SilentlyContinue
Write-Host '[OK] AD lab baseline created.'
Write-Host '[INFO] Re-run after promotion/reboot to finish OUs and accounts.'
