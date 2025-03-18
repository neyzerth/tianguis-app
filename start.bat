@echo off

:: Navigate to react-native directory
cd react-native

:: Check if --i flag is provided for installing dependencies
if "%1"=="--i" (
    echo Installing dependencies...
    :: Install dependencies
    npm install
    echo Dependencies installed successfully!
)
:: Check if --r flag is provided for re-installing dependencies
if "%1"=="--r" (
    echo Re-installing dependencies...
    :: Remove existing node_modules and package-lock
    rmdir /s /q node_modules
    del /f package-lock.json
    :: Clear npm cache
    npm cache clean --force
    :: Install dependencies
    npm install
    echo Dependencies re-installed successfully!
)

:: Start the Expo project
echo Starting Expo project...
npx expo start