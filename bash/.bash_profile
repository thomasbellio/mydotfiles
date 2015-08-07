[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export GOPATH=$HOME/go
