dev_shell() {
    local machine_name="$1"
    sudo machinectl shell thomas-devel@"$machine_name" /usr/bin/env WAYLAND_DISPLAY="$WAYLAND_DISPLAY" /usr/bin/zsh -l
}

power_off() {
    local machine_name="$1"
    sudo machinectl poweroff "$machine_name"
}

start_machine() {
    local machine_name="$1"
    local machine_dir="/run/user/1000/$machine_name"
    local no_daemon="$2"
    echo "Checking if the machine $machine_name is running..."
    # Check if the machine is already running
    if machinectl show "$machine_name" --property=State --value 2>/dev/null | grep -q "running"; then
        echo "The machine '$machine_name' is already running."
        return 0
    fi
    echo "Checking for directory existence..."
    # Check if the directory exists, if not, create it
    if [ ! -d "$machine_dir" ]; then
        mkdir -p "$machine_dir"
    fi

    sudo systemd-nspawn -D "/var/lib/machines/$machine_name" \
        --private-network --network-veth \
        --bind="/tmp/.X11-unix:/tmp/.X11-unix" \
        --bind="/dev/kvm:/dev/kvm" --bind="/dev/dri:/dev/dri" \
        --bind="$machine_dir:/run/user/1000" \
        --bind-ro="/run/user/1000/pulse:/run/user/1000/pulse"  \
        --bind-ro="/run/user/1000/pipewire-0:/run/user/1000/pipewire-0"  \
        --bind-ro="/run/user/1000/wayland-1:/run/user/1000/wayland-1" \
        --property=DeviceAllow="char-drm rw" \
        --property=DeviceAllow="/dev/kvm rw" \
        --boot
}
