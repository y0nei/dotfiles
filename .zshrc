# === General =================================================================

# Create history directory if not present
[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ] || mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# Separate history in cache directory
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Vi mode & faster mode switching
bindkey -v
export KEYTIMEOUT=1

# Backup PS1 whenever starship is not avaliable
PS1="%B%F{yellow}%n%f%F{red}@%f%F{blue}%m%b%f %F{#888}%~%f $ "

# Load the completion system and change zcompdump file location
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Better tab completion
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"  # case insensitive
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"  # colored output
_comp_options+=(globdots)  # Include dotfiles
bindkey "^[[Z" reverse-menu-complete # Navigate backwards with Shift+TAB

# Load aliases
source $HOME/.config/.aliases

# === Plugins (with bootstrap script) ==========================================

ZSH_SYNTAX_HL_PATH=$(whereis zsh-syntax-highlighting | awk '{print $2}')
ZSH_AUTOSUGGEST_PATH=$(whereis zsh-autosuggestions | awk '{print $2}')

if [ -z "$ZSH_SYNTAX_HL_PATH" ] || [ -z "$ZSH_AUTOSUGGEST_PATH" ]; then
    # Check for Arch Linux if locating install path with whereis fails
    if [ -f "/etc/arch-release" ]; then
        ZSH_PLUGINS_DIR="/usr/share/zsh/plugins"
    else
        ZSH_PLUGINS_DIR="${XDG_DATA_HOME:=$HOME/.local/share}/zsh-plugins"
    fi

    # Set fallback directory for storing Zsh plugins if not found on system.
    ZSH_SYNTAX_HL_PATH="${ZSH_SYNTAX_HL_PATH:-$ZSH_PLUGINS_DIR/zsh-syntax-highlighting}"
    ZSH_AUTOSUGGEST_PATH="${ZSH_AUTOSUGGEST_PATH:-$ZSH_PLUGINS_DIR/zsh-autosuggestions}"

    # Start installation process if the directories above are not present.
    if [ ! -d "$ZSH_SYNTAX_HL_PATH" ] || [ ! -d "$ZSH_AUTOSUGGEST_PATH" ]; then
        echo "* Zsh autosuggestions and syntax highlighting not found on system," \
             "please install them with your preferred package manager."
        if read -q choice\?"Do you want to clone Zsh plugins manually via Git? (N/y): "; then
            echo "\n* Creating plugin directory..."
            mkdir -pv $ZSH_PLUGINS_DIR
            echo "* Installing Zsh plugins manually..."
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HL_PATH
            git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_AUTOSUGGEST_PATH
            echo "* Finished installing Zsh plugins."
        elif [ $? -eq 1 ]; then
            echo "\n* Skipping manual Zsh plugin installation."
        fi
    fi
fi

source $ZSH_SYNTAX_HL_PATH/zsh-syntax-highlighting.zsh
source $ZSH_AUTOSUGGEST_PATH/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

## Starship
eval "$(starship init zsh)"
