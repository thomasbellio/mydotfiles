# feature-manager.zsh
# central manager for modular ZSH configuration organized by application

ZSH_MODULES_DIR="${DOTFILES_DIR}/shell/zsh/modules"
# Define data structures
typeset -gA ZSH_MODULE_DIRS       # Maps module name to its directory
typeset -gA ZSH_REGISTERED_MODULES # Maps module name to its components (arrays)

# Debug mode (set to 1 to enable verbose logging)

function source_module() {
  module_debug "ENTER SOURCE MODULE FOR MODULE: $module at path $module_file"
  local current_dir="$(dirname $module_file)"
  module_debug "Current directory: $current_dir"

  # Get all items in the directory
  for item in "$current_dir"/*; do
    # Skip the component file itself
    if [[ "$item" == "$module_file" ]]; then
      continue
    fi

    # Handle directories
    if [[ -d "$item" ]]; then
      local init_file="$item/init.zsh"
      if [[ -f "$init_file" ]]; then
        module_debug "Sourcing init file $init_file..."
        source "$init_file"
        module_debug "Sourced init file: $init_file"
      fi
    # Handle .zsh files
    elif [[ "$item" == *.zsh ]] && [[ -f "$item" ]]; then
      module_debug "Sourcing file: $item...."
      source "$item"
      module_debug "Sourced file: $item"
    fi
  done
  module_debug "EXIT SOURCE MODULE"
}


# Function to log debug messages
function module_debug() {
  [[ $DOTFILES_ZSH_MODULE_DEBUG -eq 1 ]] && echo "[DEBUG] $@"
}

# Function to register a module with its dependencies
function register_module() {
  module_debug "ENTER REGISTER MODULE"
  local module=$1
  local dir="${ZSH_MODULES_DIR}/$module"
  module_debug "Registering module: $module...."

  # Check for init file in the module directory
  local module_file="$dir/init.zsh"
  module_debug "Looking for the init file: $module_file"
  if [[ -f $module_file ]]; then
    module_debug "Found init file for $module"
    ZSH_REGISTERED_MODULES[$module]=$module_file
    module_debug "Registered the module: $module_file"
  else
    module_debug "No init file found for $module, skipping...."
  fi

  module_debug "EXIT REGISTER MODULE"
}

# Function to enable a module
function mm_enable_module_() {
  module_debug "ENTER ENABLE MODULE"
  local module=$1
  module_debug "enabling: $module"

  # Load the module file
  local module_file=${ZSH_REGISTERED_MODULES[$module]}

  module_debug "enabling module file for module $module: $module_file"
  if [[ -z $module_file ]]; then
    echo "Warning: No module file found for module '$module'"
  else
    module_debug "Sourcing module file: $module_file"
    source $module_file
  fi
  module_debug "EXIT ENABLE MODULE"

  return 0
}
# Function to load all enabled modules
function load_modules() {
  module_debug "ENTER LOAD modules"

  # Try to enable each module marked as enabled in config
  for module in ${(k)ZSH_REGISTERED_MODULES}; do
        module_debug "Enabling the module: $module"
        CURRENT_MODULE_PATH=$module
        mm_enable_module_ $module

  done
  # the +X enables tracing for debugging autoload -U +X bashcompinit && bashcompinit
  module_debug "Initializing completions"
  autoload -Uz  compinit && compinit
  module_debug "EXIT LOAD modules"
}

# Initialize module manager
function init_module_manager() {
    module_debug "Resetting module data structures"
    ZSH_MODULE_DIRS=()
    ZSH_REGISTERED_MODULES=()
    module_debug "Initializing ZSH Module Manager with module directory: $ZSH_MODULES_DIR"
}

function cloneRepo() {
  module_debug "ENTER CLONE REPO...."
    local repoName=$1
    local dirPrefix=$2
    local targetDir=$3
  module_debug "Setting up repo name: $repoName at: $dirPrefix/$targetDir"
    # # Check if the directory already exists
    if [ ! -d "$dirPrefix/$targetDir" ]; then
      module_debug "Cloning $repoName repository..."
      # Create parent directory if it doesn't exist
      mkdir -p $dirPrefix
      # Clone the repository
      git clone $repoName "$dirPrefix/$targetDir"
      module_debug "Repository cloned successfully to $targetDir"
    else
      module_debug "Repository already exists at $targetDir"
    fi
  module_debug "EXIT CLONE REPO...."
}
# Call initialization
init_module_manager

