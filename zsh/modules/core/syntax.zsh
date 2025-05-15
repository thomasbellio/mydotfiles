cloneRepo "$DOTFILES_GIT_DEFAULT_URL/$ZSH_DEFAULT_GIT_USER/zsh-syntax-highlighting.git" "$ZSH_SHELL_PLUGINS_DIR" "zsh-syntax-highlighting"


cloneRepo "$DOTFILES_GIT_DEFAULT_URL/$ZSH_DEFAULT_GIT_USER/zsh-syntax-highlighting-catpuccin.git" "$ZSH_SHELL_PLUGINS_DIR" "zsh-syntax-highlighting-catpuccin"
source $ZSH_SHELL_PLUGINS_DIR/zsh-syntax-highlighting-catpuccin/themes/$ZSH_SHELL_THEME-zsh-syntax-highlighting.zsh
source ${HOME}/shell-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


