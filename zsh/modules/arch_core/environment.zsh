# makes man pages not suck
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

alias colorlog="awk 'BEGIN { RED=\"\033[0;31m\"; BLACK=\"\033[39m\"; YELLOW=\"\033[33m\"; LIGHT_GREEN=\"\033[1;32m\"; GREEN=\"\033[0;32m\"; reset=\"$(tput sgr0)\" }

  /INFO/ {print GREEN \$0 reset; next}
  /ERROR/ {p=1} p && /INFO|WARN|DEBUG/ {p=0};p {print RED \$0 reset; next}
  /WARN/ {p=1} p && /INFO|ERROR|DEBUG/ {p=0};p {print YELLOW \$0 reset; next}
  // {print; next}'
"

export PATH="/usr/local/opt/openjdk/bin:/opt:$HOME/.local/bin:$PATH"

export PAGER="less"
if [[ -f $HOME/.cargo/env ]]; then
    source $HOME/.cargo/env
fi

if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# configruation for grim -- https://gitlab.freedesktop.org/emersion/grim a screenshot utility
export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots"
mkdir -p $GRIM_DEFAULT_DIR

