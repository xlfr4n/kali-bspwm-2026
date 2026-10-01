#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)] [string]$VMName,
    [switch]$List,
    [switch]$Create,
    [switch]$Plan,
    [switch]$Apply,
    [string]$SnapshotName = '',
    [string]$LogPath = ''
)
$ErrorActionPreference = 'Stop'

function Resolve-VBoxManage {
    $cmd = Get-Command VBoxManage.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $x86 = [Environment]::GetEnvironmentVariable('ProgramFiles(x86)')
    $paths = @(
        (Join-Path $env:ProgramFiles 'Oracle\VirtualBox\VBoxManage.exe'),
        (Join-Path $x86 'Oracle\VirtualBox\VBoxManage.exe')
    )
    foreach ($path in $paths) {
        if ($path -and (Test-Path -LiteralPath $path)) { return $path }
    }
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
    return @(
        $output | ForEach-Object {
            if ($_ -match '^Name:\s*(.+?)(?:\s+\(UUID:.*)?$') { $Matches[1].Trim() }
        }
    )
}

function Write-ResetLog([string]$Path,[string]$Action,[string]$VM,[string]$Snapshot) {
    if ([string]::IsNullOrWhiteSpace($Path)) { return }
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    Add-Content -LiteralPath $Path -Value (
        "[{0}] snapshot-{1} VM={2} snapshot={3} result=success" -f (Get-Date -Format 'yyyy-MM-ddTHH:mm:ssK'), $Action, $VM, $Snapshot
    )
}

$VBox = Resolve-VBoxManage
Write-Host '⚡ xLFr4n // VIRTUALBOX SNAPSHOT CONTROL'
Write-Host "VM: $VMName"

if ($List) {
    if ($Create -or $Apply -or $Plan) { throw '-List cannot be combined with -Create, -Plan or -Apply.' }
    & $VBox snapshot $VMName list
    if ($LASTEXITCODE -ne 0) { throw 'Snapshot listing failed.' }
    exit 0
}

if ($Create -and $Apply -and $Plan) { throw '-Create cannot combine -Plan and -Apply together.' }
[string]$snapshot = $SnapshotName
if ([string]::IsNullOrWhiteSpace($snapshot)) { throw '-SnapshotName is required unless -List is used.' }

$state = Get-State $VBox $VMName
Write-Host "State: $state"
Write-Host "Snapshot: $snapshot"

if ($Create) {
    if ($state -ne 'poweroff') { throw "Refusing to create '$snapshot' on '$VMName': VM must be powered off." }
    $snapshots = Get-SnapshotNames $VBox $VMName
    if ($snapshots -contains $snapshot) {
        throw "Snapshot '$snapshot' already exists on '$VMName'. No changes made."
    }

    Write-Host 'Action: create snapshot'
    if (-not $Apply) {
        Write-Host 'Plan only. No snapshot state changed.'
        exit 0
    }

    $answer = Read-Host "Type CREATE to create '$snapshot' on '$VMName'"
    if ($answer -cne 'CREATE') { throw 'Snapshot creation cancelled. Nothing changed.' }

    & $VBox snapshot $VMName take $snapshot --description "⚡ xLFr4n baseline"
    if ($LASTEXITCODE -ne 0) { throw 'Snapshot creation failed.' }

    Write-ResetLog $LogPath 'create' $VMName $snapshot
    Write-Host "[OK] Snapshot created: $VMName -> $snapshot"
    if ($LogPath) { Write-Host "[OK] Snapshot log: $LogPath" }
    exit 0
}

$snapshots = Get-SnapshotNames $VBox $VMName
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

Write-ResetLog $LogPath 'restore' $VMName $snapshot
Write-Host "[OK] Snapshot restored: $VMName -> $snapshot"
if ($LogPath) { Write-Host "[OK] Reset log: $LogPath" }
