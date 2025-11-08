# Contains configuration like autocomplete for Hashicorp products like Packer Terraform etc
if command -v packer >/dev/null 2>&1; then
  complete -o nospace -C /usr/bin/packer packer
fi
