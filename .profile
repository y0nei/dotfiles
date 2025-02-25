#!/bin/sh

# ! This file is only sourced when bash is started in login mode.
# Why the exports here?
# * I'm quirky and i just use Bash as my login shell. Zsh is used as an
#   interactive shell. Aliases and PS1 are also set here, but just for
#   convenience if i will ever need to use Bash in TTY

# Default PS1 for tty, example: "username@hostname ~/ $"
PS1="\[\e[93;1m\]\u\[\e[91m\]@\[\e[96m\]\h \[\e[0;2;3m\]\w \[\e[0m\]\$ "

# XDG exports
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

# ~/ cleanup
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export HISTFILE="$XDG_DATA_HOME/bash-history"
export LESSHISTFILE=-
# misc
export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export BUN_INSTALL="$HOME/.bun"

# Default apps
export TERMINAL="alacritty"
export BROWSER="librewolf"
export EDITOR="nvim"

# Settings for bemenu
export BEMENU_OPTS="-H 20 -c -l 10 -W 0.33 -B 2"
BEMENU_OPTS+=' --bdr "#A7C080" --tf "#A7C080" --hb "#A7C080" --hf "#000000"'

# Preferred dir for scripts and stuff
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Golang
if [ -d "$GOPATH/bin" ]; then
    PATH="$GOPATH/bin:$PATH"
fi

# Bun (thank you for not following the XDG spec..)
if [ -d "$BUN_INSTALL/bin" ]; then
    PATH="$BUN_INSTALL/bin":$PATH
fi

# Needed for global installations
if [ -d "$PNPM_HOME" ]; then
    PATH="$PNPM_HOME":$PATH
fi

# Load aliases (if found)
[ -f "$HOME/.config/.aliases" ] && source "$HOME/.config/.aliases"

# Autostart WM upon tty login
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep sway || dbus-run-session sway
fi
