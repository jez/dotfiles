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

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Catalina
export MANPATH="/Library/Developer/CommandLineTools/usr/share/man:$MANPATH"
export MANPATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man:$MANPATH"

# Use GNU coreutils with their actual names
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# Tmux
export MANPATH="/opt/homebrew/opt/tmux/share/man:$MANPATH"

# Use bison from Homebrew
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# Add diff-highlight from Git contrib
export PATH="$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight"
export PATH="$PATH:/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/usr/local/sbin"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/stripe/bin"

# Globally installed yarn executables
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# We're using thrift0.9 at Stripe
export PATH="$PATH:/opt/homebrew/opt/thrift@0.9/bin"

# Find clangd from Homebrew, but put it last (fallback)
export PATH="$PATH:$(brew --prefix)/opt/llvm/bin"

# For gcloud command, to deploy srb.help
export PATH="$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"

# This works, but I have no use for pyenv shims at the moment, so disabling to make things faster
# if command -v pyenv &> /dev/null; then
#   export PATH="$(pyenv root)/shims:$PATH"
#   pyenv rehash
# fi

# ----- From Stripe IT department ---------------------------------------------

export PATH="$HOME/stripe/henson/bin:$PATH"
export PATH="$PATH:$HOME/stripe/space-commander/bin"
load_module "$HOME/.rbenvrc"
# source ~/.stripe-repos.sh
# eval "$(nodenv init -)"

# ----- aliases ---------------------------------------------------------------

alias sml="rlwrap sml"

# Double double letters are hard
which coffee &> /dev/null && alias coffe="coffee"

if [ "$NVIM_LISTEN_ADDRESS" = "" ]; then
  alias vim="nvim -p"
  alias vimv="nvim -O"
  alias vimt="vim +term"
else
  alias vim="nvr -p"
  unalias vimv 2> /dev/null || true
  vimv() {
    case $# in
      0) nvr +tabnew ;;
      1) nvr -p "$1" ;;
      *) nvr -p "$1" && shift && nvr -O "$@" ;;
    esac
  }
fi

alias vimdiff="nvim -d"

# Override BSD grep with GNU equivalent
which ggrep &> /dev/null && alias grep="ggrep --color=auto";

alias stop-servers='pay exec sudo svc -d /etc/service/scripts_bin_servers_daemon/'
alias start-servers='pay exec sudo svc -u /etc/service/scripts_bin_servers_daemon/'

# ignore jrnl entries (abuse histignorespace)
alias jrnl=" noglob jrnl"

alias todo='$EDITOR ~/notes/stripe-todo.md +Goyo'
alias notepad='$EDITOR ~/notes/scratch.txt +Goyo'
alias brag=' jrnl brag'
alias viewbrag='viewjrnl brag'

alias sb='bazel build //main:sorbet -c opt'
alias sbg='bazel build //main:sorbet --config=dbg'
alias sbo='bazel build //main:sorbet --config=debugsymbols -c opt'
alias sbr='bazel build //main:sorbet --config=release-mac'
alias st='bazel test -c opt --test_output=errors --test_summary=terse test'
alias sto='bazel test -c opt --test_output=errors'
alias stg='bazel test --config=dbg --test_output=errors --test_summary=terse test'
alias stog='bazel test --config=dbg --test_output=errors'
export SORBET_SILENCE_DEV_MESSAGE=1

alias stacknewsimple="stack new ~/prog/haskell/jez-simple.hsfiles"
alias stacknewstandard="stack new ~/prog/haskell/jez-standard.hsfiles"

alias hubcio="hub ci-status --format '%U%n' | head -n 1 | xargs open"
alias hubcisips="hub ci-status --format '%t %U%n' | grep '^stripe-internal-pay-server ' | cut -d' ' -f 2 | xargs open"

alias paycifix='LESS=-RFX pay ci:fix "$(hub ci-status --format "%U%n" | head -n 1 | sed -e "s+https://cibot.corp.stripe.com/builds/++")"'

# ----- Specific Programs -----------------------------------------------------

# Settings for virtualenv and virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/stripe
source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null

# Have Haskell Stack use XDG Base Directory spec
export STACK_ROOT="$XDG_DATA_HOME/stack"

# Rust
# export PATH="$HOME/.cargo/bin:$PATH"
export CARGO_HOME="/Users/$USER/stripe/cargo"
export RUSTUP_HOME="/Users/$USER/stripe/rustup"
export PATH="$PATH:/Users/$USER/stripe/cargo/bin"

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
# if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
#   echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
# fi

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export CGO_CFLAGS="-I/usr/local/include"
export CGO_LDFLAGS="-L/usr/local/lib"

# # nvm
# export NVM_DIR="$HOME/.nvm"
# source "$(brew --prefix nvm)/nvm.sh"

# OCaml
# eval "$(opam env)"

# rtags
# rc is the rtags client, and uses the same config filename as rcm
alias rc="rc --no-rc"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export HOMEBREW_NO_AUTO_UPDATE=1
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
