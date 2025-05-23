export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if [ ! -f ~/.ssh/config ] || ! grep -q 'AddKeysToAgent' ~/.ssh/config; then
    echo 'AddKeysToAgent  yes' >> ~/.ssh/config
fi
