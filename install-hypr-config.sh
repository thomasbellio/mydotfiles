#!/usr/bin/zsh

link_config() {
    local app_name="$1"
    local source_file="$2"
    local target_file="$3"
    local target_dir

    target_dir="$(dirname "$target_file")"

    # Create target directory if it doesn't exist
    if [ ! -d "$target_dir" ]; then
        echo "[$app_name] Creating target directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # Check if the target file already exists
    if [ -e "$target_file" ]; then
        echo "[$app_name] Target file already exists. Creating backup."
        mv "$target_file" "$target_file.bak"
    fi

    # Create the symlink
    echo "[$app_name] Creating symlink from $source_file to $target_file"
    ln -s "$source_file" "$target_file"
}

# Define hypr source and target paths
HYPR_SOURCE_FILE="$(pwd)/hypr/hyprland.conf"
HYPR_TARGET_FILE="$XDG_CONFIG_HOME/hypr/hyprland.conf"

# Define uwsm source and target paths
UWSM_SOURCE_FILE="$(pwd)/hypr/uwsm/env-hyprland"
UWSM_TARGET_FILE="$XDG_CONFIG_HOME/uwsm/env-hyprland"

DUNST_SOURCE_FILE="$(pwd)/hypr/dunst/dunstrc"
DUNST_TARGET_FILE="$XDG_CONFIG_HOME/dunst/dunstrc"

HYPRLOCK_SOURCE_FILE="$(pwd)/hypr/hyprlock.conf"
HYPRLOCK_TARGET_FILE="$XDG_CONFIG_HOME/hypr/hyprlock.conf"

HYPRLOCK_SOURCE_FILE="$(pwd)/hypr/hypridle.conf"
HYPRLOCK_TARGET_FILE="$XDG_CONFIG_HOME/hypr/hypridle.conf"

# Link configurations
link_config 'hyprland' "$HYPR_SOURCE_FILE" "$HYPR_TARGET_FILE"
link_config 'uwsm' "$UWSM_SOURCE_FILE" "$UWSM_TARGET_FILE"
link_config 'dunst' "$DUNST_SOURCE_FILE" "$DUNST_TARGET_FILE"
link_config 'hyprlock' "$HYPRLOCK_SOURCE_FILE" "$HYPRLOCK_TARGET_FILE"

