# git/completions.zsh
# Git completion setup

# Load git completion if available
zstyle ':completion:*:*:git:*' script ${DOTFILES_DIR}/git/git-completion.zsh
fpath=(${DOTFILES_DIR}/git $fpath)
