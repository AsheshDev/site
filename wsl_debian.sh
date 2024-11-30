#!/bin/bash
# AsheshDevelopment
# Filename: setup_wsl_debian.sh

# Color-coded messages for readability
INFO="\033[1;34m[INFO]\033[0m"
SUCCESS="\033[1;32m[SUCCESS]\033[0m"
ERROR="\033[1;31m[ERROR]\033[0m"

# Variables
WSL_SHARED_FOLDER="/mnt/shared_folder"
WINDOWS_SHARED_FOLDER="D:/__wsl_shared_folder"

# Function to check if WSL is installed
check_wsl_installed() {
    if wsl --list --quiet >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Function to install WSL and Debian
install_wsl_debian() {
    echo -e "$INFO Installing WSL and Debian..."
    powershell.exe -Command "wsl --install -d Debian" || {
        echo -e "$ERROR Failed to install WSL or Debian."
        exit 1
    }
    echo -e "$SUCCESS WSL and Debian installed successfully. Restart your system if required."
    exit 0
}

# Function to set up Debian environment
setup_debian_environment() {
    echo -e "$INFO Updating and upgrading system packages..."
    sudo apt update && sudo apt upgrade -y || {
        echo -e "$ERROR Failed to update packages."
        exit 1
    }

    echo -e "$INFO Installing OpenSSH Server for secure file transfers..."
    sudo apt install -y openssh-server || {
        echo -e "$ERROR Failed to install OpenSSH Server."
        exit 1
    }

    echo -e "$INFO Enabling and starting SSH service..."
    sudo service ssh start
    sudo service ssh enable || {
        echo -e "$ERROR Failed to start SSH service."
        exit 1
    }

    echo -e "$INFO Configuring shared directory between Windows and WSL..."
    if [ ! -d "$WINDOWS_SHARED_FOLDER" ]; then
        echo -e "$INFO Creating shared folder in Windows: $WINDOWS_SHARED_FOLDER"
        powershell.exe mkdir "$WINDOWS_SHARED_FOLDER" 2>/dev/null
    fi

    sudo mkdir -p "$WSL_SHARED_FOLDER"
    sudo mount -t drvfs "$WINDOWS_SHARED_FOLDER" "$WSL_SHARED_FOLDER" || {
        echo -e "$ERROR Failed to mount shared directory."
        exit 1
    }

    echo -e "$INFO Automating shared directory mount on WSL startup..."
    WSL_FSTAB="/etc/wsl.conf"
    if ! grep -q "automount" "$WSL_FSTAB"; then
        echo -e "[automount]\nroot = /mnt\noptions = \"metadata\"" | sudo tee -a "$WSL_FSTAB" >/dev/null
        echo -e "$SUCCESS Auto-mount configuration added to $WSL_FSTAB."
    else
        echo -e "$INFO Auto-mount configuration already exists in $WSL_FSTAB."
    fi

    echo -e "$SUCCESS Debian environment set up successfully."
    echo -e " - SSH: Secure file transfers available. Use an SFTP client like WinSCP or FileZilla to connect."
    echo -e "   Credentials: Host: localhost | Port: 22 | Username: ashesh | Password: ashesh"
    echo -e " - Shared Directory: Access Windows files via $WSL_SHARED_FOLDER."
    echo -e "   Ensure Windows shared directory exists at: $WINDOWS_SHARED_FOLDER."
    echo -e " - Use File Explorer: Access WSL files via \\wsl$\\Debian."
    exit 0
}

# Menu for user selection
menu() {
    echo -e "\n$INFO WSL Setup Script for Debian"
    echo -e "1. Install WSL and Debian"
    echo -e "2. Configure Debian Environment (SSH and Shared Folder)"
    echo -e "3. Exit"
    read -rp "Enter your choice [1-3]: " choice

    case $choice in
    1)
        if check_wsl_installed; then
            echo -e "$INFO WSL is already installed."
        else
            install_wsl_debian
        fi
        ;;
    2)
        if check_wsl_installed; then
            setup_debian_environment
        else
            echo -e "$ERROR WSL is not installed. Please install it first."
            exit 1
        fi
        ;;
    3)
        echo -e "$INFO Exiting script. Goodbye!"
        exit 0
        ;;
    *)
        echo -e "$ERROR Invalid choice. Please select a valid option."
        menu
        ;;
    esac
}

# Run the menu
menu
