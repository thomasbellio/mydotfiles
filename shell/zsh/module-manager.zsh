# feature-manager.zsh
# central manager for modular ZSH configuration organized by application
source $DOTFILES_DIR/shell/zsh/helper-functions.zsh

ZSH_MODULES_DIR="${DOTFILES_DIR}/shell/zsh/modules"
# Define data structures
typeset -gA ZSH_MODULE_DIRS       # Maps module name to its directory
typeset -gA ZSH_REGISTERED_MODULES # Maps module name to its components (arrays)

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
function mm_load_modules_() {
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
function mm_init_module_manager_() {
    module_debug "Resetting module data structures"
    ZSH_MODULE_DIRS=()
    ZSH_REGISTERED_MODULES=()
    module_debug "Initializing ZSH Module Manager with module directory: $ZSH_MODULES_DIR"
}

# Call initialization
mm_init_module_manager_

