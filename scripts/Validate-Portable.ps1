[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$InputArchive,
    [Parameter(Mandatory = $true)][string]$OutputArchive,
    [Parameter(Mandatory = $true)][ValidatePattern('^[0-9a-fA-F]{40}$')][string]$Commit,
    [Parameter(Mandatory = $true)][string]$BuildRunUrl
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$repoRoot = Split-Path -Parent $PSScriptRoot
$reportDir = Join-Path $repoRoot '.build/reports'
New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
$required = @('DJIMicKey.exe', 'DJIMicKey.Shell.dll', 'WINDOWS.md', 'WIN11_TROUBLESHOOTING.md', 'SHELL_VOLUME_FILTER.md', 'VALIDATION.md', 'LICENSE')
$testReadme = 'READ-ME-FIRST-WINDOWS-TEST.md'

function Assert-X64Pe([byte[]]$Bytes, [string]$Name) {
    if ($Bytes.Length -lt 64 -or $Bytes[0] -ne 0x4D -or $Bytes[1] -ne 0x5A) {
        throw "$Name does not contain a DOS/PE header."
    }
    $pe = [BitConverter]::ToInt32($Bytes, 0x3C)
    if ($pe -lt 64 -or $pe -gt $Bytes.Length - 26 -or [BitConverter]::ToUInt32($Bytes, $pe) -ne 0x4550) {
        throw "$Name contains an invalid PE signature or offset."
    }
    if ([BitConverter]::ToUInt16($Bytes, $pe + 4) -ne 0x8664 -or [BitConverter]::ToUInt16($Bytes, $pe + 24) -ne 0x20B) {
        throw "$Name is not an x86-64 PE32+ binary."
    }
    $isDll = ([BitConverter]::ToUInt16($Bytes, $pe + 22) -band 0x2000) -ne 0
    if (($Name -eq 'DJIMicKey.Shell.dll') -ne $isDll) {
        throw "$Name has an unexpected EXE/DLL PE characteristic."
    }
}

function Assert-PortableArchive([string]$Path, [bool]$IncludeTestFiles) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing archive: $Path" }
    $archive = [System.IO.Compression.ZipFile]::OpenRead($Path)
    try {
        $expected = $required
        if ($IncludeTestFiles) { $expected += @($testReadme, 'BUILD-INFO.txt') }
        $names = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
        foreach ($entry in $archive.Entries) {
            if ($entry.FullName -match '[/\\:]' -or $entry.FullName -in @('', '.', '..') -or -not $names.Add($entry.FullName)) {
                throw "Unexpected directory, duplicate or unsafe ZIP entry: $($entry.FullName)"
            }
            if ($entry.FullName -cnotin $expected) {
                throw 'Portable ZIP contains a file outside the program/documentation allowlist.'
            }
        }
        foreach ($name in $expected) {
            if (-not $names.Contains($name)) { throw "Portable ZIP is missing its root file: $name" }
            $entry = @($archive.Entries | Where-Object { $_.FullName -ceq $name })
            if ($entry.Count -ne 1 -or $entry[0].Length -eq 0) { throw "Missing, empty or incorrectly cased ZIP entry: $name" }
        }
        foreach ($name in @('DJIMicKey.exe', 'DJIMicKey.Shell.dll')) {
            $stream = $archive.GetEntry($name).Open()
            $buffer = [System.IO.MemoryStream]::new()
            try {
                $stream.CopyTo($buffer)
                Assert-X64Pe -Bytes $buffer.ToArray() -Name $name
            } finally {
                $buffer.Dispose()
                $stream.Dispose()
            }
        }
    } finally {
        $archive.Dispose()
    }
}

$inputPath = (Resolve-Path -LiteralPath $InputArchive).Path
$outputPath = [System.IO.Path]::GetFullPath($OutputArchive)
if ($inputPath -eq $outputPath) { throw 'Use a separate output path for the test package.' }
$stage = Join-Path $repoRoot ('.build/portable-check-' + [Guid]::NewGuid().ToString('N'))
try {
    Assert-PortableArchive -Path $inputPath -IncludeTestFiles $false
    [System.IO.Compression.ZipFile]::ExtractToDirectory($inputPath, $stage)
    Copy-Item -LiteralPath (Join-Path $repoRoot 'docs/WINDOWS_TEST_BUILD.md') -Destination (Join-Path $stage $testReadme)
    $exeHash = (Get-FileHash -LiteralPath (Join-Path $stage 'DJIMicKey.exe') -Algorithm SHA256).Hash
    $dllHash = (Get-FileHash -LiteralPath (Join-Path $stage 'DJIMicKey.Shell.dll') -Algorithm SHA256).Hash
    @(
        'DJIMicKey camera receiver phase 2 - Windows x64 test package',
        "Source commit: $Commit",
        "Windows build and test run: $BuildRunUrl",
        'Hardware compatibility and ChatGPT response require local verification.',
        "DJIMicKey.exe SHA256: $exeHash",
        "DJIMicKey.Shell.dll SHA256: $dllHash"
    ) | Set-Content -LiteralPath (Join-Path $stage 'BUILD-INFO.txt') -Encoding utf8
    Compress-Archive -LiteralPath @(($required + @($testReadme, 'BUILD-INFO.txt')) | ForEach-Object { Join-Path $stage $_ }) -DestinationPath $outputPath -Force
    Assert-PortableArchive -Path $outputPath -IncludeTestFiles $true
    $result = [ordered]@{
        commit = $Commit
        windows_run = $BuildRunUrl
        archive = [System.IO.Path]::GetFileName($outputPath)
        archive_sha256 = (Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash
        exe_sha256 = $exeHash
        dll_sha256 = $dllHash
        pe_machine = '0x8664 (x86-64), EXE and DLL'
        archive_check = 'PASS: required root files, nonempty entries and PE32+ binaries'
        hardware_validation = 'pending'
    }
    $result | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $reportDir 'portable-validation.json') -Encoding utf8
    Write-Host "Validated Windows test package: $outputPath"
} finally {
    if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
}
