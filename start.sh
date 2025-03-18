#!/bin/bash

# Navigate to react-native directory
cd react-native

# Check if --i flag is provided for installing dependencies
if [ "$1" = "--i" ]; then
    echo "Installing dependencies..."
    # Remove existing node_modules and package-lock
    rm -rf node_modules/
    rm -f package-lock.json
    # Clear npm cache
    npm cache clean --force
    # Install dependencies
    npm install
    echo "Dependencies installed successfully!"
fi

# Start the Expo project
echo "Starting Expo project..."
npx expo start