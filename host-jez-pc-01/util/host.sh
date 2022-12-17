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

if [ -d /home/linuxbrew/.linuxbrew ] && [ "$HOMEBREW_PREFIX" = "" ]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv | grep -v "export PATH")
fi

# Add diff-highlight from Git contrib
if [ "$DIFF_HIGHLIGHT_PATH" = "" ]; then
  export DIFF_HIGHLIGHT_PATH=/home/linuxbrew/.linuxbrew/opt/git/share/git-core/contrib/diff-highlight
  export PATH="$PATH:$DIFF_HIGHLIGHT_PATH"
fi

if [ "$NODE_MODULES_BIN_PATH" = "" ]; then
  export NODE_MODULES_BIN_PATH=./node_modules/.bin
  export PATH="$PATH:$NODE_MODULES_BIN_PATH"
fi

# Globally installed yarn executables
if [ "$YARN_BIN_PATH" = "" ]; then
  export YARN_BIN_PATH="$HOME/.yarn/bin"
  export PATH="$PATH:$YARN_BIN_PATH"
fi
if [ "$YARN_NODE_MODULES_PATH" = "" ]; then
  export YARN_NODE_MODULES_PATH="$HOME/.config/yarn/global/node_modules/.bin"
  export PATH="$PATH:$YARN_NODE_MODULES_PATH"
fi

if [ -d "$HOME/.rbenv" ] && [ "$RBENV_SHELL" = "" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv rehash
fi

# Rust
if [ "$CARGO_BIN" = "" ]; then
  export CARGO_BIN="$HOME/.cargo/bin"
  export PATH="$CARGO_BIN:$PATH"
fi

export TZ="/etc/localtime"

if command -v tic | grep -q linuxbrew; then
  export TERMINFO_DIRS="$(tic -D | tr '\n' ':' | sed -e 's/:$//')"
fi

# OCaml
if command opam &> /dev/null; then
  eval "$(opam env)"
fi

# Find clangd from Homebrew, but put it last (fallback)
if [ "$LLVM_PATH" = "" ]; then
  export LLVM_PATH="$HOMEBREW_PREFIX/opt/llvm/bin"
  export PATH="$PATH:$LLVM_PATH"
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

# TODO(jez) Linux
# alias sml="rlwrap sml"

# TODO(jez) Linux
# Override BSD grep with GNU equivalent
# which ggrep &> /dev/null && alias grep="ggrep --color=auto";

# TODO(jez) Linux
# ignore jrnl entries (abuse histignorespace)
# alias jrnl=" noglob jrnl"

alias todo='$EDITOR ~/notes/stream/todo.md +Goyo'
alias facecam='$EDITOR ~/notes/stream/facecam.txt +Goyo'
alias current-song=$'watch --interval 10 --no-title --color \'eval "$(sp eval)" && printf "🎵: $cgreen$SPOTIFY_TITLE$cnone\nBy: $ccyan$SPOTIFY_ARTIST$cnone"\''

alias sb='bazel build //main:sorbet -c opt'
alias sbl='bazel build -c opt'
alias sbg='bazel build //main:sorbet --config=dbg --config=static-libs'
alias sbgo='bazel build --config=dbg --config=static-libs'
alias sbo='bazel build //main:sorbet --config=debugsymbols -c opt --config=static-libs'
alias sbr='bazel build //main:sorbet --config=release-linux'
alias st='bazel test -c opt --test_output=errors --test_summary=terse test'
alias sto='bazel test -c opt --test_output=errors'
alias stg='bazel test --config=dbg --config=static-libs --test_output=errors --test_summary=terse test'
alias stog='bazel test --config=dbg --config=static-libs --test_output=errors'
export SORBET_SILENCE_DEV_MESSAGE=1

# TODO(jez) linux
# alias stacknewsimple="stack new ~/prog/haskell/jez-simple.hsfiles"
# alias stacknewstandard="stack new ~/prog/haskell/jez-standard.hsfiles"

# ----- Specific Programs -----------------------------------------------------

# Have Haskell Stack use XDG Base Directory spec
export STACK_ROOT="$XDG_DATA_HOME/stack"

# ----- Prompt  ---------------------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cblue%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$cmagentab%}"
export TMUXLINE_ACCENT_COLOR="colour04"

export HOMEBREW_NO_AUTO_UPDATE=1

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  true
}
