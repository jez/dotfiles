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

export PATH="$PATH:$HOME/.local/bin"

# if [ -d "$HOME/.rbenv/bin" ]; then
#   export PATH="$HOME/.rbenv/bin:$PATH"
# fi
# if command -v rbenv &> /dev/null; then
#   eval "$(rbenv init -)"
#   rbenv rehash
# fi

# ----- aliases ---------------------------------------------------------------

# ----- Specific Programs -----------------------------------------------------

# Change my iTerm2 profile based on SOLARIZED variable
# See also: ~/.util/functions/itpt.sh
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi

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
