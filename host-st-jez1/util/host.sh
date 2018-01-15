#
# host.sh - Host-dependent configurations for "st-jez1.local":
#           Stripe-specific config
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file.
#
# Notes
#   Defines `update-host` which is called by auto-update.sh's `update`
#   function. Make sure to source this file before it.
#
# TODOs
#   - This file isn't as modular as it could be.

# ----- PATH and MANPATH ------------------------------------------------------

# Use GNU coreutils with their actual names
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Add diff-highlight from Git contrib
export PATH="$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/usr/local/sbin"

export PATH="$PATH:$HOME/.local/bin"

# Use Homebrew Python 2 as default 'python' binary
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# ----- From Stripe IT department ---------------------------------------------

export PATH="$HOME/stripe/henson/bin:$PATH"
source "$HOME/.rbenvrc"
rbenv rehash
source ~/.stripe-repos.sh

# ----- aliases ---------------------------------------------------------------

alias sml="rlwrap sml"

# Double double letters are hard
which coffee &> /dev/null && alias coffe="coffee"

# Use neovim for the lulz
alias vim="nvim -p"
alias vimdiff="nvim -d"

# Override BSD grep with GNU equivalent
which ggrep &> /dev/null && alias grep="ggrep --color=auto";

alias cdsc="cd ~/stripe/checkout-js"
alias cds="cd ~/stripe"

# ignore jrnl entries (abuse histignorespace)
alias jrnl=" jrnl"

alias todo='$EDITOR ~/stripe/notes/todo.md +Goyo'

# ----- Specific Programs -----------------------------------------------------

# Settings for virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null

# Have Haskell Stack use XDG Base Directory spec
export STACK_ROOT="$XDG_DATA_HOME/stack"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi

# ----- Prompt  ---------------------------------------------------------------

export PROMPT_PURE_SKIP_DIRTY_CHECK=1
export PROMPT_PURE_DIR_COLOR="%{$ccyan%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$cmagentab%}"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  echo "$cblueb==>$cwhiteb Updating Homebrew...$cnone"
  brew update

  echo "$cblueb==>$cwhiteb Checking Homebrew...$cnone"
  brew doctor

  echo "$cblueb==>$cwhiteb Checking for outdated brew packages...$cnone"
  brew outdated --verbose

}
