#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)] [string]$VMName,
    [switch]$List,
    [switch]$Plan,
    [switch]$Apply,
    [string]$SnapshotName = ''
)
$ErrorActionPreference = 'Stop'

function Resolve-VBoxManage {
    $cmd = Get-Command VBoxManage.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $paths = @(
        (Join-Path $env:ProgramFiles 'Oracle\VirtualBox\VBoxManage.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'Oracle\VirtualBox\VBoxManage.exe')
    )
    foreach ($path in $paths) { if ($path -and (Test-Path -LiteralPath $path)) { return $path } }
    throw 'VBoxManage.exe was not found.'
}
function Get-State([string]$VBox,[string]$VM) {
    $info = @(& $VBox showvminfo $VM --machinereadable)
    if ($LASTEXITCODE -ne 0) { throw "VM not found: $VM" }
    $line = $info | Where-Object { $_ -like 'VMState=*' } | Select-Object -First 1
    if ($line -match '="([^"]+)"') { return $Matches[1] }
    return 'unknown'
}
$VBox = Resolve-VBoxManage
Write-Host '⚡ xLFr4n // VIRTUALBOX SNAPSHOT CONTROL'
Write-Host "VM: $VMName"

if ($List) {
    & $VBox snapshot $VMName list
    if ($LASTEXITCODE -ne 0) { throw 'Snapshot listing failed.' }
    exit 0
}

[string]$snapshot = $SnapshotName
if ([string]::IsNullOrWhiteSpace($snapshot)) {
    throw '-SnapshotName is required unless -List is used.'
}
$state = Get-State $VBox $VMName
Write-Host "State: $state"
Write-Host "Snapshot: $snapshot"
Write-Host 'Action: restore snapshot'

if (-not $Apply) {
    Write-Host 'Plan only. No snapshot state changed.'
    exit 0
}
if ($state -ne 'poweroff') { throw "Refusing to restore '$VMName': VM must be powered off." }
$answer = Read-Host "Type RESET to restore '$snapshot' on '$VMName'"
if ($answer -cne 'RESET') { throw 'Reset cancelled. Nothing changed.' }
& $VBox snapshot $VMName restore $snapshot
if ($LASTEXITCODE -ne 0) { throw 'Snapshot restore failed.' }
Write-Host "[OK] Snapshot restored: $VMName -> $snapshot"
