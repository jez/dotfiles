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

# TODO(jez)
# Add diff-highlight from Git contrib
export PATH="$PATH:/home/linuxbrew/.linuxbrew/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"

export PATH="$PATH:$HOME/.local/bin"

# Globally installed yarn executables
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# TODO(jez) rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# rbenv rehash

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi

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

alias sb='bazel build //main:sorbet -c opt'
alias sbg='bazel build //main:sorbet --config=dbg --config=static-libs'
alias sbo='bazel build //main:sorbet --config=debugsymbols -c opt --config=static-libs'
alias sbr='bazel build //main:sorbet --config=release-mac'
alias st='bazel test -c opt --test_output=errors --test_summary=terse test'
alias sto='bazel test -c opt --test_output=errors'
alias stg='bazel test --config=dbg --config=static-libs --test_output=errors --test_summary=terse test'
alias stog='bazel test --config=dbg --config=static-libs --test_output=errors'
export SORBET_SILENCE_DEV_MESSAGE=1

# ----- Specific Programs -----------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cgreen%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$ccyan%}"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  true
}
