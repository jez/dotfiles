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

# Computer Club contributed software
export PATH="/afs/club/contrib/bin:$PATH";
export MANPATH="$MANPATH:/afs/club.cc.cmu.edu/contrib/man"
# This might be really bad (overwrites LD_LIBRARY_PATH)
export LD_LIBRARY_PATH="/afs/club.cc.cmu.edu/contrib/lib"

# GPI contributed software
export PATH="$PATH:/afs/cs.cmu.edu/academic/class/15131-f15/bin"
export MANPATH="$MANPATH:/afs/cs.cmu.edu/academic/class/15131-f15/share/man"

# 15-418 C++ build environment
export PATH="$PATH:/usr/local/ispc"
export PATH="/usr/local/cuda-6.5/bin:$PATH"
export PATH="/usr/lib64/openmpi/bin:$PATH"

# 15-415 environment
export PGPORT=50173
export PGHOST=/tmp
alias startpg415="pg_ctl -D $HOME/private/15415/db415 -o '-k /tmp' start"
alias stoppg415="pg_ctl -D $HOME/private/15415/db415 stop"

# 15-210 staff (doit library)
export PATH="$PATH:/afs/cs.cmu.edu/academic/class/15210-s16/bin/"
export PYTHONPATH="$PYTHONPATH:/afs/cs.cmu.edu/academic/class/15210-s16/lib/"

export LD_LIBRARY_PATH="/usr/local/cuda-6.5/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/lib64/openmpi/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="./lib:$LD_LIBRARY_PATH"

# ----- aliases ---------------------------------------------------------------

# rlwrap for vim keybindings and line history
alias sml="rlwrap sml"

# Git aliases
alias gl='git log --graph --pretty="%C(bold green)%h%Creset%C(blue)%d%Creset %s"'
alias gla='git log --graph --pretty="%C(bold green)%h%Creset %C(yellow)%an%Creset%C(blue)%d%Creset %s"'

# ----- Prompt  ---------------------------------------------------------------

PROMPT_PURE_DIR_COLOR="%F{green}"

# ----- Miscellaneous ---------------------------------------------------------

# Don't let people write messages to me
mesg n

# update-host
# Usage:
#     update-host
#
# You should never have to call this. It's called when you call `update`
update-host () {
  # nothing host-specific to update!
}
