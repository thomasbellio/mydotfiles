#/bin/bash
mkdir -p $HOME/.git-templates/hooks/ &&
ln  $(pwd)/git/templates/hooks/prepare-commit-msg $HOME/.git-templates/hooks/prepare-commit-msg &&
git config --global init.templatedir $HOME/.git-templates 
