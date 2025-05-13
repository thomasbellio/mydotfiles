#/bin/bash
if [ -f ~/.zshrc ]; then
    echo "backing up zshrc file" &&
    cp ~/.zshrc ~/.zshrc.copy &&
    echo "removing zshrc file" &&
    rm -r ~/.zshrc
fi
echo "installing new zshrc" &&
ln -s  $(pwd)/zsh/zshrc ~/.zshrc
