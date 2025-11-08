# About

Herein lies all the configuration and setup for a zsh shell. 

This setup requires a modern version of zsh as of this writing it was developed against version zsh version `5.9`, though I have no reason to believe it shouldn't work for any modern zsh version.


## Definitions

**Module:** modules are logical groupings of configuration for a particular context. 

**Profiles:** [profiles](./profiles/README.md) are logical groupings of [modules](./modules/README.md) that should be configured in the shell.


##  Organization

This shell configuration is oriented around the idea of [profiles](./profiles/README.md) which load [modules](./modules/README.md). 

For instance you might have a dev profile that includes the [git module](./modules/git/README.md) and the [php module](./modules/php/README.md)

Details about the configuration and creationg of profiles and modules can be found [here](./profiles/README.md) and [here](./modules/README.md) 

## Installation and Setup

### Pre-requisites

You will, of course, need a  modern version of [zsh](zsh.org) installed and you will need to be in a zsh shell to install and use this setup. 

The [default profile](./profiles/default.zsh) also loads the configuration for [neovim](https://neovim.io) and [starship](https://starship.rs), so those tools should be installed if you intend to use the `default` profile.  

### Environment Config

For this shell configuration to work properly you will need to set some environment variables in your `~/.zprofile` file or any place that will be sourced before `~/.zshrc`.

Each [module](./modules/README.md)  can define or require its own environment config in addition to the default config needed to bootstrap this system. Environment config on a per module basis can be found in the respective modules readme. 

The following are the minimum necessary environment variables required to load this configuration: 

```zsh
# This will be dependent on where you cloned this repository
export DOTFILES_DIR="$HOME/code/thomasbellio/mydotfiles"

# This parameter is optional and defaults to 0
# When set to 1 you will see a detailed ouptut from the sourcing step to show what modules are loaded and when
# The debug output is quite verbose, so this should only be set when something isn't working or when developing new modules
export DOTFILES_ZSH_MODULE_DEBUG=1
```

In addition to these environment variables you can also configure profiles including customizing the location from where profiles are sourced.

For more details on profiles you can see the documentation [here](./profiles/README.md) 

Once you have specified the `DOTFILES_DIR` and optionally the `DOTFILES_ZSH_MODULE_DEBUG` switch then you will need to add the [dotfile-zshrc](./zshrc/dot-zshrc) file to your home directory at `~/.zshrc`. You can do this either by copying the file, symlinking the file directly, or installing the file using a tool like [stow](https://www.gnu.org/software/stow/).

Assuming you are in the same directory as this README, you can run one of the following commands to install the `.zshrc` file.

**NOTE: Before running any of these commands if you already have an existing ~/.zshrc make backup of the file then remove it from your home directory.**

**With Stow (Recommended)**

```zsh
stow --target="$HOME" --dotfiles zshrc
```

**With ln Symlink**

```zsh
ln -s  $(pwd)/zshrc/dot-zshrc ~/.zshrc
```

**With cp Hard Copy**

```zsh
cp $(pwd)/zshrc/dot-zshrc ~/.zshrc

```

Now you can either open a new shell or source the `~/.zprofile` and the `~/.zshrc` file in that order. Assuming you have loaded a profile that includes the [core](./modules/core) and everything went well you should now have an alias called `zource` available, that will source both the `~/.zprofile` and the `~/.zshrc` file in the correct order. More details on the core module can be found in that [modules readme](./modules/core/README.md).  




