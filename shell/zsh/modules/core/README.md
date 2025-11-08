# Core Module

The core module includes setups for an assortment of common functionality, bindings, aliases etc.

## Limitations

Currently all git clones are done using the `DOTFILES_GIT_DEFAULT_URL` and `DOTFILES_GIT_DEFAULT_USER`, which default to `https://github.com` and `thomasbellio` respectively.

You can override these values in your `~/.zprofile` and ensure that you have forked the [ZSH Auto Suggestions Repository](https://github.com/thomasbellio/zsh-autosuggestions), [ZSH Syntax Highlighting Repository](https://github.com/thomasbellio/zsh-syntax-highlighting), [ZSH Syntax Highlighting Catppuccin Theme Repository](https://github.com/thomasbellio/zsh-syntax-highlighting-catpuccin).

## Dependencies

* [neovim](https://neovim.io): this will configure some aliases that depend on neovim
* [git](https://git-scm.com/): git will be used to clone repos for some tool sets
* [dig](https://en.wikipedia.org/wiki/Dig_(command)): used for one of the defined utility functions

## Environment

This module will update the PATH environment varialbe to include your `~/.local/bin` directory. 

Sets the default pager to `less`

Enables `direnv` for zsh.

This module will also set the path to the history file and limits on history retention.

Finally it will add `$HOME/.zsh` to the fpath to support things like completions. 


## Aliases

The core module will create the following aliases:

* **zource:** this will source your `~/.zprofile` and `~/.zshrc` files in the correct order
* **zv:** shortcut to open your `~/.zshrc` file using nvim 
* **ls:** overrides the default ls command to include color output and other sane default options `ls -alhG --color=auto`

## Functions

In addition to the aliases defined above, this module includes some utility functions.

* **jwt_decode:** takes a jwt token and will base64 decode the payload and headers for inspection.
* **my_ip:** will use `dig` to determine your current public ip address from the internet


## Installations

This module will ensure that the `SHELL_PLUGINS_DIR` exists and will create it if it doesn't exist. The default `SHELL_PLUGINS_DIR` is `~/shell-plugins/`, this can be overridden by the `DOTFILES_SHELL_PLUGINS_DIR` environment variable. 

This module will also clone [ZSH Auto Suggestions Repository](https://github.com/thomasbellio/zsh-autosuggestions) and the [ZSH Syntax Highlighting Repository](https://github.com/thomasbellio/zsh-syntax-highlighting)
Additionally it will setup the theme for Syntax highlighting using the [ZSH Syntax Highlighting Catppuccin Theme Repository](https://github.com/thomasbellio/zsh-syntax-highlighting-catpuccin). 

## Bindings

Includes standard emac keybindings for the terminal. [bindings](./bindings.zsh).


