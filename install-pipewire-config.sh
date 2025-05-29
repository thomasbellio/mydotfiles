#!/bin/zsh
mkdir -p "$XDG_CONFIG_HOME/wireplumber"
if [ -e "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf" ]; then
    echo "File exists at $XDG_CONFIG_HOME/wireplumber/wireplumber.conf. Creating backup."
    mv "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf" "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf.bak"
fi

echo "Creating symlink for wireplumber.conf."
ln -s $(pwd)/pipewire/wireplumber/wireplumber.conf "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf"

if [ -e "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf.d" ]; then
    echo "Directory exists at $XDG_CONFIG_HOME/wireplumber/wireplumber.conf.d. Creating backup."
    mv "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf.d" "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf.d.bak"
fi

echo "Creating symlink for wireplumber.conf.d."
ln -s $(pwd)/pipewire/wireplumber/wireplumber.conf.d "$XDG_CONFIG_HOME/wireplumber/wireplumber.conf.d"

mkdir -p "$XDG_CONFIG_HOME/pipewire"
if [ -e "$XDG_CONFIG_HOME/pipewire/pipewire.conf" ]; then
    echo "File exists at $XDG_CONFIG_HOME/pipewire/pipewire.conf. Creating backup."
    mv "$XDG_CONFIG_HOME/pipewire/pipewire.conf" "$XDG_CONFIG_HOME/pipewire/pipewire.conf.bak"
fi

echo "Creating symlink for pipewire.conf."
ln -s $(pwd)/pipewire/pipewire.conf "$XDG_CONFIG_HOME/pipewire/pipewire.conf"
