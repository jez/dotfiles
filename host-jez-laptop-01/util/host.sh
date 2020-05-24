#
# host.sh - Host-dependent configurations for "jez-laptop-01":
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#

# ----- PATH and MANPATH ------------------------------------------------------

# Catalina
export MANPATH="/Library/Developer/CommandLineTools/usr/share/man:$MANPATH"
export MANPATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man:$MANPATH"

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

# Globally installed yarn executables
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv rehash

# SML/NJ
export PATH="$PATH:/usr/local/smlnj/bin"

# ----- aliases ---------------------------------------------------------------

alias sml="rlwrap sml"

# TODO(jez) Put this in a helper somewhere (used 3 places)
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

# TODO(jez) todo alias
# alias todo='$EDITOR ~/notes/stripe-todo.md +Goyo'
# alias notepad='$EDITOR ~/notes/scratch.txt +Goyo'

alias sb='bazel build //main:sorbet -c opt'
alias sbl='bazel build -c opt'
alias sbg='bazel build //main:sorbet --config=dbg --config=static-libs'
alias sbo='bazel build //main:sorbet --config=debugsymbols -c opt --config=static-libs'
alias sbr='bazel build //main:sorbet --config=release-mac'
alias st='bazel test -c opt --test_output=errors --test_summary=terse test'
alias sto='bazel test -c opt --test_output=errors'
alias stg='bazel test --config=dbg --config=static-libs --test_output=errors --test_summary=terse test'
alias stog='bazel test --config=dbg --config=static-libs --test_output=errors'
export SORBET_SILENCE_DEV_MESSAGE=1

# ----- Specific Programs -----------------------------------------------------

# TODO(jez) virtualenvwrapper
# # Settings for virtualenv and virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null

# Have Haskell Stack use XDG Base Directory spec
export STACK_ROOT="$XDG_DATA_HOME/stack"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi

# TODO(jez) OCaml
# # OCaml
# eval "$(opam env)"

# ----- Prompt  ---------------------------------------------------------------

# TODO(jez) Host colors
export PROMPT_PURE_DIR_COLOR="%{$ccyan%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$cmagentab%}"
export TMUXLINE_ACCENT_COLOR="colour06"

