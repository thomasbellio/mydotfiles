# feature-manager.zsh
# Core manager for modular ZSH configuration organized by application

# Store the dotfiles directory for reference
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/code/mydotfiles}"

# Define data structures
typeset -gA ZSH_FEATURES           # Maps feature name to its dependencies
typeset -gA ZSH_FEATURE_DIRS       # Maps feature name to its directory
typeset -gA ZSH_FEATURE_COMPONENTS # Maps feature name to its components (arrays)
typeset -gA ZSH_FEATURE_ENABLED    # Maps feature name to enable status (0/1)
typeset -gA ZSH_FEATURE_MISSING    # Maps feature name to missing dependencies

# Debug mode (set to 1 to enable verbose logging)
ZSH_FEATURE_DEBUG=${ZSH_FEATURE_DEBUG:-0}

# Standard component types
ZSH_COMPONENT_TYPES=("core" "aliases" "completions" "functions" "environment")

# Function to log debug messages
function _feature_debug() {
  [[ $ZSH_FEATURE_DEBUG -eq 1 ]] && echo "[DEBUG] $@"
}

# Function to register a feature with its dependencies
function register_feature() {
  local feature=$1
  local dir="${2:-$DOTFILES_DIR/$feature}"
  shift 2

  # Register the feature and its directory
  ZSH_FEATURES[$feature]="${(j: :)@}"
  ZSH_FEATURE_DIRS[$feature]="$dir"

  # Initialize as disabled by default
  ZSH_FEATURE_ENABLED[$feature]=0

  # Detect available components for this feature
  local components=()

  # First check for a single consolidated file
  if [[ -f "$DOTFILES_DIR/${feature}.zsh" ]]; then
    _feature_debug "Found consolidated file for $feature"
    components+=("${DOTFILES_DIR}/${feature}.zsh")
  else
    # Check for component files in the feature directory
    for component in $ZSH_COMPONENT_TYPES; do
      local component_file="$dir/${component}.zsh"
      if [[ -f $component_file ]]; then
        _feature_debug "Found component $component for $feature"
        components+=($component_file)
      fi
    done
  fi

  # Store the components
  ZSH_FEATURE_COMPONENTS[$feature]="${(j:,:)components}"

  _feature_debug "Registered feature: $feature (dependencies: ${(j:, :)@})"
  _feature_debug "Components: ${(j:, :)components}"
}

# Function to register a nested feature (like hashicorp/packer)
function register_nested_feature() {
  local parent=$1
  local feature=$2
  local dir="${3:-$DOTFILES_DIR/$parent/$feature}"
  shift 3

  # Register with a namespaced name
  register_feature "${parent}/${feature}" "$dir" "$@"
}

# Function to check if a command exists
function has_command() {
  command -v $1 >/dev/null 2>&1
}

# Function to check dependencies for a feature
function check_dependencies() {
  local feature=$1
  local deps=(${=ZSH_FEATURES[$feature]})
  local missing=()

  _feature_debug "Checking dependencies for $feature: ${(j:, :)deps}"

  # Special case: no dependencies
  if [[ ${#deps} -eq 0 || ${deps[1]} == "" ]]; then
    ZSH_FEATURE_MISSING[$feature]=""
    return 0
  fi

  # Check each dependency
  for dep in $deps; do
    if ! has_command $dep; then
      _feature_debug "Missing dependency: $dep"
      missing+=($dep)
    fi
  done

  # Store missing dependencies
  ZSH_FEATURE_MISSING[$feature]="${(j: :)missing}"

  # Return success if no missing dependencies
  return $((${#missing} > 0))
}

# Function to enable a feature
function enable_feature() {
  local feature=$1
  local force=$2

  # Skip if feature doesn't exist
  if [[ -z "${ZSH_FEATURES[$feature]}" ]]; then
    echo "Error: Feature '$feature' is not registered"
    return 1
  fi

  # Skip if already enabled
  if [[ ${ZSH_FEATURE_ENABLED[$feature]} -eq 1 ]]; then
    _feature_debug "Feature '$feature' is already enabled"
    return 0
  fi

  # Check dependencies unless forced
  if [[ "$force" != "force" ]]; then
    if ! check_dependencies $feature; then
      echo "Error: Cannot enable '$feature'. Missing dependencies: ${ZSH_FEATURE_MISSING[$feature]}"
      return 1
    fi
  fi

  # Load each component
  local components=(${(s:,:)ZSH_FEATURE_COMPONENTS[$feature]})

  if [[ ${#components} -eq 0 ]]; then
    echo "Warning: No components found for feature '$feature'"
  else
    for component in $components; do
      _feature_debug "Sourcing component: $component"
      source $component
    done
  fi

  # Mark as enabled
  ZSH_FEATURE_ENABLED[$feature]=1

  return 0
}

# Function to list all features and their status
function list_features() {
  local width=30

  echo "Available ZSH Features:"
  echo "======================="
  echo "Feature${(l:$width-7:: :)}Status  Dependencies"
  echo "-------${(l:$width-7::-:)}------  -----------"

  for feature in ${(ok)ZSH_FEATURES}; do
    local status="Disabled"
    [[ ${ZSH_FEATURE_ENABLED[$feature]} -eq 1 ]] && status="Enabled "

    local deps="${ZSH_FEATURES[$feature]}"
    [[ -z "$deps" ]] && deps="none"

    printf "%-${width}s %s  %s\n" $feature $status $deps

    # Show components if debug is enabled
    if [[ $ZSH_FEATURE_DEBUG -eq 1 ]]; then
      local components=(${(s:,:)ZSH_FEATURE_COMPONENTS[$feature]})
      for component in $components; do
        printf "  - %s\n" $component
      done
    fi
  done
}

# Function to load features from config file
function load_feature_config() {
  local config_file="$HOME/.zshfeatures"

  # Create default config if it doesn't exist
  if [[ ! -f $config_file ]]; then
    _feature_debug "Creating default feature config"
    echo "# ZSH Feature Configuration" > $config_file
    echo "# Set to 1 to enable, 0 to disable" >> $config_file

    for feature in ${(k)ZSH_FEATURES}; do
      echo "ZSH_FEATURE_ENABLED[$feature]=1" >> $config_file
    done
  fi

  # Source the config file
  _feature_debug "Loading feature config from $config_file"
  source $config_file
}

# Function to load all enabled features
function load_features() {
  local requested=("$@")

  # If specific features requested, enable only those
  if [[ ${#requested} -gt 0 ]]; then
    for feature in $requested; do
      enable_feature $feature
    done
    return
  fi

  # Otherwise load from config
  load_feature_config

  # Try to enable each feature marked as enabled in config
  for feature in ${(k)ZSH_FEATURE_ENABLED}; do
    if [[ ${ZSH_FEATURE_ENABLED[$feature]} -eq 1 ]]; then
      enable_feature $feature
    else
      _feature_debug "Skipping disabled feature: $feature"
    fi
  done
}

# Initialize feature manager
function init_feature_manager() {
  _feature_debug "Initializing ZSH Feature Manager"
}

# Call initialization
init_feature_manager
