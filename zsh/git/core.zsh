# git/core.zsh
# Core configuration for Git

# Git configuration
git config --global core.editor nvim 2>/dev/null || true

# Add git template directory if available
if [[ -d "$HOME/.git-templates" ]]; then
  git config --global init.templatedir "$HOME/.git-templates"
fi
