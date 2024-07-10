#!/bin/bash

# Function to read the password securely
read_password() {
    local prompt=$1
    local password_variable=$2
    echo -n "$prompt: "
    read -s password
    echo
    eval "$password_variable='$password'"
}

# Function to delete the last command from history
delete_last_history() {
    history -d $((HISTCMD-1))
}

# Check if email argument is provided, if not return an error and exit
if [ -z "$1" ]; then
    echo "Error: No email provided."
    echo "Usage: $0 your_email@example.com"
    exit 1
else
    EMAIL=$1
fi

# Retrieve the current user's username
USER=$(whoami)

# Define the path and filename for the SSH key
KEY_PATH="/Users/$USER/.ssh/github_ed25519"
KEY_PUB_PATH="${KEY_PATH}.pub"

# Check if the SSH key already exists
if [ -f "$KEY_PATH" ] && [ -f "$KEY_PUB_PATH" ]; then
    echo "Both SSH key files already exist at $KEY_PATH and $KEY_PUB_PATH"
else
    # Read the password securely
    read_password "Enter your password" PASSWORD

    # Generate the SSH key with the provided email, file path, and password
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N "$PASSWORD"

    # Delete the password read command from history
    delete_last_history

    # Inform the user the key has been created
    echo "SSH key generated at $KEY_PATH"
fi

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Ensure the .ssh directory exists
mkdir -p ~/.ssh

# Check if the ~/.ssh/config file exists, if not, create it
if [ ! -f ~/.ssh/config ]; then
    touch ~/.ssh/config
fi

# Modify the ~/.ssh/config file to contain the required lines
if ! grep -q "Host github.com" ~/.ssh/config; then
    cat <<EOT >> ~/.ssh/config

Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $KEY_PATH
EOT
fi

# Add the SSH private key to the ssh-agent and store passphrase in keychain if not already added
if ! ssh-add -L | grep -q "$KEY_PATH"; then
    ssh-add --apple-use-keychain $KEY_PATH
fi

# Copy the SSH public key to the clipboard
pbcopy < "$KEY_PATH.pub"

# Provide final instructions to the user
echo "The SSH public key has been copied to your clipboard."
echo "Here is your public key:"
cat "$KEY_PATH.pub"
echo
echo "Follow the instructions at the following link to add the SSH key to your GitHub account:"
echo "https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account"
