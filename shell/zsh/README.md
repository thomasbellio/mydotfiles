# About

Herein lies all the configuration and setup for a zsh shell. 

This setup requires a modern version of zsh as of this writing it was developed against version zsh version `5.9`, though I have no reason to believe it shouldn't work for any modern zsh version.


##  Organization

This shell configuration is oriented around the idea of [profiles](./profiles/README.md)



This section contains the configuration for how I currently have my zsh terminal configured for my personal workstation.

This is always a work in process and will evolve overtime. Currently I don't have a lot of automation for installation of various components but I will opportunistically add that capability as I have time.

## Dependencies

The zsh config has several tools that it loads below is a list of tools that you can install, if you want. You will need to follow separate install instrauctions for relevant dependencies.

If you don't want those components you can just comment out the relevant components in the [zshconfig](./zshconfig)

Required:

- [zsh](https://zsh.org)
- [pure](https://github.com/sindresorhus/pure)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/tree/master)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

Optional:

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [krew](https://github.com/kubernetes-sigs/krew)

## Setup

This setup requires that you have zsh installed and it is set as your default shell. To install on ubuntu simply run:

```sh
sudo apt update -y &&
sudo apt install -y zsh
```

To set it as the default shell run:

```sh
chsh -s $(which zsh)

```
You will need to reboot after you change the shell.

You have a couple of options for setting up locally. The simplest option is to copy the contents of [zshconfig](./zshconfig) to your `~/.zshrc` file.

The second option is to create a symbolic link to the [zshconfig](./zshconfig)

```sh
ln -s /path/to/zshconfig $HOME/.zshrc
```

This will ensure that if you pull the latest files you will have what you need.

Once you have added contents to the .zshrc file you will need to source the file

```sh
source $HOME/.zshrc
```
