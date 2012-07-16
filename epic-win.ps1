<#
.SYNOPSIS
Windows's missing package manager.

.DESCRIPTION
This script downloads and installs packages for you.

.PARAMETER command
If the command is "install", then install packages (see below).
If the command is "list", then list packages.
If the command is "clean", then clean package downloads.

.PARAMETER packages
A list of packages.
If the list is empty for the "install" command, do not install anything.
If the list is empty for the "list" command, show all packages.
If the list is empty for the "clean" command, clean all downloads.

.NOTES

This is a pale imitation of apt-get, yum, or even brew.
It only supports install, at the moment.

It needs:
update: A way to freshen up the packages folder
remove: A way to remove an existing package

.EXAMPLE
C:\PS> .\epic-win.ps1 install calibre latex

.EXAMPLE
C:\PS> .\epic-win.ps1 list
#>

Param(
    [Parameter(Mandatory=$true, Position = 0)]
    [string]
    $command,
    
    [Parameter(ValueFromRemainingArguments = $true)]
    $packages
)

$DESTFOLDER = "download"
$INSTALLFOLDER = "bin"

mkdir -EA SilentlyContinue $DESTFOLDER > $null
mkdir -EA SilentlyContinue $INSTALLFOLDER > $null

$DESTFOLDER = Resolve-Path $DESTFOLDER
$INSTALLFOLDER = Resolve-Path $INSTALLFOLDER

# Download a package
function download_package ($package)
{
    # Prepare download destination
    $package["DESTINATION"] = Join-Path $DESTFOLDER $package["DESTINATION"]

    # Download file
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("user-agent", "win-get")
    $client.DownloadFile($package["DOWNLOAD"], $package["DESTINATION"])
}

# Install zip file
function install_zip ($package)
{
    # Prepare install destination
    $package["INSTALL"] = Join-Path $INSTALLFOLDER $package["INSTALL"]
    mkdir -EA SilentlyContinue $package["INSTALL"] > $null

    # Extract to install folder
    $shell = New-Object -com Shell.Application 
    $zip_file = $shell.namespace($package["DESTINATION"])
    $destination = $shell.namespace($package["INSTALL"])
    $destination.Copyhere($zip_file.items(), 0x14)
}

# Install msi file
function install_msi ($package)
{
    & $package["DESTINATION"]
}

# Install exe file
function install_exe ($package)
{
    & $package["DESTINATION"]
}

# Install downloaded file
function install_file ($package)
{
    switch -wildcard ($package["DESTINATION"])
    {
        "*zip" { install_zip $package }
        "*msi" { install_msi $package }
        "*exe" { install_exe $package }
    }
}

function add_path ($package)
{
    if ($package.ContainsKey("ADDPATH")) {
        $package["ADDPATH"] = Join-Path $package["INSTALL"] $package["ADDPATH"]
        $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
        $userPath += ";" + $package["ADDPATH"]
        [Environment]::SetEnvironmentVariable("Path", $userPath, "User")
        $env:Path += ";" + $package["ADDPATH"]
    }
}

function install_package ($package_name)
{
    # Get package information
    $package_file = Join-Path "packages\windows\" "${package_name}.ps1"
    if (Test-Path $package_file)
    {
        . $package_file
    }
    else
    {
        throw "Package $package_name not found."
    }
    
    # If the program exists, say so
    if (gcm -EA SilentlyContinue $package["CHECK"])
    {
        Write-Host "Package" $package["TITLE"] "is already installed."
    }
    # Otherwise, install the package. Booyah!
    else
    {
        # If it has dependencies, install those first.
        foreach ($dependency in $package["DEPENDS"])
        {
            install_package $dependency
        }
        
        Write-Host "Downloading" $package["TITLE"] "..."
        Write-Host "See:" $package["URL"]
        
        download_package $package
        
        Write-Host "Installing" $package["TITLE"] "..."
        install_file $package
        
        add_path $package
    }
}

function clean()
{
    rm -Recurse -Force $DESTFOLDER
    mkdir -EA SilentlyContinue $DESTFOLDER > $null
}

if ($command -eq "install")
{
    foreach ($package in $packages)
    {
        install_package $package
    }
}
elseif ($command -eq "list")
{
    Write-Output "Unimplemented"
}
elseif ($command -eq "clean")
{
    clean
}
elseif ($command -eq "help")
{
    get-help $MyInvocation.InvocationName
}
