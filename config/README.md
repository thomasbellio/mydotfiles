# About

This contains all the configuration and dotfiles that is managed by [stow](https://gnu.org/software/stow). 


## Installing

To install the dotfiles in this directory make sure this is your current working directory and then run: 

```sh 
stow --target="$HOME" --dotfiles */
```

**Note:** The command above will stow all files in the stow directory. If you don't want or need all the directories, you can specify them individually. For instance if you just want to stow `tmux` then you would run the following from within the stow directory:

```sh
stow --target="$HOME" --dotfiles tmux
```


