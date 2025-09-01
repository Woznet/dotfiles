#!/bin/bash

# Main installation script for dotfiles
# This script can be run outside of CodeSpaces for manual setup

set -e

echo "🚀 Starting dotfiles installation..."

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "📊 Detected OS: $MACHINE"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install PowerShell if not exists (Linux)
if [ "$MACHINE" = "Linux" ] && ! command_exists pwsh; then
    echo "⚡ Installing PowerShell..."
    
    # Download the Microsoft repository GPG keys
    wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    
    # Update the list of products and install PowerShell
    sudo apt-get update
    sudo apt-get install -y powershell
fi

# Install .NET SDK if not exists (Linux)
if [ "$MACHINE" = "Linux" ] && ! command_exists dotnet; then
    echo "🔧 Installing .NET SDK..."
    sudo apt-get install -y dotnet-sdk-8.0
fi

# Install PowerShell modules
if command_exists pwsh; then
    echo "📦 Installing PowerShell modules..."
    pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
    pwsh -Command "Install-Module -Name PSReadLine -Force -SkipPublisherCheck"
    pwsh -Command "Install-Module -Name Terminal-Icons -Force -SkipPublisherCheck"  
    pwsh -Command "Install-Module -Name posh-git -Force -SkipPublisherCheck"
    pwsh -Command "Install-Module -Name PowerShellGet -Force -AllowClobber"
fi

# Install .NET global tools
if command_exists dotnet; then
    echo "🛠️ Installing .NET global tools..."
    dotnet tool install --global dotnet-ef --ignore-failed-sources || true
    dotnet tool install --global dotnet-aspnet-codegenerator --ignore-failed-sources || true
    dotnet tool install --global Microsoft.Web.LibraryManager.Cli --ignore-failed-sources || true
fi

# Create PowerShell profile directory
echo "📁 Setting up PowerShell directories..."
if [ "$MACHINE" = "Linux" ]; then
    mkdir -p ~/.config/powershell
    PROFILE_PATH="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
elif [ "$MACHINE" = "Mac" ]; then
    mkdir -p ~/.config/powershell  
    PROFILE_PATH="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
fi

# Copy PowerShell profile
if [ -f "./Microsoft.PowerShell_profile.ps1" ] && [ -n "$PROFILE_PATH" ]; then
    echo "📋 Installing PowerShell profile..."
    cp "./Microsoft.PowerShell_profile.ps1" "$PROFILE_PATH"
fi

# Copy git configuration
if [ -f "./.gitconfig" ]; then
    echo "⚙️ Installing Git configuration..."
    cp ./.gitconfig ~/.gitconfig
    echo "📝 Please update ~/.gitconfig with your personal information"
fi

# Setup shell configurations
if [ -f "./.bashrc" ]; then
    echo "🐚 Applying Bash configuration..."
    if ! grep -q "# Dotfiles additions" ~/.bashrc 2>/dev/null; then
        echo "" >> ~/.bashrc
        echo "# Dotfiles additions" >> ~/.bashrc
        cat ./.bashrc >> ~/.bashrc
    fi
fi

if [ -f "./.zshrc" ]; then
    echo "🐚 Applying Zsh configuration..."
    if ! grep -q "# Dotfiles additions" ~/.zshrc 2>/dev/null; then
        echo "" >> ~/.zshrc
        echo "# Dotfiles additions" >> ~/.zshrc  
        cat ./.zshrc >> ~/.zshrc
    fi
fi

echo ""
echo "✅ Dotfiles installation completed!"
echo "📝 Don't forget to:"
echo "   - Update ~/.gitconfig with your name and email"
echo "   - Restart your terminal or run 'source ~/.bashrc' (or ~/.zshrc)"
echo "   - Run 'pwsh' to start PowerShell with your new profile"
echo ""