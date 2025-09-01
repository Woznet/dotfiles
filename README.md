# GitHub CodeSpaces Dotfiles

This repository contains my personal dotfiles and environment configuration for GitHub CodeSpaces, specifically optimized for PowerShell and .NET development.

## Overview

This dotfiles repository automatically configures a GitHub CodeSpaces environment with:

- **PowerShell** configuration and profile customization
- **.NET SDK** and development tools
- **Visual Studio Code** settings optimized for .NET development
- **Git** configuration
- Common development utilities and tools

## How it works

GitHub CodeSpaces automatically clones this repository and runs the setup scripts when creating a new codespace. The configuration includes:

- `.devcontainer/devcontainer.json` - CodeSpaces container configuration
- `install.sh` - Main setup script that installs tools and configures the environment
- `Microsoft.PowerShell_profile.ps1` - PowerShell profile for customized shell experience
- `.vscode/settings.json` - VS Code settings for optimal .NET development
- `.gitconfig` - Git configuration template

## Usage

1. Enable this repository as your CodeSpaces dotfiles repository in your GitHub settings
2. Create a new CodeSpace - the environment will be automatically configured
3. The setup script will install all necessary tools and apply configurations

## Manual Setup

If you want to use these dotfiles outside of CodeSpaces:

```bash
git clone https://github.com/Woznet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Customization

Feel free to fork this repository and customize the configurations to match your preferences. The main areas to customize are:

- PowerShell profile (`Microsoft.PowerShell_profile.ps1`)
- VS Code settings (`.vscode/settings.json`)
- Git configuration (`.gitconfig`)
- Additional tools in the install script (`install.sh`)

## Requirements

- GitHub CodeSpaces (recommended) or Linux/macOS environment
- Internet connection for downloading tools and packages

## License

This repository is provided as-is for personal use. Feel free to use and modify as needed.