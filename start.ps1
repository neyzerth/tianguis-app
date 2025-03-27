# Set execution policy if needed (might need admin rights)
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Navigate to react-native directory
Set-Location -Path ".\react-native"

# Parse command line arguments
param(
    [string]$flag
)

# Function to install dependencies
function Install-Dependencies {
    Write-Host "Installing dependencies..." -ForegroundColor Green
    npm install
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Dependencies installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "Error installing dependencies!" -ForegroundColor Red
        exit 1
    }
}

# Function to reinstall dependencies
function Reinstall-Dependencies {
    Write-Host "Re-installing dependencies..." -ForegroundColor Yellow
    
    # Remove existing node_modules and package-lock
    if (Test-Path ".\node_modules") {
        Remove-Item -Path ".\node_modules" -Recurse -Force
    }
    if (Test-Path ".\package-lock.json") {
        Remove-Item -Path ".\package-lock.json" -Force
    }
    
    # Clear npm cache
    npm cache clean --force
    
    # Install dependencies
    Install-Dependencies
}

# Handle flags
switch ($flag) {
    "--i" { Install-Dependencies }
    "--r" { Reinstall-Dependencies }
}

# Start the Expo project
Write-Host "Starting Expo project..." -ForegroundColor Cyan
npx expo start