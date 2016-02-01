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
#   This file started out being mostly snippets from the zshrc of Tom Shen
#   <tom@shen.io>. It's diverged considerably since then, but there are still a
#   few parts that exist unchanged. I understand the parts of it that I've
#   commented, although there are still some pieces I copied over that Just
#   Work™.
#
#   I use the zsh-syntax-highlighting[1] plugin for coloring the syntax of my
#   zsh commands as I type them. It catches tons of typos and is super useful
#   in general. To install it, you'll need to have the repo cloned and on your
#   fpath somewhere. I set my fpath in my ~/.zshenv file, so you might want to
#   check it out.
#
#   I also use Oh My Zsh[2] for some completion plugins. This needs to be cloned
#   to something like ~/.oh-my-zsh.
#
#   [1]: https://github.com/zsh-users/zsh-syntax-highlighting
#   [2]: https://github.com/robbyrussell/oh-my-zsh
#
# TODOs
#   - This could be more modular.


# Load oh-my-zsh. I'm not using this for too much. Mostly, it makes adding
# completion plugins easier, but it could be removed if you don't want that
# many completion plugins.
DISABLE_AUTO_UPDATE="true"
export CASE_SENSITIVE="true"
export ZSH="$HOME/.oh-my-zsh/"
plugins=(brew brew-cask)
source $ZSH/oh-my-zsh.sh


# General zshzle options
setopt autocd                     # cd by just typing in a directory name
setopt completealiases            # tab completion includes aliases
setopt nomatch                    # warn me if a glob doesn't match anything
setopt no_case_glob               # globbing is case insensitive
setopt interactive_comments       # commands preceded with '#' aren't run
setopt menu_complete              # Show completions like Vim (cycle through)
export MENU_COMPLETE=1
#setopt extendedglob              # use #, ^, and ~ as glob characters
                                  # I've disabled this because it makes zsh
                                  # behave more like bash, at the price of
                                  # giving up features I didn't really use.

# Don't try to strip the space between the end of a line and a | character
# (See http://superuser.com/questions/613685/)
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'


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

# Use zsh's awesome pattern move
autoload -Uz zmv


# Sometimes pressing ESC + / quickly (i.e., to do a reverse-i-search with
# bindkey -v turned on) would not work properly. This fixes it.
vi-search-fix() {
  zle vi-cmd-mode
  zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# Configure zsh-syntax-highlighting
# (Uses the defaults plus 'brackets', which tell if parens, etc. are unmatched)
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets)
source $HOME/.zfunctions/syntax-highlighting/zsh-syntax-highlighting.zsh
# Change comment color for Solarized color palette
ZSH_HIGHLIGHT_STYLES[comment]='fg=green,bold'


# man pages don't exist for zsh builtins (things like setopt, fg, bg, jobs,
# etc.). Including this snippet lets us run things like 'help setopt' to get
# help.
unalias run-help 2> /dev/null
autoload run-help
# (again, this path is specific to zsh installed through Homebrew)
HELPDIR=/usr/local/share/zsh/help
alias help="run-help"

