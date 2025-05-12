# feature-manager.zsh
# central manager for modular ZSH configuration organized by application

# Store the dotfiles directory for reference
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/code/mydotfiles}"
ZSH_MODULES_DIR="${DOTFILES_DIR}/zsh/modules"
# Define data structures
typeset -gA ZSH_MODULE_DIRS       # Maps module name to its directory
typeset -gA ZSH_REGISTERED_MODULES # Maps module name to its components (arrays)

# Debug mode (set to 1 to enable verbose logging)

function source_module() {
  _module_debug "ENTER SOURCE MODULE FOR MODULE: $module at path $component"
  local current_dir="$(dirname $component)"
  _module_debug "Current directory: $current_dir"

  # Get all items in the directory
  for item in "$current_dir"/*; do
    # Skip the component file itself
    if [[ "$item" == "$component" ]]; then
      continue
    fi

    # Handle directories
    if [[ -d "$item" ]]; then
      local init_file="$item/init.zsh"
      if [[ -f "$init_file" ]]; then
        _module_debug "Sourcing init file $init_file..."
        source "$init_file"
        _module_debug "Sourced init file: $init_file"
      fi
    # Handle .zsh files
    elif [[ "$item" == *.zsh ]] && [[ -f "$item" ]]; then
      _module_debug "Sourcing file: $item...."
      source "$item"
      _module_debug "Sourced file: $item"
    fi
  done
  _module_debug "EXIT SOURCE MODULE"
}


# Function to log debug messages
function _module_debug() {
  [[ $ZSH_MODULE_DEBUG -eq 1 ]] && echo "[DEBUG] $@"
}

# Function to register a module with its dependencies
function register_module() {
  _module_debug "ENTER REGISTER MODULE"
  local module=$1
  local dir="${ZSH_MODULES_DIR}/$module"
  _module_debug "Registering module: $module...."
  # Register the module and its directory
  # Initialize as disabled by default

  # Detect available components for this module
  local components=()

  # Check for a single consolidated file
  local module_file="$ZSH_MODULES_DIR/${module}.zsh"
  _module_debug "Checking for module file: $module_file"
  if [[ -f "$module_file" ]]; then
    _module_debug "Found consolidated file for $module"
    components+=("$module_file")
    _module_debug "Registered the module: $module_file"
  else
    _module_debug "Did not find consolidated file for module '$module', checking for directory: $dir"
    # Check for init file in the module directory
    module_file="$dir/init.zsh"
    _module_debug "Looking for the init file: $moudle_file"
    if [[ -f $module_file ]]; then
        _module_debug "Found init file for $module"
        components+=($module_file)
        _module_debug "Registered the module: $module_file"
    else
        _module_debug "No init file found for $module, skipping...."
    fi
  fi

  # Store the components
  ZSH_REGISTERED_MODULES[$module]="${(j:,:)components}"
  _module_debug "Components: ${(j:, :)components}"
  _module_debug "EXIT REGISTER MODULE"
}

# Function to enable a module
function enable_module() {
  _module_debug "ENTER ENABLE MODULE"
  local module=$1
    _module_debug "enabling: $module"
  # Load each component
  local components=(${(s:,:)ZSH_REGISTERED_MODULES[$module]})

    _module_debug "enabling components for module $module: $components"
  if [[ ${#components} -eq 0 ]]; then
    echo "Warning: No components found for module '$module'"
  else
    for component in $components; do
      _module_debug "Sourcing component: $component"
      source $component
    done
  fi
  _module_debug "EXIT ENABLE MODULE"

  return 0
}

# Function to load all enabled modules
function load_modules() {
  _module_debug "ENTER LOAD modules"

  # Try to enable each module marked as enabled in config
  for module in ${(k)ZSH_REGISTERED_MODULES}; do
        _module_debug "Enabling the module: $module"
        CURRENT_MODULE_PATH=$module
        enable_module $module

  done
  # the +X enables tracing for debugging autoload -U +X bashcompinit && bashcompinit
    autoload -U  bashcompinit && bashcompinit
    _module_debug "EXIT LOAD modules"
}

# Initialize module manager
function init_module_manager() {
    _module_debug "Resetting module data structures"
    ZSH_MODULE_DIRS=()
    ZSH_REGISTERED_MODULES=()
    _module_debug "Initializing ZSH Module Manager with module directory: $ZSH_MODULES_DIR"
}

function cloneRepo() {
  _module_debug "ENTER CLONE REPO...."
    local repoName=$1
    local dirPrefix=$2
    local targetDir=$3
  _module_debug "Setting up repo name: $repoName at: $dirPrefix/$targetDir"
    # # Check if the directory already exists
    if [ ! -d "$dirPrefix/$targetDir" ]; then
      _module_debug "Cloning $repoName repository..."
      # Create parent directory if it doesn't exist
      mkdir -p $dirPrefix
      # Clone the repository
      git clone $repoName "$dirPrefix/$targetDir"
      _module_debug "Repository cloned successfully to $targetDir"
    else
      _module_debug "Repository already exists at $targetDir"
    fi
  _module_debug "EXIT CLONE REPO...."
}
# Call initialization
init_module_manager

