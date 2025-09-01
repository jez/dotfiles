#
# host.sh - Host-dependent configurations for "jez-raspberry-pi-03.local":
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

# Add diff-highlight from Git contrib
export PATH="$PATH:/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"

export PATH="$PATH:$HOME/.local/bin"

if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init -)"
  rbenv rehash
fi

# ----- aliases ---------------------------------------------------------------

alias vimdiff="nvim -d"


alias stacknewsimple="stack new ~/prog/haskell/jez-simple.hsfiles"
alias stacknewstandard="stack new ~/prog/haskell/jez-standard.hsfiles"

alias hubcio="hub ci-status --format '%U%n' | head -n 1 | xargs open"

# ----- Specific Programs -----------------------------------------------------

# Have Haskell Stack use XDG Base Directory spec
export STACK_ROOT="$XDG_DATA_HOME/stack"

# Rust
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="$PATH:$HOME/.cargo/bin"

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi

export HOMEBREW_NO_AUTO_UPDATE=1
# ----- Prompt  ---------------------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cmagenta%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$ccyan%}"
export TMUXLINE_ACCENT_COLOR="colour05"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  true
}
