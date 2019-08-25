#
# host.sh - Host-dependent configurations for "ghost.zimmerman.io"
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

# ----- PATH and MANPATH ------------------------------------------------------

# ----- aliases ---------------------------------------------------------------
alias ack="ack-grep"

# ----- Prompt  ---------------------------------------------------------------

export PROMPT_PURE_DIR_COLOR="%{$cmagentab%}"
export PROMPT_PURE_SUCCESS_COLOR="%{$cmagentab%}"
export PROMPT_PURE_USERNAME_COLOR="%{$cmagentab%}"
export PROMPT_PURE_FAILURE_COLOR="%F{magenta}"

# ----- Miscellaneous ---------------------------------------------------------

update-host () {
  echo "$cblueb==>$cwhiteb Updating package lists...$cnone"
  sudo apt-get update

  echo "$cblueb==>$cwhiteb Checking for outdated packages...$cnone"
  # modified from http://unix.stackexchange.com/questions/19470/list-available-updates-but-do-not-install-them#comment111161_75791
  apt-get -s upgrade| awk -F'[][() ]+' "/^Inst/{printf \"${cwhiteb}Prog${cnone}: %s\t${credb}cur${cnone}: %s\t${cgreen}avail${cnone}: %s\n\", \$2,\$3,\$4}"
}
