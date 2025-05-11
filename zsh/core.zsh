# Lines configured by zsh-newuser-install
_feature_debug "Sourcing zsh/core.zsh"

export HISTFILE=~/history/histfile

# Check if the directory for HISTFILE exists, if not, create it
if [ ! -d "$(dirname "$HISTFILE")" ]; then
    mkdir -p "$(dirname "$HISTFILE")"
    chmod 700 "$(dirname "$HISTFILE")"
fi
export HISTSIZE=10000
export SAVEHIST=10000
unsetopt beep
# the +X enables tracing for debugging autoload -U +X bashcompinit && bashcompinit
autoload -U  bashcompinit && bashcompinit
_feature_debug "Sourced zsh/core.zsh"
