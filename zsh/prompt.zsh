fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
# change the path color
zstyle :prompt:pure:path color green
zstyle ':prompt:pure:prompt:*' color yellow
# turn on git stash status
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:branch color magenta
zstyle :prompt:pure:git:dirty color red

RPROMPT='%F{blue}%*%f'
prompt pure
# this is needed to enable direnv in zsh. Its possible it is causing slow down
eval "$(direnv hook zsh)"

PURE_PROMPT_SYMBOL=$

