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
# export MANPATH="/Library/Developer/CommandLineTools/usr/share/man:$MANPATH"
# export MANPATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man:$MANPATH"

# Use GNU coreutils with their actual names
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# Tmux
# export MANPATH="/opt/homebrew/opt/tmux/share/man:$MANPATH"

# Add diff-highlight from Git contrib
export PATH="$PATH:/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"

export PATH="$PATH:$HOME/.local/bin"

# Globally installed yarn executables
# export PATH="$PATH:$HOME/.yarn/bin"
# export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# Find clangd from Homebrew, but put it last (fallback)
# export PATH="$PATH:$(brew --prefix)/opt/llvm/bin"

if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv rehash
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

# Override BSD grep with GNU equivalent
which ggrep &> /dev/null && alias grep="ggrep --color=auto";

# ignore jrnl entries (abuse histignorespace)
alias jrnl=" noglob jrnl"

alias todo='$EDITOR ~/notes/stream/todo.md +Goyo'
alias facecam='$EDITOR ~/notes/stream/facecam.txt +Goyo'
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
  echo "$cblueb==>$cwhiteb Updating Homebrew...$cnone"
  brew update

  echo "$cblueb==>$cwhiteb Checking Homebrew...$cnone"
  brew doctor

  echo "$cblueb==>$cwhiteb Checking for outdated brew packages...$cnone"
  brew outdated --verbose

}
