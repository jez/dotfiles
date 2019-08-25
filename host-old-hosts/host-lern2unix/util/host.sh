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

# Git aliases
alias gl='git log --graph --pretty="%C(bold green)%h%Creset%C(blue)%d%Creset %s"'
alias gla='git log --graph --pretty="%C(bold green)%h%Creset %C(yellow)%an%Creset%C(blue)%d%Creset %s"'

# ----- Prompt  ---------------------------------------------------------------

PROMPT_PURE_DIR_COLOR="%F{yellow}"

# ----- Miscellaneous ---------------------------------------------------------

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  # nothing host-specific to update!
  true
}
