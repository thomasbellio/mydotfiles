# About

This zsh dot file contains various useful plugins and color themes

## Dependencies

The zsh config has several tools that it loads below is a list of tools that you can install, if you want. You will need to follow separate install instrauctions for relevant dependencies.

If you don't want those components you can just comment out the relevant components in the [zshconfig](./zshconfig)

- [oh-my-zsh](https://ohmyz.sh/#install)
- [krew](https://github.com/kubernetes-sigs/krew)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Setup

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
