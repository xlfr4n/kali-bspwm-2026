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

function Resolve-VBoxManage {
    $cmd = Get-Command VBoxManage.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $paths = @(
        (Join-Path $env:ProgramFiles 'Oracle\VirtualBox\VBoxManage.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'Oracle\VirtualBox\VBoxManage.exe')
    )
    foreach ($path in $paths) {
        if ($path -and (Test-Path -LiteralPath $path)) { return $path }
    }
    throw 'VBoxManage.exe was not found.'
}
function Invoke-VBox([string]$VBox,[string[]]$Args) {
    & $VBox @Args
    if ($LASTEXITCODE -ne 0) { throw "VBoxManage failed ($LASTEXITCODE)" }
}
$VBox = Resolve-VBoxManage
$all = @(& $VBox list vms)
Write-Host '⚡ xLFr4n // VIRTUALBOX LAB'
Write-Host "VBoxManage: $VBox"
Write-Host "Network: $NetworkName"
Write-Host "Adapter: $AdapterIndex"

if ($Audit -or (-not $Plan -and -not $Apply)) {
    $inspect = if ($VMNames.Count) { $VMNames } else {
        $all | ForEach-Object { if ($_ -match '^"([^"]+)"') { $Matches[1] } }
    }
    foreach ($vm in $inspect) {
        Write-Host "`n[$vm]"
        & $VBox showvminfo $vm --machinereadable |
            Select-String -Pattern '^(name|VMState|nic[0-9]+|intnet[0-9]+|hostonlyadapter[0-9]+|natnetwork[0-9]+)=' |
            ForEach-Object { Write-Host "  $($_.Line)" }
    }
    exit 0
}

if ($VMNames.Count -eq 0) { throw '-VMNames is required for -Plan or -Apply.' }
Write-Host "`n=== PLAN ==="
foreach ($vm in $VMNames) {
    $info = @(& $VBox showvminfo $vm --machinereadable)
    if ($LASTEXITCODE -ne 0) { throw "VM not found: $vm" }
    $state = ($info | Where-Object { $_ -like 'VMState=*' } | Select-Object -First 1)
    Write-Host "  $vm : adapter $AdapterIndex -> Internal Network '$NetworkName' ($state)"
}
if (-not $Apply) { Write-Host '`nPlan only. No changes made.'; exit 0 }

$answer = Read-Host "Type APPLY to modify the selected powered-off VMs"
if ($answer -cne 'APPLY') { throw 'Apply cancelled. Nothing changed.' }
foreach ($vm in $VMNames) {
    $info = @(& $VBox showvminfo $vm --machinereadable)
    $state = ($info | Where-Object { $_ -like 'VMState=*' } | Select-Object -First 1)
    if ($state -notmatch '="poweroff"') { throw "Refusing to modify ${vm}: it must be powered off." }
    Invoke-VBox $VBox @('modifyvm',$vm,"--nic$AdapterIndex",'intnet',"--intnet$AdapterIndex",$NetworkName)
    Write-Host "[OK] $vm -> $NetworkName"
}
Write-Host 'Applied. Run -Audit before booting the lab.'
