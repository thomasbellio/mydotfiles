# Add Cargo bin directory to PATH if it exists and isn't already in PATH
if [[ -f $HOME/.cargo/env ]]; then
    source $HOME/.cargo/env
fi
if [[ -d "$HOME/.cargo/bin" ]] && [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
