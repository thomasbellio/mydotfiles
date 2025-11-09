if [[ -f "${DOTFILES_SHELL_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source ${DOTFILES_SHELL_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    module_error "File does not exist: ${DOTFILES_SHELL_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
