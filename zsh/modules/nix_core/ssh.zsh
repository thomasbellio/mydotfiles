# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# if [ ! -f ~/.ssh/config ] || ! grep -q 'AddKeysToAgent' ~/.ssh/config; then
#     # This will ensure identities are added automatically for new sesssions
#     # https://man.openbsd.org/ssh_config#AddKeysToAgent
#     echo 'AddKeysToAgent  yes' >> ~/.ssh/config
# fi
