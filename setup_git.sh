#!/bin/bash
# Git setup script for cathyAI homelab documentation

echo "Setting up git environment..."

# Initialize git if needed
if [ ! -d .git ]; then
    git init
    echo "✓ Git repository initialized"
fi

# Set up commit message template if it exists
if [ -f .gitmessage ]; then
    git config commit.template .gitmessage
    echo "✓ Commit template configured"
fi

echo "✓ Git environment configured!"
echo "Ready to commit and push to remote"
