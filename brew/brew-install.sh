#!/bin/bash

# Function to check if Homebrew is installed
function check_brew {
    if command -v brew >/dev/null 2>&1; then
        echo "Homebrew is installed. Checking for updates..."
        # If Homebrew is installed, update it
        brew update
    else
        echo "Homebrew is not installed. Installing Homebrew..."
        # If Homebrew is not installed, install it
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Run the function to check and install/update Homebrew
check_brew

# Run 'brew bundle'
echo "Running 'brew bundle'..."
brew bundle

echo "Script completed."
