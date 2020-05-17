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

export PATH="$PATH:./node_modules/.bin"

export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib"

# Globally installed yarn executables
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv rehash

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
if [ "$TERM_PROGRAM" = "iTerm.app" ] || [ "$LC_TERMINAL" = "iTerm2" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi

export TZ=/usr/share/zoneinfo/America/Chicago
export LANG="en_US.utf8"
export LC_CTYPE="en_US.utf8"

# ----- aliases ---------------------------------------------------------------

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

# open Vim directly to Goyo mode (distraction-free writing mode)
alias vimg="nvim +Goyo"

alias open="xdg-open"
alias pbcopy="xclip -in -sel clip"
alias pbpaste="xclip -out -sel clip"

alias sb='bazel build //main:sorbet'
alias sbl='bazel build'
alias sbg='bazel build //main:sorbet --config=dbg'
alias sbo='bazel build //main:sorbet --config=debugsymbols'
alias sbr='bazel build //main:sorbet --config=release-linux'
alias st='bazel test --test_output=errors --test_summary=terse test'
alias sto='bazel test --test_output=errors'
alias stg='bazel test --config=dbg --test_output=errors --test_summary=terse test'
alias stog='bazel test --config=dbg --test_output=errors'
export SORBET_SILENCE_DEV_MESSAGE=1

# ----- Specific Programs -----------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cmagentab%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$ccyan%}"
export TMUXLINE_ACCENT_COLOR="colour13"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  true
}
