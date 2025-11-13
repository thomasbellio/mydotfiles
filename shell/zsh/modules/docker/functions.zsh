docker_start() {
    local image="$1"
    local containerName="$2"
    local user="$3"
    shift 3
    local volumes=("$@")

    # Check if container with the same name is already running
    if docker ps --format "table {{.Names}}" | grep -q "^${containerName}$"; then
        echo "Container '${containerName}' is already running"
        return 0
    fi

    # Build docker run command
    local docker_cmd="docker run --add-host=host.docker.internal:host-gateway -d --name ${containerName} --user $(id -u):$(id -g)"

    # Add volume mounts if provided
    for volume in "${volumes[@]}"; do
        docker_cmd="${docker_cmd} -v ${volume}"
    done

    # Add image and command
    docker_cmd="${docker_cmd} ${image} /bin/sh -c 'sleep infinity'"

    # Execute the command
    eval $docker_cmd
}

docker_shell() {
    local containerName="$1"
    local userName="$2"

    # Check if container exists and is running
    if ! docker ps --format "table {{.Names}}" | grep -q "^${containerName}$"; then
        echo "Container '${containerName}' is not running or does not exist" >&2
        return 1
    fi

    # Determine working directory based on user
    local workdir
    if [[ "${userName}" == "root" ]]; then
        workdir="/root"
    else
        workdir="/home/${userName}"
    fi

    # Execute zsh login shell in the container
    docker exec -it --user "${userName}" --workdir "${workdir}" "${containerName}" zsh -l
}

docker_stop() {
    local containerName
    local clean_flag=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --clean)
                clean_flag=true
                shift
                ;;
            *)
                containerName="$1"
                shift
                ;;
        esac
    done

    # Check if container name was provided
    if [[ -z "${containerName}" ]]; then
        echo "Container name is required" >&2
        return 1
    fi

    # Check if container is running
    if docker ps --format "table {{.Names}}" | grep -q "^${containerName}$"; then
        echo "Stopping container '${containerName}'"
        docker stop "${containerName}"
    elif docker ps -a --format "table {{.Names}}" | grep -q "^${containerName}$"; then
        echo "Container '${containerName}' is not running"
    else
        echo "Container '${containerName}' does not exist" >&2
        return 1
    fi

    # Remove container if --clean flag is set
    if [[ "${clean_flag}" == true ]]; then
        if docker ps -a --format "table {{.Names}}" | grep -q "^${containerName}$"; then
            echo "Removing container '${containerName}'"
            docker rm "${containerName}"
        else
            echo "Container '${containerName}' does not exist to remove" >&2
            return 1
        fi
    fi
}
