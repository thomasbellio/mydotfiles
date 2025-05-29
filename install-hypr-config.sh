#!/usr/bin/zsh

# Define hypr source and target paths
HYPR_SOURCE_FILE="$(pwd)/hypr/hyprland.conf"
HYPR_TARGET_DIR="$XDG_CONFIG_HOME/hypr"
HYPR_TARGET_FILE="$HYPR_TARGET_DIR/hyprland.conf"

# Define uwsm source and target paths
UWSM_SOURCE_FILE="$(pwd)/hypr/uwsm/env-hyprland"
UWSM_TARGET_DIR="$XDG_CONFIG_HOME/uwsm"
UWSM_TARGET_FILE="$UWSM_TARGET_DIR/env-hyprland"

# Create target directories if they don't exist
if [ ! -d "$HYPR_TARGET_DIR" ]; then
    echo "Creating target directory: $HYPR_TARGET_DIR"
    mkdir -p "$HYPR_TARGET_DIR"
fi

if [ ! -d "$UWSM_TARGET_DIR" ]; then
    echo "Creating target directory: $UWSM_TARGET_DIR"
    mkdir -p "$UWSM_TARGET_DIR"
fi

# Check if the target files already exist
if [ -e "$HYPR_TARGET_FILE" ]; then
    echo "Target file already exists. Creating backup."
    mv "$HYPR_TARGET_FILE" "$HYPR_TARGET_FILE.bak"
fi

if [ -e "$UWSM_TARGET_FILE" ]; then
    echo "Target file already exists. Creating backup."
    mv "$UWSM_TARGET_FILE" "$UWSM_TARGET_FILE.bak"
fi

# Create the symlinks
echo "Creating symlink from $HYPR_SOURCE_FILE to $HYPR_TARGET_FILE"
ln -s "$HYPR_SOURCE_FILE" "$HYPR_TARGET_FILE"

echo "Creating symlink from $UWSM_SOURCE_FILE to $UWSM_TARGET_FILE"
ln -s "$UWSM_SOURCE_FILE" "$UWSM_TARGET_FILE"
