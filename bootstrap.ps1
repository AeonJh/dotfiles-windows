function exitWithError {
    param (
        [string]$message
    )
    Write-Host "Error: $message" -ForegroundColor Red
    exit 1
}

# Backup default powershell profile
if (-not $PROFILE) {
    exitWithError "PowerShell profile not found. Please ensure you have a valid profile path set."
}
$profilePath = Split-Path -Path $PROFILE -Parent
$backupPath = "$profilePath.bak"
New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
# Only backup .ps1 files
Copy-Item -Path "$profilePath\*.ps1" -Destination $backupPath -Force -ErrorAction SilentlyContinue
Write-Host "Backup of PowerShell profile created at: $backupPath" -ForegroundColor Yellow

# Copy .ps1 files to the profile directory
Write-Host "Copying .ps1 files to profile directory: $profilePath" -ForegroundColor Cyan
Copy-Item -Path ".\*.ps1" -Destination $profilePath -Exclude "bootstrap.ps1" -Force

# Load the new profile
if (Test-Path $PROFILE) {
    Write-Host "Loading new PowerShell profile..." -ForegroundColor Green
    . $PROFILE
} else {
    Remove-Variable profilePath -ErrorAction SilentlyContinue
    Remove-Variable backupPath -ErrorAction SilentlyContinue
    exitWithError "Profile not found after copying scripts."
}

# Configure Starship theme
$starshipConfigPath = "$HOME\.config"
if (-not (Test-Path $starshipConfigPath)) {
    New-Item -ItemType Directory -Path $starshipConfigPath -Force | Out-Null
}
Copy-Item -Path ".\starship.toml" -Destination $starshipConfigPath -Force
