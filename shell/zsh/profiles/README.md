# Profiles

Profiles are the core component of this zsh configuration. A profile consists of several modules that may be sourced in a given context.


Profiles are simple zsh files that calle the 'register_module' function defined in the [module-manager](../module-manager.zsh).

An example can be found in the [default profile](./default.zsh), which looks something like this:

```zsh
register_module "core"
register_module "git"
register_module "prompt-starship"
register_module "nvim"
```

Profiles can be stacked, so you might include the [default](./default.zsh) profile along with the [android](./android.zsh). Profiles are loaded in an idempotent manner, so each profile may define the same modules, but they will only each be registered and sourced once.  

The primary way to configure a module is to use the `DOTFILES_ZSH_MODULE_PROFILES` environment variable. Which can be loaded in your `.zprofile` or anyother place that will be sourced before the `.zshrc` file. 

The `DOTFILES_ZSH_MODULE_PROFILES` environment variable should be a semicolon delimited list of profiles to load. So for example if we wanted to load the default profile and the android profile the environment variable would be set like this: 


```zsh
export DOTFILES_ZSH_MODULE_PROFILES="default;android"
```

If this variable is not set the [default profile](./default.zsh) will always be loaded.
