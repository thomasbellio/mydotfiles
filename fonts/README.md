# About 

Contains fonts for my operating system. 


## Installation

Ensure that there is a folder located at `/usr/local/share/fonts/`:

```sh 
mkdir /usr/local/share/fonts/
```

These fonts can be installed using `stow`. 

```sh 
stow --target="/usr/local/share/fonts/" . 
fc-cache
```
Then confirm the fonts are installed by running: 

```sh  
fc-list | grep nerd-fonts

```

If you are using `ghostty` you can confirm  that the fonts are enabled by running: 


```sh  
ghostty +list-fonts | grep Caskaydia
```
