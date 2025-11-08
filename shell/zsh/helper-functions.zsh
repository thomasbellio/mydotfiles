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


function clone_repo() {
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

