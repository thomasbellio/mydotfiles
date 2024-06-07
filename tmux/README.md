# About

This folder contains things related to my tmux configuration. Tmux is a tool known as a terminal multiplexer. This enables an assortment of capabilities including creating sessions that can be attached to and detached from, without losing the processes running in those sessions.

Tmux also enables multiple terminal panes within a single session. There are also many other convenient features of tmux.

## Dependencies

* [tmux plugin manager (tpm)](https://github.com/tmux-plugins/tpm)
* [tmux theme pack](https://github.com/jimeh/tmux-themepack)

## Setup

### Tmux Plugin Manager

```sh
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```


This will get sourced at the bottom of the .tmux.conf

### Tmux theme pack

I use this just to add some of the sizzle to my terminal experience.

To install tmux plugin manager you can just clone it using the following command documented on the [tmux-thempack documentationo](https://github.com/jimeh/tmux-themepack)


```sh
$ git clone https://github.com/jimeh/tmux-themepack.git ${HOME}/.tmux/plugins/tmux-themepack/

```

The themepack is sourced in the .tmux.conf file that is included in this repository.
