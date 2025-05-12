## Git Config
git config --global core.editor nvim
git config --global user.email "thomas@thomasbell.io"
git config --global user.name "Thomas Bell"
git config --global init.defaultBranch master
if [[ -d "$HOME/.git-templates" ]]; then
  git config --global init.templatedir "$HOME/.git-templates"
fi

