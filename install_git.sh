#/bin/bash
echo "initializing git templates directory..." &&
mkdir -p $HOME/.git-templates/hooks/ &&
echo "creating symlink to templates directory..." &&
ln  $(pwd)/git/templates/hooks/prepare-commit-msg $HOME/.git-templates/hooks/prepare-commit-msg &&
git config --global init.templatedir $HOME/.git-templates 
