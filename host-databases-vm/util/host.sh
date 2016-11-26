#
# host.sh - Host-dependent configurations for "HOST"
#
# Description of file.
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#
# Notes
#
# TODOs

# ----- PATH, MANPATH, and LD_LIBRARY_PATH ------------------------------------

# ----- aliases ---------------------------------------------------------------

# Use neovim for the lulz
alias vim="nvim -p"
alias vimdiff="nvim -d"

# ----- Prompt  ---------------------------------------------------------------

PROMPT_PURE_DIR_COLOR="%F{blue}"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  # nothing host-specific to update!
}
