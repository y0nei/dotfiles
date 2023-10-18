# === General =================================================================

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

# === Utils ===================================================================

# Epic fzf history on Ctrl+r
fzf-history() {
    $(fzf --height=20% --prompt="> " --pointer=">" --preview="echo {}" \
        --color=fg:4,bg:-1,bg+:-1,info:7,prompt:10,pointer:10 < "$HISTFILE")
}
zle -N fzf-history
bindkey "^R" fzf-history

# === Plugins =================================================================

# Load plugins and supress error output
source $XDG_DATA_HOME/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $XDG_DATA_HOME/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

## Starship
eval "$(starship init zsh)"
