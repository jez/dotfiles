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

[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

export PATH="$PATH:$HOME/.local/bin"

# Add diff-highlight from Git contrib
export PATH="$PATH:/home/linuxbrew/.linuxbrew/opt/git/share/git-core/contrib/diff-highlight"

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

alias sb='bazel build //main:sorbet'
alias sbl='bazel build'
alias sbg='bazel build //main:sorbet --config=dbg --config=static-libs'
alias sbo='bazel build //main:sorbet --config=debugsymbols --config=static-libs'
alias sbr='bazel build //main:sorbet --config=release-mac'
alias st='bazel test --test_output=errors --test_summary=terse test'
alias sto='bazel test --test_output=errors'
alias stg='bazel test --config=dbg --config=static-libs --test_output=errors --test_summary=terse test'
alias stog='bazel test --config=dbg --config=static-libs --test_output=errors'
export SORBET_SILENCE_DEV_MESSAGE=1

export TZ="America/Los_Angeles"

code() {
  arg1_real_path="$(realpath "$1")"
  echo "vscode://vscode-remote/ssh-remote+$REMOTE_NAME/$arg1_real_path"
}

# ----- Prompt  ---------------------------------------------------------------

if [ -f /pay/conf/mydev-remote-name ]; then
  REMOTE_NAME="$(< /pay/conf/mydev-remote-name)"
  export REMOTE_NAME

  export PROMPT_PURE_DIR_COLOR="%{$cmagentab%}"
  export TMUXLINE_ACCENT_COLOR="colour13"
else
  export PROMPT_PURE_DIR_COLOR="%{$cmagenta%}"
  export TMUXLINE_ACCENT_COLOR="colour05"
fi


# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  true
}
