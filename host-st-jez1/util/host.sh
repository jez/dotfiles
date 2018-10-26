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

# Use bison from Homebrew
export PATH="/usr/local/opt/bison/bin:$PATH"

# Add diff-highlight from Git contrib
export PATH="$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/usr/local/sbin"

export PATH="$PATH:$HOME/.local/bin"

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
alias jrnl=" noglob jrnl"

alias todo='$EDITOR ~/notes/stripe-todo.md +Goyo'
alias notepad='$EDITOR ~/notes/scratch.txt +Goyo'

alias sb='bazel build //main:sorbet --config=dbg'
alias sbo='bazel build //main:sorbet --config=debugsymbols -c opt'
alias sbr='bazel build //main:sorbet --config=release'
alias st='bazel test //... --config=dbg --test_output=errors'
sto() {
  bazel test "$1" --config=dbg --test_output=errors "${@:2}"
}

alias stacknewsimple="stack new ~/prog/haskell/jez-simple.hsfiles"
alias stacknewstandard="stack new ~/prog/haskell/jez-standard.hsfiles"

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

# Go
export GOPATH="$HOME/golang"
export PATH="$PATH:$GOPATH/bin"
export CGO_CFLAGS="-I/usr/local/include"
export CGO_LDFLAGS="-L/usr/local/lib"

# # nvm
# export NVM_DIR="$HOME/.nvm"
# source "$(brew --prefix nvm)/nvm.sh"

# OCaml
eval $(opam config env)

# rtags
# rc is the rtags client, and uses the same config filename as rcm
alias rc="rc --no-rc"

# ----- Prompt  ---------------------------------------------------------------

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
