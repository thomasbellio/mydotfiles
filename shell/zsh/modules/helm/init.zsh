if ! command -v helm &> /dev/null; then
    module_debug "helm not installed skipping helm features"
    return
fi
source_module

