# PowerShell Profile for .NET Development
# Location: ~/.config/powershell/Microsoft.PowerShell_profile.ps1

# Import necessary modules
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
}

if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
}

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Import-Module Terminal-Icons
}

# PSReadLine configuration for better command line experience
if (Get-Module PSReadLine) {
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    
    # Key bindings
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar
    Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardDeleteWord
    Set-PSReadLineKeyHandler -Key Alt+d -Function DeleteWord
    Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
    Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
    
    # History search
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# Useful aliases for .NET development
Set-Alias -Name "ll" -Value "Get-ChildItem"
Set-Alias -Name "la" -Value "Get-ChildItem -Force"
Set-Alias -Name "grep" -Value "Select-String"
Set-Alias -Name "which" -Value "Get-Command"

# .NET specific aliases
Set-Alias -Name "dnb" -Value "dotnet build"
Set-Alias -Name "dnr" -Value "dotnet run"
Set-Alias -Name "dnt" -Value "dotnet test"
Set-Alias -Name "dnc" -Value "dotnet clean"
Set-Alias -Name "dnp" -Value "dotnet publish"
Set-Alias -Name "dnw" -Value "dotnet watch"

# Useful functions
function Get-DotNetInfo {
    <#
    .SYNOPSIS
    Display .NET SDK and runtime information
    #>
    Write-Host "=== .NET SDK Information ===" -ForegroundColor Green
    dotnet --info
    
    Write-Host "`n=== Global Tools ===" -ForegroundColor Green
    dotnet tool list --global
    
    Write-Host "`n=== Available Project Templates ===" -ForegroundColor Green
    dotnet new list
}

function New-DotNetProject {
    <#
    .SYNOPSIS
    Create a new .NET project with common templates
    .PARAMETER Template
    The project template to use
    .PARAMETER Name
    The name of the project
    #>
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("console", "classlib", "web", "webapi", "mvc", "blazorserver", "blazorwasm", "xunit", "nunit")]
        [string]$Template,
        
        [Parameter(Mandatory = $true)]
        [string]$Name
    )
    
    Write-Host "Creating new $Template project: $Name" -ForegroundColor Green
    dotnet new $Template -n $Name
    Set-Location $Name
    Write-Host "Project created and directory changed to: $(Get-Location)" -ForegroundColor Green
}

function Get-GitStatus {
    <#
    .SYNOPSIS
    Enhanced git status with branch information
    #>
    if (Test-Path .git) {
        git status --short --branch
    } else {
        Write-Host "Not a git repository" -ForegroundColor Yellow
    }
}

function Test-Port {
    <#
    .SYNOPSIS
    Test if a port is open
    .PARAMETER Port
    The port number to test
    .PARAMETER ComputerName
    The computer name or IP address (default: localhost)
    #>
    param(
        [Parameter(Mandatory = $true)]
        [int]$Port,
        
        [Parameter()]
        [string]$ComputerName = "localhost"
    )
    
    $result = Test-NetConnection -ComputerName $ComputerName -Port $Port -InformationLevel Quiet
    if ($result) {
        Write-Host "Port $Port is open on $ComputerName" -ForegroundColor Green
    } else {
        Write-Host "Port $Port is closed on $ComputerName" -ForegroundColor Red
    }
}

# Custom prompt function
function prompt {
    $currentPath = $PWD.Path
    $gitBranch = ""
    
    # Get git branch if in a git repository
    if (Test-Path .git) {
        try {
            $gitBranch = git branch --show-current 2>$null
            if ($gitBranch) {
                $gitBranch = " ($gitBranch)"
            }
        } catch {
            $gitBranch = ""
        }
    }
    
    # Display current directory and git branch
    Write-Host "$currentPath" -ForegroundColor Cyan -NoNewline
    Write-Host "$gitBranch" -ForegroundColor Yellow -NoNewline
    Write-Host ""
    
    # Return the prompt character
    return "PS> "
}

# Display welcome message
Write-Host ""
Write-Host "🚀 PowerShell .NET Development Environment Loaded!" -ForegroundColor Green
Write-Host "📚 Available commands:" -ForegroundColor Cyan
Write-Host "   Get-DotNetInfo     - Display .NET SDK information" -ForegroundColor White
Write-Host "   New-DotNetProject  - Create new .NET project" -ForegroundColor White
Write-Host "   Get-GitStatus      - Enhanced git status" -ForegroundColor White
Write-Host "   Test-Port          - Test if a port is open" -ForegroundColor White
Write-Host ""
Write-Host "🔧 .NET aliases: dnb (build), dnr (run), dnt (test), dnc (clean), dnp (publish), dnw (watch)" -ForegroundColor Cyan
Write-Host ""

# Set the starting location
if (Test-Path "/workspaces") {
    # We're in CodeSpaces
    Set-Location "/workspaces"
} elseif (Test-Path "$HOME/projects") {
    # Local development with projects folder
    Set-Location "$HOME/projects"
}