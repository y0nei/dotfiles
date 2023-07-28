#!/bin/sh

# ! This file is only sourced when bash is started in login mode.
# Why the exports here?
# * I'm quirky and i keep Bash as my default shell, but use Zsh when inside
#   a desktop environment for terminal emulators, so no .bashrc needed :3c

# Default PS1, example: "username@hostname ~/ $"
export PS1="\[\e[93;1m\]\u\[\e[91m\]@\[\e[96m\]\h \[\e[0;2;3m\]\w \[\e[0m\]\$ "

# XDG exports
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

# ~/ cleanup
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export HISTFILE="$XDG_DATA_HOME/bash-history"
export LESSHISTFILE=-

# Default apps
export TERMINAL="alacritty"
export BROWSER="librewolf"
export EDITOR="nvim"

# Autostart WM upon tty login
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep Hyprland || Hyprland
fi
