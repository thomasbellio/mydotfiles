alias zource="source ~/.zprofile && source ~/.zshrc"
alias zv="nvim ~/.zshrc"
alias ls="ls -alhG --color=auto"
alias copy="wl-copy"
alias paste="wl-paste"
dev_shell() {
    local machine_name="$1"
    sudo machinectl shell thomas-devel@"$machine_name" /usr/bin/env WAYLAND_DISPLAY="$WAYLAND_DISPLAY" /usr/bin/zsh -l
}
