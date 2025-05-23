#!/usr/bin/zsh
mkdir -p "$XDG_CONFIG_HOME/systemd/user"
if [ -e "$XDG_CONFIG_HOME/systemd/user/ssh-agent.service" ]; then
    echo "File exists at $XDG_CONFIG_HOME/systemd/user/ssh-agent.service. Creating backup."
    mv "$XDG_CONFIG_HOME/systemd/user/ssh-agent.service" "$XDG_CONFIG_HOME/systemd/user/ssh-agent.service.bak"
fi

echo "Creating symlink for ssh-agent.service."
ln -s $(pwd)/systemd/user/ssh-agent.service "$XDG_CONFIG_HOME/systemd/user/ssh-agent.service"

if ! systemctl --user is-enabled --quiet ssh-agent.service; then
    systemctl --user enable --now ssh-agent.service
else
    systemctl --user daemon-reload
fi
