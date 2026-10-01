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
        (Join-Path \${env:ProgramFiles(x86)} 'Oracle\VirtualBox\VBoxManage.exe')
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
function Get-Field([string[]]$Info,[string]$Name) {
    $line = $Info | Where-Object { $_ -like "$Name=*" } | Select-Object -First 1
    if ($line -match '="(.*)"') { return $Matches[1] }
    return ($line -replace '^[^=]+=','')
}
function Invoke-VBox([string]$VBox,[string[]]$Args) {
    & $VBox @Args
    if ($LASTEXITCODE -ne 0) { throw "VBoxManage failed ($LASTEXITCODE)" }
}

$VBox = Resolve-VBoxManage
$all = @(& $VBox list vms)
if ($LASTEXITCODE -ne 0) { throw 'Could not list VirtualBox VMs.' }

Write-Host '⚡ xLFr4n // VIRTUALBOX LAB'
Write-Host "VBoxManage: $VBox"
Write-Host "Network: $NetworkName"
Write-Host "Adapter: $AdapterIndex"

if ($Audit -or (-not $Plan -and -not $Apply)) {
    $inspect = if ($VMNames.Count) { $VMNames } else {
        $all | ForEach-Object { if ($_ -match '^"([^"]+)"') { $Matches[1] } }
    }
    foreach ($vm in $inspect) {
        $info = Get-VMInfo $VBox $vm
        Write-Host ""
        Write-Host "[$vm]"
        Write-Host "  VMState=$((Get-Field $info 'VMState'))"
        Write-Host "  nic$AdapterIndex=$((Get-Field $info "nic$AdapterIndex"))"
        Write-Host "  intnet$AdapterIndex=$((Get-Field $info "intnet$AdapterIndex"))"
        $info |
            Select-String -Pattern "^(nic[0-9]+|intnet[0-9]+|natnetwork[0-9]+|hostonlyadapter[0-9]+|cableconnected[0-9]+)=" |
            ForEach-Object { Write-Host "  $($_.Line)" }
    }
    exit 0
}

if ($VMNames.Count -eq 0) { throw '-VMNames is required for -Plan or -Apply.' }

$seen = @{}
$plan = foreach ($vm in $VMNames) {
    if ($seen.ContainsKey($vm)) { throw "Duplicate VM name in -VMNames: $vm" }
    $seen[$vm] = $true
    $info = Get-VMInfo $VBox $vm
    [pscustomobject]@{
        Name = $vm
        State = Get-Field $info 'VMState'
        Nic = Get-Field $info "nic$AdapterIndex"
        IntNet = Get-Field $info "intnet$AdapterIndex"
    }
}

Write-Host ""
Write-Host '=== PLAN ==='
$plan | ForEach-Object {
    Write-Host ("  {0} : state={1} adapter {2} ({3}) -> Internal Network '{4}'" -f $_.Name, $_.State, $AdapterIndex, $_.Nic, $NetworkName)
}

if (-not $Apply) {
    Write-Host ""
    Write-Host 'Plan only. No changes made.'
    exit 0
}

$notPoweredOff = @($plan | Where-Object { $_.State -ne 'poweroff' })
if ($notPoweredOff.Count -gt 0) {
    $names = ($notPoweredOff | ForEach-Object { "$($_.Name)=$($_.State)" }) -join ', '
    throw "Refusing to modify any VM: all selected VMs must be powered off. Current states: $names"
}

$answer = Read-Host "Type APPLY to modify the selected powered-off VMs"
if ($answer -cne 'APPLY') { throw 'Apply cancelled. Nothing changed.' }

foreach ($vm in $plan) {
    Invoke-VBox $VBox @('modifyvm',$vm.Name,"--nic$AdapterIndex",'intnet',"--intnet$AdapterIndex",$NetworkName)
    Write-Host "[OK] $($vm.Name) -> $NetworkName"
}

foreach ($vm in $plan) {
    $info = Get-VMInfo $VBox $vm.Name
    $nic = Get-Field $info "nic$AdapterIndex"
    $intnet = Get-Field $info "intnet$AdapterIndex"
    if ($nic -ne 'intnet' -or $intnet -ne $NetworkName) {
        throw "Post-apply verification failed for $($vm.Name): nic$AdapterIndex=$nic intnet$AdapterIndex=$intnet"
    }
}
Write-Host '[OK] Applied and verified. Run -Audit before booting the lab.'
