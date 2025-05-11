function cloneRepo() {
  _feature_debug "ENTER CLONE REPO...."
    local repoName=$1
    local dirPrefix=$2
    local targetDir=$3
  _feature_debug "Setting up repo name: $repoName at: $dirPrefix/$targetDir"
    # # Check if the directory already exists
    if [ ! -d "$dirPrefix/$targetDir" ]; then
      _feature_debug "Cloning $repoName repository..."
      # Create parent directory if it doesn't exist
      mkdir -p $dirPrefix
      # Clone the repository
      git clone $repoName "$dirPrefix/$targetDir"
      _feature_debug "Repository cloned successfully to $targetDir"
    else
      _feature_debug "Repository already exists at $targetDir"
    fi
  _feature_debug "EXIT CLONE REPO...."
}

cloneRepo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${HOME}/shell-plugins" "/zsh-syntax-highlighting"
cloneRepo "https://github.com/zsh-users/zsh-autosuggestions.git" "${HOME}/shell-plugins" "/zsh-autosuggestions/"

cloneRepo "https://github.com/sindresorhus/pure.git" "${HOME}/.zsh" "/pure/"


