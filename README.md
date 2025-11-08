# About

This is my dotfiles repository, there are many like it but this one is mine.

Herein contains most of the configuration for my [shell environment](./shell/zsh/README.md), [application configuration](./config/README.md), [systemd services](./systemd/README.md), [etc configuration](./etc/README.md), and various other services.

This repository is all about configuring tools and system level applications like systemd, it is not intended for the purposes of installing those tools and applications.

For the purpose of installing tools and system applications my [ansible-orchestration](https://github.com/thomasbellio/ansible-orchestration) is used for that purpose. 

## Design Goals

As with most of my automated tooling, the core design principle is rapid context switching. 

As an engineer it is very common for me to have to switch rapidly between different problem domains, technical contexts, and even different machines. In one moment I may be heads down coding a solution for a frontend application, then need to switch to configuring and deploying code, administering a server, or reading documentation.

Reducing the cognitive load and the time that it takes to switch between various contexts can dramatically improve overall productivity.

Accordingly all that is contained in this repository is about rapidly getting a a consistent and familiar environment setup, without unnecssary bloat, meaning I only install and configure what is needed for a particular context.

Aside from improving overall productivity setting up an automated configuration system like what I have developed here, serves as a sort of self documentation, so that when I come back to this repository I will be able to more quickly remember how a particular task or configuration setup is achieved. 


## Organization

This dotfiles repository is organized based on the logical systems and operating system configuration that is being deployed. The logical boundaries are generally organized by directories in the root of this repository. Generally each logical system can be configured from this repository on most unix based systems. In anything that is particular for a particular operating system like macos can be found in the `operating-systems` folder.

The logical systems include:

* [etc](./etc/)
* [fonts](./fonts/)
* [operating-systems](./operating-systems/macos/)
* [config](./config)
* [systemd](./systemd/)
* [shell](./shell/)

Documentation for setup and usage for each of the logical systems can be found in the `README` for the respective system.

