# feature-manager.zsh
# Core manager for modular ZSH configuration organized by application

# Store the dotfiles directory for reference
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/code/mydotfiles}"

# Define data structures
typeset -gA ZSH_FEATURES           # Maps feature name to its dependencies
typeset -gA ZSH_FEATURE_DIRS       # Maps feature name to its directory
typeset -gA ZSH_FEATURE_COMPONENTS # Maps feature name to its components (arrays)

# Debug mode (set to 1 to enable verbose logging)
ZSH_FEATURE_DEBUG=${ZSH_FEATURE_DEBUG:-0}

# Standard component types
ZSH_COMPONENT_TYPES=("bootstrap" "core" "aliases" "functions" "completions" "environment" "config", "plugins" "prompt")

# Function to log debug messages
function _feature_debug() {
  [[ $ZSH_FEATURE_DEBUG -eq 1 ]] && echo "[DEBUG] $@"
}

# Function to register a feature with its dependencies
function register_feature() {
  _feature_debug "ENTER REGISTER FEATURE"
  local feature=$1
  local dir="${2:-$DOTFILES_DIR/$feature}"
  _feature_debug "Registering feature: $feature...."

  # Register the feature and its directory
  #  ZSH_FEATURES[$feature]="${(j: :)@}"
  ZSH_FEATURE_DIRS[$feature]="$dir"
  _feature_debug "Registered the feature: $feature"
  _feature_debug "Registred the feature dir: $dir. The new ZSH_FEATURE_DIRS map is: $ZSH_FEATURE_DIRS"
  # Initialize as disabled by default

  # Detect available components for this feature
  local components=()

  # First check for a single consolidated file
  if [[ -f "$DOTFILES_DIR/${feature}.zsh" ]]; then
    _feature_debug "Found consolidated file for $feature"
    components+=("${DOTFILES_DIR}/${feature}.zsh")
  else
    _feature_debug "Did not find consolidated file for $feature loading components from directory: $dir"
    # Check for component files in the feature directory
    for component in $ZSH_COMPONENT_TYPES; do
      local component_file="$dir/${component}.zsh"
      _feature_debug "Looking for the component file: $component_file"
      if [[ -f $component_file ]]; then
        _feature_debug "Found component $component for $feature"
        components+=($component_file)
      else
        _feature_debug "No $component file found for $feature, skipping...."
      fi
    done
  fi

  # Store the components
  ZSH_FEATURE_COMPONENTS[$feature]="${(j:,:)components}"
  _feature_debug "Components: ${(j:, :)components}"
  _feature_debug "EXIT REGISTER FEATURE"

}

# Function to enable a feature
function enable_feature() {
  _feature_debug "ENTER ENABLE FEATURE"
  local feature=$1
    _feature_debug "enabling: $feature"
  # Load each component
  local components=(${(s:,:)ZSH_FEATURE_COMPONENTS[$feature]})

    _feature_debug "enabling components for feature $feature: $components"
  if [[ ${#components} -eq 0 ]]; then
    echo "Warning: No components found for feature '$feature'"
  else
    for component in $components; do
      _feature_debug "Sourcing component: $component"
      source $component
    done
  fi
  _feature_debug "EXIT ENABLE FEATURE"

  return 0
}

# Function to load all enabled features
function load_features() {
  _feature_debug "ENTER LOAD FEATURES"

  # Try to enable each feature marked as enabled in config
  for feature in ${(k)ZSH_FEATURE_COMPONENTS}; do
      _feature_debug "Enabling the feature: $feature"
       enable_feature $feature
  done
  _feature_debug "EXIT LOAD FEATURES"
}

# Initialize feature manager
function init_feature_manager() {
  _feature_debug "Initializing ZSH Feature Manager"
}

# Call initialization
init_feature_manager
