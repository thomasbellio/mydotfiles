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
    local options="$2"
    local machine_dir="/run/user/1000/$machine_name"
    local with_ui=false
    local with_audio=false
    local with_graphics=false
    local with_bus_support=false
    local with_options=""
   # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --with=*)
                with_options="${1#--with=}"
                shift
                ;;
            --with)
                with_options="$2"
                shift 2
                ;;
            *)
                if [[ -z "$machine_name" ]]; then
                    machine_name="$1"
                fi
                shift
                ;;
        esac
    done
    echo "WITH OPTIONS: $with_options"
    echo "MACHINE NAME: $machine_name"

        if [[ -z "$machine_name" ]]; then
        echo "Error: machine name is required"
        return 1
    fi

    echo "Starting machine: $machine_name"

    # Parse the comma-separated options if provided
    if [[ -n "$with_options" ]]; then
        # Split on commas and iterate through options
        local IFS=','
        local options_array=(${=with_options})

        echo "Options provided:"
        for option in "${options_array[@]}"; do
            # Trim whitespace
            option=$(echo "$option" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            echo "  - $option"

            # Handle specific options
            case "$option" in
                graphics)
                    echo "enabling graphics support"
                    with_graphics=true
                    ;;
                audio)
                    echo "Enabling audio support"
                    with_audio=true
                    ;;
                ui)
                    echo "Enabling UI support"
                    with_ui=true
                    ;;
                bus-support)
                    echo "Enabling bus support"
                    with_bus_support=true
                    ;;
                *)
                    echo "    Unknown option: $option"
                    ;;
            esac
        done
    else
        echo "No additional options specified"
    fi
       echo "with_ui: ${with_ui}, with_audio: ${with_audio}"
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
    local properties=("--property=DeviceAllow=char-drm rw")
    local bind_options=("--bind=$machine_dir:/run/user/1000" "--bind-ro=/run/user/1000/bus:/run/user/1000/bus")
    echo "Default bind options: ${bind_options[@]}"
    echo "with ui: $with_ui"
    if [ "$with_graphics" = true ]; then
        graphic_bind_options=(
            "--bind=/dev/nvidia0:/dev/nvidia0"
            "--bind=/dev/nvidia-modeset:/dev/nvidia-modeset"
            "--bind=/dev/nvidia-uvm:/dev/nvidia-uvm"
            "--bind=/dev/nvidia-uvm-tools:/dev/nvidia-uvm-tools"
            "--bind=/dev/nvidiactl:/dev/nvidiactl"
            "--bind=/sys/module/nvidia"
            "--bind=/sys/module/nvidia_drm"
            "--bind=/sys/module/nvidia_modeset"
            "--bind=/sys/module/nvidia_uvm"
        )
        graphic_properties=(
            "--property=DeviceAllow=/dev/kvm rw"
            "--property=DeviceAllow=/dev/nvidia0 rw"
            "--property=DeviceAllow=/dev/nvidia-modeset rw"
            "--property=DeviceAllow=/dev/nvidia-uvm rw"
            "--property=DeviceAllow=/dev/nvidia-uvm-tools rw"
            "--property=DeviceAllow=/dev/nvidiactl rw"
            "--property=DeviceAllow=/dev/shm rw"
        )
        bind_options+=(${graphic_bind_options[@]})
        properties+=(${graphic_properties[@]})
    fi
    if [ "$with_ui" = true ]; then
        echo "Setting ui bindings..."
        ui_bind_options=( "--bind=/dev/shm:/dev/shm" "--bind-ro=/etc/X11/xorg.conf.d:/etc/X11/xorg.conf.d" "--bind-ro=/tmp/.X11-unix:/tmp/.X11-unix" "--bind=/dev/kvm:/dev/kvm" "--bind=/dev/dri:/dev/dri" "--bind-ro=/run/user/1000/wayland-1:/run/user/1000/wayland-1")
        bind_options+=(${ui_bind_options[@]})
        echo "Set ui bind options: ${ui_bind_options[@]}"
    fi

    if [ "$with_audio" = true ]; then
        echo "Setting audio bindings ..."
        audio_bind_options=("--bind-ro=/sys/class/sound:/sys/class/sound" "--bind-ro=/proc/asound:/proc/asound" "--bind-ro=/sys/devices:/sys/devices" "--bind-ro=/lib/modules:/lib/modules"  "--bind-ro=/run/user/1000/pulse:/run/user/1000/pulse" "--bind-ro=/run/user/1000/pipewire-0.lock:/run/user/1000/pipewire-0.lock" "--bind-ro=/run/user/1000/pipewire-0-manager.lock:/run/user/1000/pipewire-0-manager.lock" "--bind-ro=/run/user/1000/pipewire-0-manager:/run/user/1000/pipewire-0-manager" "--bind-ro=/run/user/1000/pipewire-0:/run/user/1000/pipewire-0" "--bind-ro=/dev/snd:/dev/snd")
        bind_options+=(${audio_bind_options[@]})
        echo "Set audio bind options: ${audio_bind_options[@]}"
    fi

    if [ "$with_bus_support" = true ]; then
        echo "Setting bus support bindings..."
        bus_bind_options=("--bind=/dev/bus/usb:/dev/bus/usb")
        bus_properties=("--property=DeviceAllow=char-usb_device rwm")
        bind_options+=(${bus_bind_options[@]})
        properties+=(${bus_properties[@]})
        echo "Set bus support bind options: ${bus_bind_options[@]}"
    fi
    echo "Starting machine with bind options: ${bind_options[@]}"
    echo "Starting machine with properties: ${properties[@]}"
    echo "sudo systemd-nspawn -D \"/var/lib/machines/$machine_name\" --private-network --network-veth ${bind_options[@]} ${properties[@]} --boot"
    sudo systemd-nspawn -D "/var/lib/machines/$machine_name" --private-network --network-veth ${bind_options[@]} ${properties[@]} --boot
}
