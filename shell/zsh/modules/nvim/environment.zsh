export PATH="/usr/local/opt/openjdk/bin:/opt:$HOME/.local/bin:$PATH"

export PATH="$PATH:$DOTFILES_NVIM_INSTALL_PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export EDITOR="NVIM_APPNAME=${NVIM_APPNAME:-nvim} nvim"

