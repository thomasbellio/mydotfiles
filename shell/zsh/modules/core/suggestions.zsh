GIT_DEFAULT_URL="${DOTFILES_GIT_DEFAULT_URL:-https://github.com}"
GIT_DEFAULT_USER="${DOTFILES_GIT_DEFAULT_USER:-thomasbellio}"

SHELL_PLUGINS_DIR="${DOTFILES_SHELL_PLUGINS_DIR:-$HOME/shell-plugins}"
[[ ! -d "$SHELL_PLUGINS_DIR" ]] && mkdir -p "$SHELL_PLUGINS_DIR"

cloneRepo "$GIT_DEFAULT_URL/$GIT_DEFAULT_USER/zsh-autosuggestions.git" "$SHELL_PLUGINS_DIR" "zsh-autosuggestions"
source $SHELL_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh


