# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000
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

eval "$(direnv hook zsh)"
# TODO: I don't fully understand how the lifecycle of the hook below works
# there is a bug where the name ofthe nix shell does not show up in the terminal on initial load
# or when you change directories only after a command like ls is ran.
function update_nix_shell_info() {
  if [[ -n "$IN_NIX_SHELL" ]]; then
    PS1="%F{yellow}[$IN_NIX_SHELL]%f $PS1"
  else
    PS1=$PS1
  fi
}

add-zsh-hook precmd update_nix_shell_info

PURE_PROMPT_SYMBOL=$

