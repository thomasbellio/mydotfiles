clone_repo "$DOTFILES_GIT_DEFAULT_URL/$DOTFILES_GIT_DEFAULT_USER/zsh-syntax-highlighting.git" "$DOTFILES_SHELL_PLUGINS_DIR" "zsh-syntax-highlighting"

clone_repo "$DOTFILES_GIT_DEFAULT_URL/$DOTFILES_GIT_DEFAULT_USER/zsh-syntax-highlighting-catpuccin.git" "$DOTFILES_SHELL_PLUGINS_DIR" "zsh-syntax-highlighting-catpuccin"
source $DOTFILES_SHELL_PLUGINS_DIR/zsh-syntax-highlighting-catpuccin/themes/$DOTFILES_ZSH_SHELL_THEME-zsh-syntax-highlighting.zsh
source ${DOTFILES_SHELL_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


