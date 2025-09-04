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
    local with_ui="$2"
    local with_audio="$3"
    echo "Checking if the machine $machine_name is running..."
    # Check if the machine is already running
    if machinectl show "$machine_name" --property=State --value 2>/dev/null | grep -q "running"; then
        echo "The machine '$machine_name' is already running."
        return 0
    fi
    echo "Checking for directory $machine_dir existence..."
    # Check if the directory exists, if not, create it
    if [ ! -d "$machine_dir" ]; then
        echo "Directory: $machine_dir not found, creating...."
        mkdir -p "$machine_dir"
        echo "Successfully created directory: $machine_dir"
    else
        echo "$machine_dir already exists skipping creation..."
    fi

    local bind_options=("--bind=$machine_dir:/run/user/1000" "--bind-ro=/run/user/1000/bus:/run/user/1000/bus")
    echo "Default bind options: ${bind_options[@]}"
    echo "with ui: $with_ui"
    if [ "$with_ui" = "--with-ui" ]; then
        echo "Setting ui bindings..."
        ui_bind_options=("--bind-ro=/tmp/.X11-unix:/tmp/.X11-unix" "--bind-ro=/dev/kvm:/dev/kvm" "--bind=/dev/dri:/dev/dri" "--bind-ro=/run/user/1000/wayland-1:/run/user/1000/wayland-1")
        bind_options+=(${ui_bind_options[@]})
        echo "Set ui bind options: ${ui_bind_options[@]}"
    fi

    if [ "$with_audio" = "--with-audio" ]; then
        echo "Setting audio bindings ..."
        audio_bind_options=("--bind-ro=/sys/class/sound:/sys/class/sound" "--bind-ro=/proc/asound:/proc/asound" "--bind-ro=/sys/devices:/sys/devices" "--bind-ro=/lib/modules:/lib/modules"  "--bind-ro=/run/user/1000/pulse:/run/user/1000/pulse" "--bind-ro=/run/user/1000/pipewire-0.lock:/run/user/1000/pipewire-0.lock" "--bind-ro=/run/user/1000/pipewire-0-manager.lock:/run/user/1000/pipewire-0-manager.lock" "--bind-ro=/run/user/1000/pipewire-0-manager:/run/user/1000/pipewire-0-manager" "--bind-ro=/run/user/1000/pipewire-0:/run/user/1000/pipewire-0" "--bind-ro=/dev/snd:/dev/snd")
        bind_options+=(${audio_bind_options[@]})
        echo "Set audio bind options: ${audio_bind_options[@]}"

    fi
    echo "Starting machine with bind options: ${bind_options[@]}"
    sudo systemd-nspawn -D "/var/lib/machines/$machine_name" \
        --private-network --network-veth \
        ${bind_options[@]} \
        --property=DeviceAllow="char-drm rw" \
        --property=DeviceAllow="/dev/kvm rw" \
        --boot
}
