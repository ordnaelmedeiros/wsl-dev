<#
.SYNOPSIS
create wsl dev

.DESCRIPTION

#>
[CmdletBinding()]
Param (
    [switch]$create = $false,
    [switch]$update = $false,
    [switch]$base = $false,
    [switch]$darkmode = $false,
    [switch]$eclipse = $false,
    [switch]$info = $false
)


if ($create) {
    echo "[wsl2]" > ~/.wslconfig
    echo "kernelCommandLine = cgroup_no_v1=all" >> ~/.wslconfig

    wsl --shutdown
    wsl --unregister dev
    wsl --install Ubuntu-24.04 --name dev
    wsl --set-default dev
    Write-Warning "After setting the username and password, run an 'exit' to proceed with the process"
    wsl -d dev
}

if ($base -or $create) {
    wsl -d dev ./scripts/base.sh
}

if ($update) {
    wsl --update
    wsl -d dev ./scripts/update.sh
}

if ($darkmode) {
    wsl -d dev ./scripts/darkmode.sh
}

if ($eclipse) {
    wsl -d dev ./scripts/eclipse.sh
    if (-Not (Test-Path "C:\icons\")) {
        New-Item -ItemType Directory -Path "C:\icons\"
    }
    Copy-Item -Path "./files/eclipse.ico" -Destination "C:\icons\"
    Copy-Item -Path "./files/Eclipse Linux.lnk" -Destination "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\dev\"
}

if ($info -or $create) {
    wsl -d dev neofetch
}
