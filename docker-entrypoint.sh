#!/bin/bash
set -e

# Start ssh-agent and set up environment variables
eval $(ssh-agent -s)

# Check if the key exists and add it to the agent
if [ -f /root/.ssh/id_git ]; then
    # Set proper permissions on SSH key
    chmod 600 /root/.ssh/id_git

    # Add key to agent (without prompt)
    echo "Adding SSH key to agent..."
    ssh-add /root/.ssh/id_git

    # Test connection to GitHub (optional, but helpful for debugging)
    echo "Testing SSH connection to GitHub..."
    ssh -o StrictHostKeyChecking=no -T git@github.com || true
else
    echo "Warning: SSH key /root/.ssh/id_git not found"
fi

# Execute the command passed to docker run
exec "$@"
