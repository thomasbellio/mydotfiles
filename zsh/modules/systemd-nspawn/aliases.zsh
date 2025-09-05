NVIDIA_BINDS="--bind=/dev/nvidia0 \
--bind=/dev/nvidiactl \
--bind=/dev/nvidia-modeset \
--bind=/usr/bin/nvidia-bug-report.sh:/usr/bin/nvidia-bug-report.sh \
--bind=/usr/bin/nvidia-cuda-mps-control:/usr/bin/nvidia-cuda-mps-control \
--bind=/usr/bin/nvidia-cuda-mps-server:/usr/bin/nvidia-cuda-mps-server \
--bind=/usr/bin/nvidia-debugdump:/usr/bin/nvidia-debugdump \
--bind=/usr/bin/nvidia-modprobe:/usr/bin/nvidia-modprobe \
--bind=/usr/bin/nvidia-ngx-updater:/usr/bin/nvidia-ngx-updater \
--bind=/usr/bin/nvidia-persistenced:/usr/bin/nvidia-persistenced \
--bind=/usr/bin/nvidia-powerd:/usr/bin/nvidia-powerd \
--bind=/usr/bin/nvidia-sleep.sh:/usr/bin/nvidia-sleep.sh \
--bind=/usr/bin/nvidia-smi:/usr/bin/nvidia-smi \
--bind=/usr/bin/nvidia-xconfig:/usr/bin/nvidia-xconfig \
--bind=/usr/lib/gbm/nvidia-drm_gbm.so:/usr/lib/x86_64-linux-gnu/gbm/nvidia-drm_gbm.so \
--bind=/usr/lib/libEGL_nvidia.so:/usr/lib/x86_64-linux-gnu/libEGL_nvidia.so \
--bind=/usr/lib/libGLESv1_CM_nvidia.so:/usr/lib/x86_64-linux-gnu/libGLESv1_CM_nvidia.so \
--bind=/usr/lib/libGLESv2_nvidia.so:/usr/lib/x86_64-linux-gnu/libGLESv2_nvidia.so \
--bind=/usr/lib/libGLX_nvidia.so:/usr/lib/x86_64-linux-gnu/libGLX_nvidia.so \
--bind=/usr/lib/libcuda.so:/usr/lib/x86_64-linux-gnu/libcuda.so \
--bind=/usr/lib/libnvcuvid.so:/usr/lib/x86_64-linux-gnu/libnvcuvid.so \
--bind=/usr/lib/libnvidia-allocator.so:/usr/lib/x86_64-linux-gnu/libnvidia-allocator.so \
--bind=/usr/lib/libnvidia-cfg.so:/usr/lib/x86_64-linux-gnu/libnvidia-cfg.so \
--bind=/usr/lib/libnvidia-egl-gbm.so:/usr/lib/x86_64-linux-gnu/libnvidia-egl-gbm.so \
--bind=/usr/lib/libnvidia-eglcore.so:/usr/lib/x86_64-linux-gnu/libnvidia-eglcore.so \
--bind=/usr/lib/libnvidia-encode.so:/usr/lib/x86_64-linux-gnu/libnvidia-encode.so \
--bind=/usr/lib/libnvidia-fbc.so:/usr/lib/x86_64-linux-gnu/libnvidia-fbc.so \
--bind=/usr/lib/libnvidia-glcore.so:/usr/lib/x86_64-linux-gnu/libnvidia-glcore.so \
--bind=/usr/lib/libnvidia-glsi.so:/usr/lib/x86_64-linux-gnu/libnvidia-glsi.so \
--bind=/usr/lib/libnvidia-glvkspirv.so:/usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so \
--bind=/usr/lib/libnvidia-ml.so:/usr/lib/x86_64-linux-gnu/libnvidia-ml.so \
--bind=/usr/lib/libnvidia-ngx.so:/usr/lib/x86_64-linux-gnu/libnvidia-ngx.so \
--bind=/usr/lib/libnvidia-opticalflow.so:/usr/lib/x86_64-linux-gnu/libnvidia-opticalflow.so \
--bind=/usr/lib/libnvidia-ptxjitcompiler.so:/usr/lib/x86_64-linux-gnu/libnvidia-ptxjitcompiler.so \
--bind=/usr/lib/libnvidia-rtcore.so:/usr/lib/x86_64-linux-gnu/libnvidia-rtcore.so \
--bind=/usr/lib/libnvidia-tls.so:/usr/lib/x86_64-linux-gnu/libnvidia-tls.so \
--bind=/usr/lib/libnvidia-vulkan-producer.so:/usr/lib/x86_64-linux-gnu/libnvidia-vulkan-producer.so \
--bind=/usr/lib/libnvoptix.so:/usr/lib/x86_64-linux-gnu/libnvoptix.so \
--bind=/usr/lib/modprobe.d/nvidia-utils.conf:/usr/lib/x86_64-linux-gnu/modprobe.d/nvidia-utils.conf \
--bind=/usr/lib/nvidia/wine/_nvngx.dll:/usr/lib/x86_64-linux-gnu/nvidia/wine/_nvngx.dll \
--bind=/usr/lib/nvidia/wine/nvngx.dll:/usr/lib/x86_64-linux-gnu/nvidia/wine/nvngx.dll \
--bind=/usr/lib/nvidia/xorg/libglxserver_nvidia.so:/usr/lib/x86_64-linux-gnu/nvidia/xorg/libglxserver_nvidia.so \
--bind=/usr/lib/vdpau/libvdpau_nvidia.so:/usr/lib/x86_64-linux-gnu/vdpau/libvdpau_nvidia.so \
--bind=/usr/lib/xorg/modules/drivers/nvidia_drv.so:/usr/lib/x86_64-linux-gnu/xorg/modules/drivers/nvidia_drv.so \
--bind=/usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf:/usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf \
--bind=/usr/share/dbus-1/system.d/nvidia-dbus.conf:/usr/share/dbus-1/system.d/nvidia-dbus.conf \
--bind=/usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json:/usr/share/egl/egl_external_platform.d/15_nvidia_gbm.json \
--bind=/usr/share/glvnd/egl_vendor.d/10_nvidia.json:/usr/share/glvnd/egl_vendor.d/10_nvidia.json \
--bind=/usr/share/licenses/nvidia-utils/LICENSE:/usr/share/licenses/nvidia-utils/LICENSE \
--bind=/usr/share/vulkan/icd.d/nvidia_icd.json:/usr/share/vulkan/icd.d/nvidia_icd.json \
--bind=/usr/share/vulkan/implicit_layer.d/nvidia_layers.json:/usr/share/vulkan/implicit_layer.d/nvidia_layers.json \
--property=DeviceAllow=/dev/dri rw \
--property=DeviceAllow=/dev/shm rw \
--property=DeviceAllow=/dev/nvidia0 rw \
--property=DeviceAllow=/dev/nvidiactl rw \
--property=DeviceAllow=/dev/nvidia-modeset rw"

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
                audio)
                    echo "Enabling audio support"
                    with_audio=true
                    ;;
                ui)
                    echo "Enabling UI support"
                    with_ui=true
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

    local bind_options=("--bind=$machine_dir:/run/user/1000" "--bind-ro=/run/user/1000/bus:/run/user/1000/bus")
    echo "Default bind options: ${bind_options[@]}"
    echo "with ui: $with_ui"
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
    echo "Starting machine with bind options: ${bind_options[@]}"
    sudo systemd-nspawn -D "/var/lib/machines/$machine_name" \
        --private-network --network-veth \
        ${bind_options[@]} \
        --property=DeviceAllow="char-drm rw" \
        --property=DeviceAllow="/dev/kvm rw" \
        --property=DeviceAllow="/dev/shm rw" \
        --boot
}
