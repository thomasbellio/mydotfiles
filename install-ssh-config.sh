#!/usr/bin/zsh
# Define the source and target paths
SOURCE="$(pwd)/ssh/config"
TARGET="$HOME/.ssh/config"

# Check if the target file already exists
if [ -e "$TARGET" ]; then
    # If it exists, create a backup
    echo "File $TARGET already exists. Creating a backup."
    mv "$TARGET" "$TARGET.bak"
fi

# Create the symlink
echo "Creating symlink from $SOURCE to $TARGET."
ln -s "$SOURCE" "$TARGET"
