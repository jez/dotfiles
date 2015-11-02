#
# misc.zsh - Miscellaneous zsh-specific configuration
#
# Sets up oh-my-zsh, some completions, fixes ^H and backspace, and more.
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file.
#
# Notes
#   I copied most of this from the zshrc of Tom Shen <tom@shen.io>. I
#   understand very little of it, but I understand enough to know what I
#   changed, which is generally speaking the commented stuff.
#
# TODOs
#   - This could be more modular.

# Load oh-my-zsh
DISABLE_AUTO_UPDATE="true"
export CASE_SENSITIVE="true"
export ZSH="$HOME/.oh-my-zsh/"
plugins=(brew brew-cask)
source $ZSH/oh-my-zsh.sh

# General zshzle options
setopt autocd                # cd by just typing in a directory name
setopt completealiases
#setopt extendedglob         # use #, ^, and ~ as glob characters
setopt interactive_comments   # type comments at the command line
setopt nomatch
setopt no_case_glob

# Turn on vi keybindings <3 <3 <3 :D and other things
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^U" backward-kill-line

# Make ^H and backspace behave correctly
bindkey "^H" backward-delete-char

# history search backwords with j/k in normal mode
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# Tab complete options like Vim rather than sh
setopt -Y
export MENU_COMPLETE=1

# Initialize zsh history files
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# zsh completion (zsh installed through Homebrew)
if [ -e $(which brew &> /dev/null && brew --prefix)/etc/zsh_completion ]; then
  source $(brew --prefix)/etc/zsh_completion
fi

zstyle :compinstall filename $HOME/.zshrc

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*:*:*:*:*' menu ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={a-zA-Z}' #'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# The following line was moved to ~/.util/after.sh to resolve circular dependencies
#zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' verbose false

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit

# Fix ESC + /

vi-search-fix() {
  zle vi-cmd-mode
  zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# Plugin for syntax highlighting the command line
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets)
source $HOME/.zfunctions/syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[comment]='fg=green,bold'

unalias run-help 2> /dev/null
autoload run-help
HELPDIR=/usr/local/share/zsh/help
alias help="run-help"
