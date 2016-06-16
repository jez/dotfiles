#
# host.sh - Host-dependent configurations for "Jacobs-MacBook-Air"
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

# Android and Processing...
export ANDROID_HOME="/Users/jake/Library/Android/sdk"
export PATH="$PATH:/Users/jake/Library/Android/sdk/platform-tools:/Users/jake/Library/Android/sdk/tools"

export PATH="$PATH:$HOME/.local/bin"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Disable Homebrew analytics until Homebrew/brew#145 is addressed
export HOMEBREW_NO_ANALYTICS=1

# ----- aliases ---------------------------------------------------------------

# OS X has an annoying tendency of trying to change your hostname.
# Run this to get it back.
alias resethostname='sudo scutil --set HostName Jacobs-MacBook-Air'

alias kinitandrew="kinit jezimmer@ANDREW.CMU.EDU"
alias ka="kinitandrew"

alias sml="rlwrap sml"

# Double double letters are hard
which coffee &> /dev/null && alias coffe="coffee"

# Use neovim for the lulz
alias vim="nvim -p"
alias vimdiff="nvim -d"

# Override BSD grep with GNU equivalent
which ggrep &> /dev/null && alias grep="ggrep --color=auto"

# ignore jrnl entries (abuse histignorespace)
alias jrnl=" jrnl"

# ----- Ruby, Python, and Haskell ---------------------------------------------

# ruby...
# To use Homebrew's directories rather than ~/.rbenv
export RBENV_ROOT="/usr/local/var/rbenv"
eval "$(rbenv init -)"

# Settings for virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null

# Have Haskell Stack use XDG Base Directory spec
export STACK_ROOT="$XDG_DATA_HOME/stack"

# ----- Prompt  ---------------------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cmagentab%}"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  echo "$cblueb==>$cwhiteb Renewing Kerberos ticket...$cnone"
  kinitandrew

  echo "$cblueb==>$cwhiteb Updating Homebrew...$cnone"
  brew update

  echo "$cblueb==>$cwhiteb Checking Homebrew...$cnone"
  brew doctor

  echo "$cblueb==>$cwhiteb Checking for outdated brew packages...$cnone"
  brew outdated --verbose

  echo "$cblueb==>$cwhiteb Checking for outdated npm packages...$cnone"
  npm -g outdated

  echo "$cblueb==>$cwhiteb Checking for outdated pip packages...$cnone"
  pip list --outdated

  echo "$cblueb==>$cwhiteb Checking for outdated pip3 packages...$cnone"
  pip3 list --outdated

}
