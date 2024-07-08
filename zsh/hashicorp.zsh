# Contains configuration like autocomplete for Hashicorp products like Packer Terraform etc
# autoload -U +X bashcompinit && bashcompinit
# Check if packer is installed
if command -v packer >/dev/null 2>&1; then
  complete -o nospace -C /usr/bin/packer packer
fi
