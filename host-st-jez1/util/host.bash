#
# host.bash - Host-specific, bash-specific configurations
#
# Usage
#   Source this file.
#

source ~/.util/skip-dirty.sh
# bash has no chpwd hook, so check before each prompt whether $PWD changed.
# Start from the current directory, keeping what a parent zsh exported, like
# zsh, whose chpwd doesn't run at startup either.
__skip_dirty_pwd=$PWD
__skip_dirty_chpwd() {
  if [ "$PWD" != "$__skip_dirty_pwd" ]; then
    __skip_dirty_pwd=$PWD
    skip_dirty_check
  fi
}
PROMPT_COMMAND="__skip_dirty_chpwd${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
