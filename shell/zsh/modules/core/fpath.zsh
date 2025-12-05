if [[ ! " ${fpath[@]} " =~ " $HOME/.zsh " ]]; then
    fpath=($HOME/.zsh $fpath)
fi

if [[ ! -d "$HOME/.zsh/completions" ]]; then
    mkdir -p "$HOME/.zsh/completions"
fi

if [[ ! " ${fpath[@]} " =~ " $HOME/.zsh/completions " ]]; then
    fpath=($HOME/.zsh/completions $fpath)
fi

