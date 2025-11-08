if [[ ! " ${fpath[@]} " =~ " $HOME/.zsh " ]]; then
    fpath=($HOME/.zsh $fpath)
fi
