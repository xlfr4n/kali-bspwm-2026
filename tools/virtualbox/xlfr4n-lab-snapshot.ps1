#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)] [string]$VMName,
    [switch]$List,
    [switch]$Plan,
    [switch]$Apply,
    [string]$SnapshotName = '',
    [string]$LogPath = ''
)
$ErrorActionPreference = 'Stop'

function Resolve-VBoxManage {
    $cmd = Get-Command VBoxManage.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $paths = @(
        (Join-Path $env:ProgramFiles 'Oracle\VirtualBox\VBoxManage.exe'),
        (Join-Path \${env:ProgramFiles(x86)} 'Oracle\VirtualBox\VBoxManage.exe')
    )
    foreach ($path in $paths) { if ($path -and (Test-Path -LiteralPath $path)) { return $path } }
    throw 'VBoxManage.exe was not found.'
}
function Get-VMInfo([string]$VBox,[string]$VM) {
    $info = @(& $VBox showvminfo $VM --machinereadable)
    if ($LASTEXITCODE -ne 0) { throw "VM not found: $VM" }
    return $info
}
function Get-State([string]$VBox,[string]$VM) {
    $info = Get-VMInfo $VBox $VM
    $line = $info | Where-Object { $_ -like 'VMState=*' } | Select-Object -First 1
    if ($line -match '="([^"]+)"') { return $Matches[1] }
    return 'unknown'
}
function Get-SnapshotNames([string]$VBox,[string]$VM) {
    $output = @(& $VBox snapshot $VM list)
    if ($LASTEXITCODE -ne 0) { throw 'Snapshot listing failed.' }
    return @($output | ForEach-Object {
        if ($_ -match '^Name:\s*(.+?)(?:\s+\(UUID:.*)?$') { $Matches[1].Trim() }
    })
}
function Write-ResetLog([string]$Path,[string]$VM,[string]$Snapshot) {
    if ([string]::IsNullOrWhiteSpace($Path)) { return }
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    Add-Content -LiteralPath $Path -Value (
        "[{0}] snapshot-reset VM={1} snapshot={2} result=success" -f (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssK'), $VM, $Snapshot
    )
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
$snapshots = Get-SnapshotNames $VBox $VMName
Write-Host "State: $state"
Write-Host "Snapshot: $snapshot"

if ($snapshots -notcontains $snapshot) {
    $available = if ($snapshots.Count) { $snapshots -join ', ' } else { 'none' }
    throw "Snapshot '$snapshot' was not found on '$VMName'. Available: $available"
}

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

Write-ResetLog $LogPath $VMName $snapshot
Write-Host "[OK] Snapshot restored: $VMName -> $snapshot"
if ($LogPath) { Write-Host "[OK] Reset log: $LogPath" }
