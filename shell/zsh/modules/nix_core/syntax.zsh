if [[ -f "$DOTFILES_SHELL_PLUGINS_DIR/zsh-syntax-highlighting-catpuccin/themes/$DOTFILES_ZSH_SHELL_THEME-zsh-syntax-highlighting.zsh" ]]; then
    source $DOTFILES_SHELL_PLUGINS_DIR/zsh-syntax-highlighting-catpuccin/themes/$DOTFILES_ZSH_SHELL_THEME-zsh-syntax-highlighting.zsh
else
    module_error "File does not exist: $DOTFILES_SHELL_PLUGINS_DIR/zsh-syntax-highlighting-catpuccin/themes/$DOTFILES_ZSH_SHELL_THEME-zsh-syntax-highlighting.zsh"
fi

if [[ -f "${DOTFILES_SHELL_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source ${DOTFILES_SHELL_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    module_error "File does not exist: ${DOTFILES_SHELL_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

