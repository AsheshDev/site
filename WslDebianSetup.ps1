# AsheshDevelopment
# Filename: WslDebianSetup.ps1

<#
.SYNOPSIS
    A dynamic PowerShell script to install and configure WSL with Debian, set up SSH, and shared folders.

.DESCRIPTION
    This script installs WSL and Debian, configures the Debian environment with SSH and a shared folder,
    and allows customization through parameters. It includes enhanced error handling,
    logging, and user input validation.

.PARAMETER WindowsSharedFolder
    The path to the shared folder on the Windows host. Default is 'D:\__wsl_shared_folder'.

.PARAMETER WslSharedFolder
    The mount point of the shared folder inside WSL. Default is '/mnt/shared_folder'.

.PARAMETER WslDistroName
    The name of the WSL distribution to install. Default is 'Debian'.

.PARAMETER AdditionalPackages
    Additional packages to install in the Debian environment.

.PARAMETER Elevated
    Indicates that the script is running with elevated privileges.

.EXAMPLE
    # Run the script with default settings
    iwr -useb 'https://raw.githubusercontent.com/AsheshDev/site/refs/heads/main/WslDebianSetup.ps1' | iex

.EXAMPLE
    # Run the script with custom shared folder paths
    iwr -useb 'https://raw.githubusercontent.com/AsheshDev/site/refs/heads/main/WslDebianSetup.ps1' | iex -ArgumentList "-WindowsSharedFolder 'D:\MySharedFolder'"

.NOTES
    Author: AsheshDevelopment
#>

param(
    [string]$WindowsSharedFolder = "D:\__wsl_shared_folder",
    [string]$WslSharedFolder = "/mnt/shared_folder",
    [string]$WslDistroName = "Debian",
    [string[]]$AdditionalPackages = @(),
    [switch]$Elevated
)

# Color Codes for RETRASH Color Palette
$ColorCodes = @{
    Info    = "`e[38;2;87;199;255m"     # Soft Blue
    Success = "`e[38;2;90;247;142m"     # Bright Green
    Error   = "`e[38;2;255;92;87m"      # Soft Red
    Warning = "`e[38;2;243;249;157m"    # Pale Yellow
    Reset   = "`e[0m"                   # Reset
}

# Log File
$LogFile = "$env:TEMP\WslDebianSetup.log"

function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    # Output to console with color
    $color = switch ($Level.ToUpper()) {
        "INFO"     { $ColorCodes.Info }
        "SUCCESS"  { $ColorCodes.Success }
        "WARNING"  { $ColorCodes.Warning }
        "ERROR"    { $ColorCodes.Error }
        default    { $ColorCodes.Info }
    }
    Write-Host ("$color$logMessage$($ColorCodes.Reset)")
    # Append to log file
    Add-Content -Path $LogFile -Value $logMessage
}

function Check-Admin {
    if (-not $Elevated) {
        Write-Log "Checking if the script is running with Administrator privileges..." "INFO"
        if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-Log "Not running as Administrator. Restarting with elevated privileges..." "WARNING"
            # Download the script to a temporary file
            $tempScript = "$env:TEMP\WslDebianSetup_temp.ps1"
            try {
                Write-Log "Downloading script to $tempScript" "INFO"
                Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AsheshDev/site/refs/heads/main/WslDebianSetup.ps1' -OutFile $tempScript -UseBasicParsing -ErrorAction Stop
            } catch {
                Write-Log "Failed to download the script. Error: $_" "ERROR"
                exit 1
            }
            # Start the script with elevated privileges and pass the Elevated parameter
            try {
                Write-Log "Starting elevated script..." "INFO"
                Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tempScript`" -Elevated" -Verb RunAs
                exit
            } catch {
                Write-Log "Failed to start elevated script. Error: $_" "ERROR"
                exit 1
            }
        } else {
            Write-Log "Script is running with Administrator privileges." "SUCCESS"
        }
    } else {
        Write-Log "Script is running with Administrator privileges." "SUCCESS"
    }
}

function Check-WslInstalled {
    Write-Log "Checking if WSL is installed..." "INFO"
    $wslCheck = & wsl.exe --list --quiet 2>$null
    if ($LASTEXITCODE -eq 0 -and $wslCheck) {
        Write-Log "WSL is installed." "SUCCESS"
        return $true
    } else {
        Write-Log "WSL is not installed." "ERROR"
        return $false
    }
}

function Install-WslDistro {
    Write-Log "Installing WSL and $WslDistroName..." "INFO"
    try {
        # Install WSL and the specified distro
        Start-Process powershell.exe -ArgumentList "wsl --install -d $WslDistroName" -Wait -NoNewWindow
        if (Check-WslInstalled) {
            Write-Log "WSL and $WslDistroName installed successfully. Please restart your system." "SUCCESS"
            exit
        } else {
            Write-Log "WSL installation failed." "ERROR"
            exit 1
        }
    } catch {
        Write-Log "Failed to install WSL or $WslDistroName. Error: $_" "ERROR"
        exit 1
    }
}

function Configure-DebianEnvironment {
    Write-Log "Configuring Debian environment..." "INFO"

    # Commands to run in WSL
    $commands = @(
        "sudo apt update && sudo apt upgrade -y",
        "sudo apt install -y openssh-server " + ($AdditionalPackages -join ' '),
        "sudo service ssh start",
        "sudo systemctl enable ssh",
        "sudo mkdir -p '$WslSharedFolder'",
        "sudo mount -t drvfs '$WindowsSharedFolder' '$WslSharedFolder'",
        # Simplified and properly escaped commands to append to /etc/wsl.conf
        "echo '[automount]' | sudo tee -a /etc/wsl.conf > /dev/null; " +
        "echo 'root = /mnt' | sudo tee -a /etc/wsl.conf > /dev/null; " 
        #"echo 'options = \"metadata\"' | sudo tee -a /etc/wsl.conf > /dev/null"
    )

    foreach ($cmd in $commands) {
        Write-Log "Executing command in WSL: $cmd" "INFO"
        try {
            # Pass the command to bash -c with proper escaping
            & wsl.exe bash -c "`"$cmd`""
            if ($LASTEXITCODE -eq 0) {
                Write-Log "Command executed successfully." "SUCCESS"
            } else {
                Write-Log "Command failed with exit code $LASTEXITCODE." "ERROR"
                exit 1
            }
        } catch {
            Write-Log "An error occurred: $_" "ERROR"
            exit 1
        }
    }

    Write-Log "Debian environment configured successfully." "SUCCESS"
    Write-Log "SSH is available. Use your Debian username and password to connect." "INFO"
    Write-Log "Shared folder mounted at $WslSharedFolder" "INFO"
}

function Setup-SharedFolder {
    Write-Log "Configuring shared folder between Windows and WSL..." "INFO"

    # Validate Windows shared folder path
    if (-not (Test-Path $WindowsSharedFolder)) {
        Write-Log "Creating shared folder in Windows: $WindowsSharedFolder" "INFO"
        try {
            New-Item -ItemType Directory -Path $WindowsSharedFolder -Force | Out-Null
            Write-Log "Shared folder created successfully." "SUCCESS"
        } catch {
            Write-Log "Failed to create shared folder. Error: $_" "ERROR"
            exit 1
        }
    } else {
        Write-Log "Shared folder already exists: $WindowsSharedFolder" "INFO"
    }

    # Mount in WSL
    $mountCommand = "sudo mkdir -p '$WslSharedFolder' && sudo mount -t drvfs '$WindowsSharedFolder' '$WslSharedFolder'"
    Write-Log "Mounting shared folder in WSL..." "INFO"
    try {
        & wsl.exe bash -c "`"$mountCommand`""
        if ($LASTEXITCODE -eq 0) {
            Write-Log "Shared folder mounted successfully in WSL at $WslSharedFolder" "SUCCESS"
        } else {
            Write-Log "Failed to mount shared folder in WSL." "ERROR"
            exit 1
        }
    } catch {
        Write-Log "An error occurred: $_" "ERROR"
        exit 1
    }
}

function Main-Menu {
    while ($true) {
        Write-Host ""
        Write-Log "WSL Setup Script for Debian" "INFO"
        Write-Host "1. Install WSL and $WslDistroName"
        Write-Host "2. Configure Debian Environment (SSH and Shared Folder)"
        Write-Host "3. Configure Shared Folder"
        Write-Host "4. Exit"
        $choice = Read-Host "Enter your choice [1-4]"

        switch ($choice) {
            "1" {
                if (Check-WslInstalled) {
                    Write-Log "WSL is already installed." "INFO"
                } else {
                    Install-WslDistro
                }
            }
            "2" {
                if (Check-WslInstalled) {
                    Configure-DebianEnvironment
                } else {
                    Write-Log "WSL is not installed. Please install it first." "ERROR"
                }
            }
            "3" {
                if (Check-WslInstalled) {
                    Setup-SharedFolder
                } else {
                    Write-Log "WSL is not installed. Please install it first." "ERROR"
                }
            }
            "4" {
                Write-Log "Exiting script. Goodbye!" "INFO"
                exit 0
            }
            default {
                Write-Log "Invalid choice. Please select a valid option." "ERROR"
            }
        }
    }
}

function Main {
    Check-Admin
    Main-Menu
}

# Start the script
Main
