#
# host.sh - Host-dependent configurations for "jakez-mbp"
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

# ----- aliases ---------------------------------------------------------------

# Double double letters are hard
which coffee &> /dev/null && alias coffe="coffee"

# Use neovim for the lulz
alias vim="nvim -p"

# Override BSD grep with GNU equivalent
which ggrep &> /dev/null && alias grep="ggrep --color=auto";

export COMPOSER_HOME="$HOME/src/composer"
alias vsv="$COMPOSER_HOME/bin/vm/sv"
alias vmsh="$COMPOSER_HOME/bin/vm/vmsh"

# ----- Prompt  ---------------------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cmagentab%}"

# ----- Miscellaneous ---------------------------------------------------------

# cd to project root directory
alias cdr="cd ~/src/composer"

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
