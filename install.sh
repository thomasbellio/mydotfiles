#/bin/bash
echo "backing up zshrc file" &&
cp ~/.zshrc ~/.zshrc.copy &&
echo "removing zshrc file" &&
rm  -r ~/.zshrc &&
echo "installing powerline fonts"
./fonts/install.sh &&
echo "installing new zhrc" &&
ln -s  $(pwd)/zsh/zshconfig ~/.zshrc
source ~/.zshrc