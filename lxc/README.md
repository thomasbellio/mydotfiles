# About 

Here in lies the configuration for my linux containers.

## Dependencies

* [stow](https://www.gnu.org/software/stow/)
* [lxc](https://linuxcontainers.org/lxc/getting-started/)

## Installation

If you want to ensure you have proper zsh environment setup create a `.zprofile` file using the example like this: 

```sh
cp nix-config/example.zprofile nix-config/.zprofile
```

Make sure you update the `.zprofile` with any specific configuration items for your environment. 

To install this configuration run the following commands from inside this directory: 


```sh
sudo stow --target="/usr/share/lxc/" .
```


## NixOS 

Once you have stowed the configuration you can create the nixos container like this:

```sh
sudo lxc-create --name nix-developer --template download -- --dist nixos --release 24.11 --arch amd64
```

Then symlink the configuration file to the container path like this: 

```sh 
sudo rm /var/lib/lxc/nix-developer/config &&

sudo ln -s /usr/share/lxc/nix-config/config /var/lib/lxc/nix-developer/config
```

```sh 
sudo lxc-start -n nix-developer --foreground
```


Then as the root user from inside the container run the following commands:

```sh 
NIX_CONFIG="sandbox = false" nix-channel --update
NIX_CONFIG="sandbox = false" nixos-rebuild switch
```

If everything worked correctly you should now have a user at `/home/thomas-devel`



