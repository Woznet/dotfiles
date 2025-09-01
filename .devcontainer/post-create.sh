#!/bin/bash

# Post-create script for CodeSpaces dotfiles setup
echo "🚀 Setting up PowerShell & .NET development environment..."

# Update the system
sudo apt-get update

# Install additional tools
echo "📦 Installing additional development tools..."
sudo apt-get install -y \
    curl \
    wget \
    unzip \
    tree \
    jq \
    htop \
    neofetch

# Install latest PowerShell modules
echo "⚡ Installing PowerShell modules..."
pwsh -Command "Install-Module -Name PSReadLine -Force -SkipPublisherCheck"
pwsh -Command "Install-Module -Name Terminal-Icons -Force -SkipPublisherCheck"
pwsh -Command "Install-Module -Name posh-git -Force -SkipPublisherCheck"

# Install .NET tools
echo "🔧 Installing .NET global tools..."
dotnet tool install --global dotnet-ef
dotnet tool install --global dotnet-aspnet-codegenerator
dotnet tool install --global Microsoft.Web.LibraryManager.Cli

# Create directories for PowerShell profile
echo "📁 Setting up PowerShell profile directories..."
mkdir -p ~/.config/powershell
mkdir -p ~/.local/share/powershell/Modules

# Copy PowerShell profile if it exists
if [ -f "./Microsoft.PowerShell_profile.ps1" ]; then
    echo "📋 Copying PowerShell profile..."
    cp "./Microsoft.PowerShell_profile.ps1" ~/.config/powershell/
fi

# Set up git configuration
if [ -f "./.gitconfig" ]; then
    echo "⚙️ Applying Git configuration..."
    cp ./.gitconfig ~/.gitconfig
fi

# Apply shell configurations
if [ -f "./.bashrc" ]; then
    echo "🐚 Applying Bash configuration..."
    cat ./.bashrc >> ~/.bashrc
fi

if [ -f "./.zshrc" ]; then
    echo "🐚 Applying Zsh configuration..."
    cat ./.zshrc >> ~/.zshrc
fi

echo "✅ Setup completed! Reload your terminal to see the changes."