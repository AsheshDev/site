# AsheshDevelopment
# Filename: Install-FedoraWSL-GUI-Menu.ps1

<#
.SYNOPSIS
    PowerShell script to install Fedora on WSL with Desktop GUI 
    and set up a development environment with a detailed GUI menu.
.DESCRIPTION
    This script provides a graphical user interface (GUI) with a menu for 
    various operations like installing Fedora, updating the system, 
    installing development tools, and configuring the environment.
    The script uses color-coded debug logs for detailed output.
#>

# =============================================
# COLOR CODES (Dracula Neon Vibrant Color Scheme)
# =============================================
$Colors = @{
    "Info"    = "Cyan"
    "Success" = "Green"
    "Warning" = "Yellow"
    "Error"   = "Red"
    "Reset"   = "White"
}

# =============================================
# Function: Show-Message
# Description: Displays a color-coded message
# =============================================
function Show-Message {
    param (
        [string]$Message,
        [string]$Type = "Info"
    )
    $Color = $Colors[$Type]
    Write-Host $Message -ForegroundColor $Color
}

# =============================================
# Function: Create-GUI
# Description: Creates a WPF GUI with a menu for operations
# =============================================
function Create-GUI {
    Show-Message "Creating GUI menu for user interaction..." "Info"
    Add-Type -AssemblyName PresentationFramework

    $XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Fedora WSL Installation" Height="350" Width="500">
    <Grid>
        <Label Content="Fedora WSL Installation Menu" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,20,0,0" FontSize="16" FontWeight="Bold"/>
        
        <Button Name="InstallFedoraButton" Content="Install Fedora on WSL" Width="250" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,70,0,0"/>
        <Button Name="UpdateSystemButton" Content="Update Fedora System" Width="250" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,110,0,0"/>
        <Button Name="InstallDevToolsButton" Content="Install Development Tools" Width="250" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,150,0,0"/>
        <Button Name="InstallGNOMEButton" Content="Install GNOME Desktop GUI" Width="250" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,190,0,0"/>
        <Button Name="ConfigureGUIButton" Content="Configure GUI Settings" Width="250" Height="30" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,230,0,0"/>
    </Grid>
</Window>
"@

    $Reader = New-Object System.Xml.XmlNodeReader $XAML
    $Window = [System.Windows.Markup.XamlReader]::Load($Reader)
    
    # Button Actions
    $Window.FindName("InstallFedoraButton").Add_Click({
        Install-FedoraWSL
    })

    $Window.FindName("UpdateSystemButton").Add_Click({
        Update-System
    })

    $Window.FindName("InstallDevToolsButton").Add_Click({
        Install-DevTools
    })

    $Window.FindName("InstallGNOMEButton").Add_Click({
        Install-GNOME
    })

    $Window.FindName("ConfigureGUIButton").Add_Click({
        Configure-GUI
    })

    $Window.ShowDialog() | Out-Null
}

# =============================================
# Function: Install-FedoraWSL
# Description: Installs Fedora on WSL
# =============================================
function Install-FedoraWSL {
    Show-Message "Starting Fedora installation on WSL..." "Info"
    try {
        wsl --install -d Fedora
        Show-Message "Fedora installed on WSL successfully." "Success"
    } catch {
        Show-Message "Failed to install Fedora on WSL." "Error"
        exit 1
    }
}

# =============================================
# Function: Update-System
# Description: Updates and upgrades the Fedora system
# =============================================
function Update-System {
    Show-Message "Updating and upgrading the Fedora system..." "Info"
    try {
        wsl -d Fedora -- bash -c "sudo dnf update -y && sudo dnf upgrade -y"
        Show-Message "System updated and upgraded successfully." "Success"
    } catch {
        Show-Message "Failed to update and upgrade the system." "Error"
        exit 1
    }
}

# =============================================
# Function: Install-DevTools
# Description: Installs development tools and essentials
# =============================================
function Install-DevTools {
    Show-Message "Installing development tools and essentials..." "Info"
    try {
        wsl -d Fedora -- bash -c "sudo dnf groupinstall 'Development Tools' -y"
        wsl -d Fedora -- bash -c "sudo dnf install git vim curl wget -y"
        Show-Message "Development tools installed successfully." "Success"
    } catch {
        Show-Message "Failed to install development tools." "Error"
        exit 1
    }
}

# =============================================
# Function: Install-GNOME
# Description: Installs GNOME Desktop Environment
# =============================================
function Install-GNOME {
    Show-Message "Installing GNOME Desktop Environment..." "Info"
    try {
        wsl -d Fedora -- bash -c "sudo dnf groupinstall 'GNOME Desktop Environment' -y"
        Show-Message "GNOME Desktop Environment installed successfully." "Success"
    } catch {
        Show-Message "Failed to install GNOME Desktop Environment." "Error"
        exit 1
    }
}

# =============================================
# Function: Configure-GUI
# Description: Configures GUI settings for WSL
# =============================================
function Configure-GUI {
    Show-Message "Configuring GUI settings for WSL..." "Info"
    try {
        wsl -d Fedora -- bash -c "echo 'export DISPLAY=:0' >> ~/.bashrc"
        wsl -d Fedora -- bash -c "source ~/.bashrc"
        Show-Message "GUI settings configured successfully." "Success"
        Show-Message "Ensure that you start an X server (e.g., VcXsrv) on Windows before launching the GUI." "Warning"
    } catch {
        Show-Message "Failed to configure GUI settings." "Error"
        exit 1
    }
}

# =============================================
# Main Script Execution
# =============================================
Show-Message "Initiating Fedora WSL installation process..." "Info"

# Show the GUI menu and wait for user interaction
Create-GUI

Show-Message "Fedora WSL installation and configuration complete!" "Success"
