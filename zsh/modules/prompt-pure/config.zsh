cloneRepo "$DOTFILES_GIT_DEFAULT_URL/$ZSH_DEFAULT_GIT_USER/pure.git" "${HOME}/.zsh" "/pure/"

if [[ ! -d "${HOME}/.zsh/pure" ]]; then
    mkdir -p "${HOME}/.zsh/pure"
fi

cloneRepo "$DOTFILES_GIT_DEFAULT_URL/$ZSH_DEFAULT_GIT_USER/pure.git" "${HOME}/.zsh" "/pure/"
if [[ ! " ${fpath[@]} " =~ " ${HOME}/.zsh/pure " ]]; then
    fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
# Conditionally set user color based on whether user is root
if [[ -z $USER ]]; then
    USER=$(whoami)
fi

if [[ $USER == "root" ]]; then
    # Set root user to red
    zstyle :prompt:pure:user color '#ff00af'
    zstyle :prompt:pure:host color '#ff00af'
    zstyle ':prompt:pure:prompt:*' color '#ff00af'

else
    # Set regular user to yellow
    zstyle :prompt:pure:user color yellow
    zstyle :prompt:pure:host color blue
    zstyle ':prompt:pure:prompt:*' color yellow
fi
# turn on git stash status
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:branch color magenta
zstyle :prompt:pure:git:dirty color red
#
RPROMPT='%F{blue}%*%f'
prompt pure
# Force username and hostname to always show up with appropriate colors
prompt_pure_state[username]='%F{$prompt_pure_colors[user]}%n%f %F{$prompt_pure_colors[host]}@%m%f'
# Then force the username to always show up
PURE_PROMPT_SYMBOL='$'
