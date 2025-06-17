dev() {
    if [ -z "$1" ]; then
        echo "Usage: dev <container-name>"
        return 1
    fi

    # Check if the container is running
    if ! sudo lxc-info -n "$1" | grep -q "RUNNING"; then
        echo "Container $1 is not running. Starting it..."
        sudo lxc-start -n "$1"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to start container $1." >&2
            return 1
        fi
    fi

    # Attach to the container
    sudo lxc-attach -n "$1" -- su -l thomas-devel
}

base_64_encode(){
    $ENCODE=$(echo -n "$1" | base64)
    echo $ENCODE
    echo $ENCODE | pbcopy
}

my_ip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}


jwt_decode() {
    # Read the JWT from the first argument or from standard input
    local jwt="${1:-$(</dev/stdin)}"
    # Extract the payload part of the JWT, which is the second part after splitting by '.'
    local encoded_payload=$(echo "$jwt" | cut -d "." -f 2)

    # Decode the payload from Base64 URL to regular Base64
    local base64_payload=$(echo "$encoded_payload" | tr '_-' '+/' | tr -d '=')

    # Add required padding to Base64 string
    local mod=$((${#base64_payload} % 4))
    if [ $mod -eq 2 ]; then
        base64_payload="${base64_payload}=="
    elif [ $mod -eq 3 ]; then
        base64_payload="${base64_payload}="
    fi

    # Decode from Base64 and output
    echo "$base64_payload" | base64 -d 2>/dev/null

    # Check for decoding errors, likely due to invalid input
    if [ $? -ne 0 ]; then
        echo "Error: Failed to decode JWT payload. The token may be invalid." >&2
        return 1
    fi
}

