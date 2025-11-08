[ ! -d "$HOME/.zsh/git" ] && mkdir -p "$HOME/.zsh/git"
[ ! -f "$HOME/.zsh/git/git-completion.bash" ] && curl -o "$HOME/.zsh/git/git-completion.bash" https://raw.githubusercontent.com/$DOTFILES_GIT_DEFAULT_USER/git/master/contrib/completion/git-completion.bash
[ ! -f "$HOME/.zsh/git/_git" ] && curl -o "$HOME/.zsh/git/_git" https://raw.githubusercontent.com/$DOTFILES_GIT_DEFAULT_USER/git/master/contrib/completion/git-completion.zsh
zstyle ':completion:*:*:git:*' script $HOME/.zsh/git/git-completion.bash

if [[ ! " ${fpath[@]} " =~ " $HOME/.zsh/git " ]]; then
    fpath=($HOME/.zsh/git $fpath)
fi
