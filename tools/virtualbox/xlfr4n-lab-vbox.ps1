#requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$Audit,
    [switch]$Plan,
    [switch]$Apply,
    [string]$NetworkName = 'XLFR4N-LAB',
    [string[]]$VMNames = @(),
    [ValidateRange(1,8)]
    [int]$AdapterIndex = 2
)

$ErrorActionPreference = 'Stop'

function Write-Section([string]$Text) { Write-Host "`n=== $Text ===" }

function Resolve-VBoxManage {
    $cmd = Get-Command VBoxManage.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $candidates = @(
        (Join-Path ${env:ProgramFiles} 'Oracle\VirtualBox\VBoxManage.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'Oracle\VirtualBox\VBoxManage.exe')
    )
    foreach ($path in $candidates) {
        if ($path -and (Test-Path -LiteralPath $path)) { return $path }
    }
    throw 'VBoxManage.exe was not found. Install VirtualBox or add its directory to PATH.'
}

function Invoke-VBox([string]$VBox, [string[]]$Args) {
    & $VBox @Args
    if ($LASTEXITCODE -ne 0) { throw "VBoxManage failed ($LASTEXITCODE): $($Args -join ' ')" }
}

$VBox = Resolve-VBoxManage
$allVms = @(& $VBox list vms)
$running = @(& $VBox list runningvms)

Write-Section 'Host'
Write-Host "VBoxManage: $VBox"
Write-Host "Network:    $NetworkName"
Write-Host "Adapter:    $AdapterIndex"

Write-Host 'Registered VMs:'
if ($allVms.Count -eq 0) {
    Write-Host '  None'
} else {
    $allVms | ForEach-Object { Write-Host "  $_" }
}

Write-Section 'Running VMs'
if ($running.Count -eq 0) {
    Write-Host 'None'
} else {
    $running | ForEach-Object { Write-Host "  $_" }
}

if ($Audit -or (-not $Plan -and -not $Apply)) {
    Write-Section 'Adapter audit'
    $inspect = if ($VMNames.Count -gt 0) {
        $VMNames
    } else {
        $allVms | ForEach-Object {
            if ($_ -match '^"([^"]+)"') { $Matches[1] }
        }
    }
    foreach ($vm in $inspect) {
        Write-Host "`n[$vm]"
        & $VBox showvminfo $vm --machinereadable |
            Select-String -Pattern '^(name|VMState|nic[0-9]+|intnet[0-9]+|hostonlyadapter[0-9]+|natnetwork[0-9]+)=' |
            ForEach-Object { Write-Host "  $($_.Line)" }
    }
}

if ($Plan -or $Apply) {
    if ($VMNames.Count -eq 0) {
        throw '-VMNames is required for -Plan or -Apply. Example: -VMNames Kali,DC01,WS01,WEB01'
    }
    Write-Section 'Plan'
    foreach ($vm in $VMNames) {
        $info = @(& $VBox showvminfo $vm --machinereadable)
        if ($LASTEXITCODE -ne 0) { throw "VM not found: $vm" }
        $stateLine = $info | Where-Object { $_ -like 'VMState=*' } | Select-Object -First 1
        $state = if ($stateLine -match '="([^"]+)"') { $Matches[1] } else { 'unknown' }
        Write-Host "  $vm : adapter $AdapterIndex -> Internal Network '$NetworkName' (state=$state)"
        if ($state -ne 'poweroff') {
            Write-Warning "VM '$vm' is not powered off; Apply mode will refuse to modify it."
        }
    }
    if (-not $Apply) {
        Write-Host "`nPlan only. No changes were made."
        exit 0
    }
}

if ($Apply) {
    Write-Section 'Apply'
    $confirmation = Read-Host "Type APPLY to attach the selected VMs to Internal Network '$NetworkName'"
    if ($confirmation -cne 'APPLY') { throw 'Apply cancelled. Nothing changed.' }

    foreach ($vm in $VMNames) {
        $info = @(& $VBox showvminfo $vm --machinereadable)
        $stateLine = $info | Where-Object { $_ -like 'VMState=*' } | Select-Object -First 1
        if ($stateLine -notmatch '="poweroff"') {
            throw "Refusing to modify '$vm': VM must be powered off."
        }
        Invoke-VBox $VBox @('modifyvm', $vm, "--nic$AdapterIndex", 'intnet', "--intnet$AdapterIndex", $NetworkName)
        Write-Host "[OK] $vm adapter $AdapterIndex -> Internal Network '$NetworkName'"
    }
    Write-Host "`nApplied. Run this script with -Audit before booting the lab."
}
