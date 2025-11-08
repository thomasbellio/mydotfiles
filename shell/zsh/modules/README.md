# Modules 

A module is a self contained set of environment setup, aliases, completions, and anything else that a particular grouping of applications or tools may need in the shell environment. 

A module in the context of this configuration system is simply a directory in the `shell/zsh/modules` folder of this repository. All that is needed for a valid module is a single 'init.zsh' file that calls the `source_module` function. 

```zsh
# init.zsh
source_module
```

Technically you could include any valid zsh command in the `init.zsh` file, but logic should be kept to a minimum in this file. The `source_module` function will source all `.zsh` files in the module directory, except the `init.zsh` file. `source_module` should only be called once per module specification. 

## Module Development

Technically a module can include anything that would be a valid zsh command, but in general comprehensive system logic should be kept to a minimum. Also modules should not be responsible for installing dependencies, but only for configuration of the shell environment for a particular tool.  

**Best Practices**


* Do not install system tools in modules. Modules should be designed to configur existing system tools installing tools should be out of scope for zsh modules
* Keep the module files simple, with minimal logic and external dependencies
* Break out configuration into logical files, keep all aliases in `aliases.zsh` all environment config in `environment.zsh` etc.
* Be defensive, check if the required tool is actually installed, if not the module can just skip steps or exit code 1 which would completely kill the sourcing process.
* When doing things like backing up existing files or creating directories leverage the `module_debug` helper function to give clear indications of what is happening when `DOTFILES_ZSH_MODULE_DEBUG` is enabled
* Leverage the helper functions documented below as much as you can to maintain consistent logging and logical coherency
* Include a `README.md`in your module that clearly explains what aliases are created, what environment variables are set, what dependencies are required, etc.

This repository is still in active development, so I haven't always followed my own advice for best practices. I have attempted to include a good README for the [core module](./core/) that shows how I envision documenting modules more completely in the future.  


## Helper Functions

There are several [helper functions](../helper-functions.zsh) defined that can be used at various phases of the module/profile lifecycle. 

| Name | Parameters | Description |
|------|------------|-------------|
| **source_module** | 0 parameters | On a per module basis this function should only be called once and should live in the modules `init.zsh`. This function will source all `.zsh` files located inside the module directory. |
| **register_module** | 1 parameter: `{module-name}` | This function is intended to be called inside a profile file. Its job is to record which modules will be sourced, this does not actually source the module, it just ensures it is recorded. This method can be called multiple time, each module registered will only be registered one time even with multiple calls with the same parameters. |
| **module_debug** | 1 parameter: `{message}` | This function is for logging messages during the overall system lifecycle and it may be called at anytime in a module, a profile, or any other spot within the sourcing process. Output will only be shown if the environment variable: `DOTFILES_ZSH_MODULE_DEBUG` is set and has a value of 1. Output will be in the form of "[DEBUG] {message}". |
| **clone_repo** | Not specified | This function will clone a repository, if the target directory doesn't already exist. If the target directory already exists then it will do nothing. When `DOTFILES_ZSH_MODULE_DEBUG` is true, then it will give detailed output about what repository is being cloned and to what directory. |


## TODO

* In the future I want to explore having module dependencies that may include the ability to express dependencies between modules
* Add the ability to configure behavior when dependent tools are not installed like 'die', 'skip', 'install'
* currently if I have a module that works in arch linux, for example, but has a dependency that wouldn't work on macos, I would need to either handle that logic in my zsh file or create a separate module as I have done in [arch-core](./arch_core/), instead it would be nice to have a single `core` module and have an intelligent way for it to adapt to a particular operating system with minimal code duplication 
* The `clone_repo` helper function currently requires an explicit parameter for the git repository. I would like to explore configuring a global default for the git repository so that modules can just call `clone_repo` with the repo name instead of the fully qualified url. 
