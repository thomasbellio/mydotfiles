[ ! -d "$HOME/.zsh/completions/" ] && mkdir -p "$HOME/.zsh/completions/"
[ ! -f "$HOME/.zsh/completions/_git" ] && curl -o "$HOME/.zsh/completions/_git" https://raw.githubusercontent.com/$DOTFILES_GIT_DEFAULT_USER/git/master/contrib/completion/git-completion.zsh

