# Modules 



## Helper Functions

The [module-manager](../module-manager.zsh) defines several helper functions that can be used when adding new modules. 


* **source_module:** on a per module basis this function should only be called once and should live in the modules `init.zsh`. This function will source all `.zsh` files located inside the module directory. It takes no parameters. 
* **register_module:** this function is intended to be called inside a profile file. Its job is to record which modules will be sourced, this does not actually source the module, it just ensures it is recorded. This method can be called multiple time, each module registered will only be registered one time even with multiple calls with the same parameters. This function takes one parameter: "{module-name}".
* **module_debug:** this function is for logging messages during the overall system lifecycle and it may be called at anytime in a module, a profile, or any other spot within the sourcing process. Output will only be shown if the environment variable: `DOTFILES_ZSH_MODULE_DEBUG` is set and has a value of 1. Output will be in the form of "[DEBUG] {message}".  This function takes one parameter: "{message}" 
